const std = @import("std");
const testing = std.testing;

pub const ClockObject = packed struct {
    hour: u5, // 0-23
    minute: u7, // 0-99, yes 99.
    second: u6,
    minuteSpill: u7,
};

fn tick(obj: ClockObject) void {
    _ = obj.hour;
}

fn new(minuteSpill: u7) ClockObject {
    var obj = ClockObject{ .minuteSpill = minuteSpill, .hour = 0, .minute = 0, .second = 0 };

    return obj;
}

//

export fn allocPtr(minuteSpill: u8) *ClockObject {
    var ptr: *ClockObject = std.heap.page_allocator.create(ClockObject) catch @panic("memory allocation failed");
    ptr.minuteSpill = @truncate(u7, minuteSpill);
    return ptr;
}

export fn freePtr(ptr: *ClockObject) void {
    std.heap.page_allocator.destroy(ptr);
}

export fn setPtr(obj: *ClockObject, hour: u8, minute: u8, second: u8) void {
    obj.hour = @truncate(u5, hour);
    obj.minute = @truncate(u7, minute);
    obj.second = @truncate(u6, second);
}

export fn tickPtr(ptr: *ClockObject) void {
    tick(ptr.*);
}

// export fn getTime() []const u8 {}

// export fn getTimes() [*]const u8 {}

export fn add(a: i32, b: i32) i32 {
    return a + b;
}

test "basic add functionality" {
    try testing.expect(add(3, 7) == 10);
}
