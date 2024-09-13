`define ARMED   2'b00
`define ACTIVE  2'b01
`define WAIT    2'b10

module wave_capture (
    input clk,
    input reset,
    input new_sample_ready,
    input [15:0] new_sample_in,
    input wave_display_idle,

    output wire [8:0] write_address,
    output wire write_enable,
    output wire [7:0] write_sample,
    output wire read_index
);

    // Flip flop for the sample that is incoming and enabled when new sample is ready
    wire [7:0] active_sample;
    dffre #(.WIDTH(16)) sampff(
        .clk(clk), 
        .r(reset), 
        .en(new_sample_ready), 
        .d(new_sample_in[15:8]),
        .q(active_sample)
    );

    // Flip flop for FSM (armed, active, wait)
    wire [1:0] state;
    reg [1:0] next_state;
    dffr #(.WIDTH(2)) stateff(
        .clk(clk),
        .r(reset),
        .d(next_state),
        .q(state)
    );

    // Flip flop for the read index
    dffre #(.WIDTH(1)) readff(
        .clk(clk),
        .r(reset),
        .en(state == `WAIT && wave_display_idle),
        .d(~read_index),
        .q(read_index)
    );

    // Flip flop for counting 128 for capturing in RAM
    wire [7:0] count;
    dffre #(.WIDTH(8)) countff(
        .clk(clk),
        .r(reset || state == `WAIT),
        .en(state == `ACTIVE && new_sample_ready),
        .d(count + 1),
        .q(count)
    );

    // Manipulation of write_address, enable, and sample
    assign write_address = {~read_index, count};
    assign write_enable = (state == `ACTIVE);
    assign write_sample = active_sample + 8'b10000000;

    // Case statements for the FSM to change states
    always @(*) begin
        case(state)
            `ARMED: next_state = (~new_sample_in[15] && active_sample[7]) ? `ACTIVE : `ARMED;
            `ACTIVE: next_state = (count == 8'b11111111) ? `WAIT : `ACTIVE;
            `WAIT: next_state = (wave_display_idle) ? `ARMED : `WAIT;
            default: next_state = `ARMED;
        endcase
    end

endmodule
