module wave_display (
    input clk,
    input reset,
    input [10:0] x,  // [0..1279]
    input [9:0]  y,  // [0..1023]
    input valid,
    input [7:0] read_value,
    input read_index,
    output wire [8:0] read_address,
    output wire valid_pixel,
    output wire [7:0] r,
    output wire [7:0] g,
    output wire [7:0] b
);
    reg [8:0] x_addr;
    assign read_address = x_addr;

    // Logic for calling the right address in the RAM
    always @(*) begin
        case(x[10:8])
            3'b001: x_addr = {read_index, 1'b0, x[7:1]};
            3'b010: x_addr = {read_index, 1'b1, x[7:1]};
            default: x_addr = 9'b0;
        endcase 
    end    

    // Extra flip flop to delay the upper and lower bounds
    wire [1:0] count;
    dffr #(.WIDTH(2)) ffcount(
        .clk(clk),
        .r(reset),
        .d(count + 1),
        .q(count)
    );

    // Logic to move the sine wave in the right quadrant
    wire [7:0] read_value_adjusted = (read_value >> 1) + 8'd32;
    
    // RAM read value flip flop
    wire [7:0] prev_read;
    dffre #(.WIDTH(8)) ffreadval(
        .clk(clk),
        .r(reset),
        .en(count == 0 && (prev_read != read_value_adjusted)),
        .d(read_value_adjusted),
        .q(prev_read)
    );
   
    // Quadrant Logic
    // XOR of x[9:8] 01 or 10 is valid; 00 and 11 are not
    // y[9] must be 0
    wire in_quad = (~x[10] & ^x[9:8] & ~y[9]);    

    // Protection logic for when sine wave decreases
    wire [7:0] upper = (prev_read > read_value_adjusted) ? prev_read : read_value_adjusted;
    wire [7:0] lower = (prev_read > read_value_adjusted) ? read_value_adjusted : prev_read;

    // Output valid_pixel when within the upper and lower bounds
    assign valid_pixel = (upper >= y[8:1]) && (lower <= y[8:1]) && in_quad && valid;
    
    // Pixel Colors
    assign r = (valid_pixel) ? 8'hFF : 8'h0;
    assign g = (valid_pixel) ? 8'hFF : 8'h0;
    assign b = (valid_pixel) ? 8'hFF : 8'h0;
endmodule
