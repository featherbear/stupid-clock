const std = @import("std");

pub fn build(b: *std.build.Builder) void {
    const lib = b.addSharedLibrary("stupidClock", "src/main.zig", b.version(0, 0, 0));
    lib.setBuildMode(std.builtin.Mode.ReleaseSmall);
    lib.setTarget(.{ .cpu_arch = .wasm32, .os_tag = .freestanding });
    lib.install();

    //

    const main_tests = b.addTest("src/main.zig");
    main_tests.setBuildMode(std.builtin.Mode.Debug);

    const test_step = b.step("test", "Run library tests");
    test_step.dependOn(&main_tests.step);
}
