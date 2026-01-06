const std = @import("std");
const posix = std.posix;
const Io = std.Io;

pub fn Handler(comptime sig: posix.SIG) type {
    return struct {
        var awaiter_io: Io = undefined;
        var awaiter_cond: Io.Condition = .{};
        var awaiter_mutex: Io.Mutex = .init;

        pub fn wait(io: Io) Io.Future(void) {
            awaiter_io = io;

            // 跨平台适配：Windows 跳过 sigaction（无实现），POSIX 保留原逻辑
            if (std.Target.current.os.tag != .windows) {
                // 修正：显式声明 sigaction_t 结构体，而非匿名初始化
                const act = posix.sigaction_t{
                    .handler = .{ .handler = sigHandler },
                    .mask = @splat(0),
                    .flags = 0,
                };
                // 原代码未处理错误，这里补充 errdefer（保留原逻辑的同时避免编译警告）
                posix.sigaction(sig, &act, null) catch |err| {
                    std.log.warn("sigaction failed for signal {}: {}", .{ sig, err });
                };
            } else {
                // Windows 平台：空实现（或按需添加 Windows 信号处理）
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
