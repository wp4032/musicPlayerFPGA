/*
 * Module: divide
 * Performs division using bitwise shifts for divisors that are powers of 2.
 *
 * Inputs:
 * - numerator: 16-bit dividend.
 * - a, b, c, d: 4-bit divisor components controlling the shift amount.
 *
 * Output:
 * - out: 16-bit result of the division.
 *
 * Details:
 * - Division is simulated by shifting the numerator based on divisor components.
 * - If 'a' is zero, the numerator is returned; for 'b', 'c', 'd', zero is returned.
 * - Final output is the sum of these shifted values.
 *
 * Note:
 * - Precision loss possible for non-power of 2 divisors.
 * - Not designed for general division by zero handling.
 */

module divide(
    input clk,
    input reset,
    input [15:0] numerator,
    input [3:0] a,
    input [3:0] b,
    input [3:0] c,
    input [3:0] d,
    output wire signed [15:0] dout
);
    wire signed [15:0] a_add, b_add, c_add, d_add;
    wire signed [15:0] num;
    assign num = (numerator[15] == 1) ? -numerator : numerator;


    // If a is 0, we return the numerator
    assign a_add = (a == 0) ? num : (num >> a);
    // If b, c, and d are zero, we return zero
    assign b_add = (b == 0 | b == 15) ? 16'b0 : (num >> b);
    assign c_add = (c == 0 | c == 15) ? 16'b0 : (num >> c);
    assign d_add = (d == 0 | d == 15) ? 16'b0 : (num >> d);
    // We can do division by doing numerator * (2^-a + 2^-b + 2^-c + 2^-d)


    // Pipelining to reduce timing issues
    wire signed [15:0] a_add_pipe, b_add_pipe, c_add_pipe, d_add_pipe;
    wire old_num;

    dffr #(1) num_pipeline(
        .clk(clk),
        .r(reset),
        .d(numerator[15]),
        .q(old_num)
    );

    dffr #(16) a_pipeline(
        .clk(clk),
        .r(reset),
        .d(a_add),
        .q(a_add_pipe)
    );

    dffr #(16) b_pipeline(
        .clk(clk),
        .r(reset),
        .d(b_add),
        .q(b_add_pipe)
    );

    dffr #(16) c_pipeline(
        .clk(clk),
        .r(reset),
        .d(c_add),
        .q(c_add_pipe)
    );

    dffr #(16) d_pipeline(
        .clk(clk),
        .r(reset),
        .d(d_add),
        .q(d_add_pipe)
    );

    wire signed [15:0] dout1, dout2;
    wire signed [15:0] dout1_pipe, dout2_pipe;
    assign dout1 = (old_num) ? -(a_add_pipe + b_add_pipe) : a_add_pipe + b_add_pipe;
    assign dout2 = (old_num) ? -(c_add_pipe + d_add_pipe) : c_add_pipe + d_add_pipe;

    // Further pipelining to reduce timing issues
    dffr #(32) dout_pipeline(
        .clk(clk),
        .r(reset),
        .d({dout1, dout2}),
        .q({dout1_pipe, dout2_pipe})
    );

    assign dout = dout1_pipe + dout2_pipe;

endmodule
