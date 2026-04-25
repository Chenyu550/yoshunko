const std = @import("std");
const Io = std.Io;
const native_os = @import("builtin").os.tag;

// On Windows, sig is ignored entirely; on other platforms it must be posix.SIG
pub fn Handler(comptime sig: anytype) type {
    return struct {
        var awaiter_io: Io = undefined;
        var awaiter_cond: Io.Condition = .{};
        var awaiter_mutex: Io.Mutex = .init;

        pub fn wait(io: Io) Io.Future(void) {
            awaiter_io = io;

            if (native_os == .windows) {
                _ = std.os.windows.kernel32.SetConsoleCtrlHandler(&ctrlHandler, 1);
            } else {
                const posix = std.posix;
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

        fn sigHandler(s: c_int) callconv(.c) void {
            _ = s;
            awaiter_cond.signal(awaiter_io);
        }

        fn ctrlHandler(ctrl_type: std.os.windows.DWORD) callconv(.winapi) std.os.windows.BOOL {
            // CTRL_C_EVENT = 0, CTRL_BREAK_EVENT = 1
            if (ctrl_type == 0 or ctrl_type == 1) {
                awaiter_cond.signal(awaiter_io);
                return 1;
            }
            return 0;
        }
    };
}
