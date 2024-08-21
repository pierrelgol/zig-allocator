const std = @import("std");
const RawAllocator = @import("root.zig").RawAllocator;
const c_allocator = std.heap.c_allocator;

pub fn main() !void {
    var allocator = RawAllocator{};
    const buffer = try allocator.alloc(1024);
    defer allocator.free(buffer.?[0..1024]);
}
