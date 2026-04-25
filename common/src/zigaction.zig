const std = @import("std");
const posix = std.posix;
const Io = std.Io;
const native_os = @import("builtin").os.tag;

pub fn Handler(comptime sig: if (native_os == .windows) u32 else posix.SIG) type {
    return struct {
        var awaiter_io: Io = undefined;
        var awaiter_cond: Io.Condition = .{};
        var awaiter_mutex: Io.Mutex = .init;

        pub fn wait(io: Io) Io.Future(void) {
            awaiter_io = io;

            if (native_os == .windows) {
                const windows = std.os.windows;
                _ = windows.kernel32.SetConsoleCtrlHandler(&ctrlHandler, 1);
            } else {
                posix.sigaction(sig, &.{
                    .handler = .{ .handler = sigHandler },
                    .mask = @splat(0),
                    .flags = 0,
                }, null);
            }

            awaiter_mutex.lockUncancelable(io);
            const wait_args = .{ &awaiter_cond, awaiter_io, &awaiter_mutex };
            return io.concurrent(Io.Condition.waitUncancelable, wait_args) catch
                io.async(Io.Condition.waitUncancelable, wait_args);
        }

        fn sigHandler(_: posix.SIG) callconv(.c) void {
            awaiter_cond.signal(awaiter_io);
        }

        fn ctrlHandler(ctrl_type: std.os.windows.DWORD) callconv(.winapi) std.os.windows.BOOL {
            // CTRL_C_EVENT = 0, CTRL_BREAK_EVENT = 1
            if (ctrl_type == 0 or ctrl_type == 1) {
                awaiter_cond.signal(awaiter_io);
                return 1; // TRUE，表示已处理
            }
            return 0; // FALSE，交给下一个处理器
        }
    };
}
