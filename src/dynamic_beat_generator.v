module dynamic_generator(
    input clk,
    input reset,
    input en,
    output wire beat
);
    parameter WIDTH = 8;
    parameter STOP = 250;

    wire [WIDTH-1:0] count;
    dffre #(WIDTH) counter (
        .clk(clk),
        .en(en),
        .r(reset | (count == STOP)),
        .d(count + 1'b1),
        .q(count)
    );

    assign beat = (count == STOP);

endmodule