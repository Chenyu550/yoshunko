const std = @import("std");
const posix = std.posix;
const Io = std.Io;
// 关键：直接导入 builtin 模块（Zig 语言内置，非 std 下的）
const builtin = @import("builtin");

pub fn Handler(comptime sig: posix.SIG) type {
    return struct {
        var awaiter_io: Io = undefined;
        var awaiter_cond: Io.Condition = .{};
        var awaiter_mutex: Io.Mutex = .init;

        pub fn wait(io: Io) Io.Future(void) {
            awaiter_io = io;

            // 核心修复：用 @import("builtin").target 替代 std 下的路径
            if (builtin.target.os.tag != .windows) {
                // 显式声明 sigaction_t 结构体，修正原匿名初始化语法
                const act = posix.sigaction_t{
                    .handler = .{ .handler = sigHandler },
                    .mask = @splat(0),
                    .flags = 0,
                };
                // 补充错误处理（避免编译警告）
                posix.sigaction(sig, &act, null) catch |err| {
                    std.log.warn("sigaction failed for signal {}: {}", .{ sig, err });
                };
            } else {
                // Windows 平台空实现（避免 sigaction 编译错误）
                std.log.debug("Windows: sigaction not supported, skip signal handler setup", .{});
            }

            awaiter_mutex.lockUncancelable(io);
            const wait_args = .{ &awaiter_cond, awaiter_io, &awaiter_mutex };
            return io.concurrent(Io.Condition.waitUncancelable, wait_args) catch
                io.async(Io.Condition.waitUncancelable, wait_args);
        }

        fn sigHandler(_: posix.SIG) callconv(.c) void {
            awaiter_cond.signal(awaiter_io);
        }
    };
}
