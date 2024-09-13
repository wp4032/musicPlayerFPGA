module rt_noteplayer(
    input clk,
    input reset,
    input play_enable,              // When high we play, when low we don't.
    input [5:0] note_to_load,       // The note to play
    input beat,                     // This is our 1/48th second beat
    input generate_next_sample,     // Tells us when the codec wants a new sample
    output [15:0] sample_out,       // Our sample output
    output new_sample_ready         // Tells the codec when we've got a sample
);

    wire [19:0] step_size;
    wire [5:0] freq_rom_in;

    dffre #(.WIDTH(6)) freq_reg (
        .clk(clk),
        .r(reset),
        .en(1),
        .d(note_to_load),
        .q(freq_rom_in)
    );

    frequency_rom freq_rom(
        .clk(clk),
        .addr(freq_rom_in),
        .dout(step_size)
    );

    sine_reader sine_read(
        .clk(clk),
        .reset(reset),
        .step_size(step_size),
        .generate_next(generate_next_sample),
        .sample_ready(new_sample_ready),
        .sample(sample_out)
    );

    wire [3:0] state, next_state;
    dffre #(.WIDTH(4)) state_reg (
        .clk(clk),
        .r(reset),
        .en(beat),
        .d(next_state),
        .q(state)
    );
    assign next_state = (reset || done_with_note) ? 4'h8 : state - 1;

    wire done_with_note;
    assign done_with_note = (state == 4'h0) && beat;

endmodule