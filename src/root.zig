const std = @import("std");
const testing = std.testing;

extern fn _malloc(size: usize) callconv(.C) ?*u8;
extern fn _free(ptr: ?[*]u8) callconv(.C) void;
extern fn _realloc(ptr: [*]u8, size: usize) callconv(.C) ?*u8;
extern fn _calloc(nmemb: usize, size: usize) callconv(.C) ?*u8;

pub const RawAllocator = struct {
    const Self = @This();

    pub fn alloc(_: *Self, len: usize) !?[*]u8 {
        return @as(?[*]u8, @ptrCast(_malloc(len)));
    }

    pub fn free(_: *Self, ptr: []u8) void {
        _free(ptr.ptr);
    }

    pub fn realloc(_: *Self, old_mem: []u8, new_len: usize) !?[*]u8 {
        const ptr = _realloc(old_mem.ptr, new_len);
        return @as(?[*]u8, @ptrCast(ptr));
    }
};
