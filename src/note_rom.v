module note_rom (
    input clk,
    input [3:0] addr,
    output reg [5:0] dout // dout = {a, b, c, d, e, f, g, h}
);

    wire [5:0] memory [15:0];

    always @(posedge clk)                       
        dout = memory[addr];   

    assign memory[   0  ] = {6'd0};   // Note: N/A
    assign memory[   1  ] = {6'd40};   // Note: 4C
    assign memory[   2  ] = {6'd42};   // Note: 4D
    assign memory[   3  ] = {6'd44};   // Note: 4E
    assign memory[   4  ] = {6'd45};   // Note: 4F
    assign memory[   5  ] = {6'd47};   // Note: 4G
    assign memory[   6  ] = {6'd49};   // 5A
    assign memory[   7  ] = {6'd51};   // Note: 5B
    assign memory[   8  ] = {6'd52};   // Note: 5C


    assign memory[   9  ] = {6'd0};   // Note: 1E
    assign memory[  10  ] = {6'd0};   // Note: 5F
    assign memory[  11  ] = {6'd0};   // Note: 1F
    assign memory[  12  ] = {6'd0};   // Note: 5G
    assign memory[  13  ] = {6'd0 };   // Note: 1G
    assign memory[  14  ] = {6'd0};   // Note: 2A
    assign memory[  15  ] = {6'd0};   // Note: 3A

endmodule