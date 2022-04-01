const std = @import("std");

const GroceryItem = struct {
    name: []const u8,
    quantity: u8,
    tax_rate: []const u8,
    is_taxable: []const u8,

    pub fn init(container: []u8) GroceryItem {
        var it = std.mem.tokenize(u8, container, " ");

        return GroceryItem{
            .name = it.next().?,
            .quantity = std.fmt.parseUnsigned(u8, it.next().?, 10),
            .tax_rate = it.next().?,
            .is_taxable = it.next().?,
        };
    }
};

pub fn main() anyerror!void {
    const stdout = std.io.getStdOut().writer();

    var file = try std.fs.cwd().openFile("inputs/shipment.txt", .{});

    defer file.close();

    var buf_reader = std.io.bufferedReader(file.reader());

    var in_stream = buf_reader.reader();

    var buf: [1024]u8 = undefined;

    while (try in_stream.readUntilDelimiterOrEof(&buf, '\n')) |line| {
        const x = GroceryItem.init(line);
        try stdout.print("{s}\n", .{x.name});
    }
}
