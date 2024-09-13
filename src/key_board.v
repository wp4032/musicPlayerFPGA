module key_board(
    input clk,
    input reset,
    input enable,
    input beat,
    input generate_next_sample,
    input [3:0] key_val,
    output [15:0] key_note_sample,
    output key_note_sample_ready
);

    // //decodes
    wire [5:0] note;
    note_rom note_rom(.clk(clk), .addr(key_val), .dout(note));

    // and plays
    rt_noteplayer rt_noteplayer(
        .clk(clk),
        .reset(reset),
        .play_enable(enable),
        .note_to_load(note),
        .beat(beat),
        .generate_next_sample(generate_next_sample),
        .sample_out(key_note_sample),
        .new_sample_ready(key_note_sample_ready)
    );

endmodule