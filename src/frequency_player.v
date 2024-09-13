module frequency_player(
    input clk,
    input reset,
    input play_enable,              // When high we play, when low we don't.
    input [19:0] frequency_to_load, // The frequency to play (step size)
    input [5:0] duration_to_load,   // The duration of the note to play
    input load_new_note,            // Tells us when we have a new note to load
    output done_with_note,          // When we are done with the note this stays high.
    input beat,                     // This is our 1/48th second beat
    input generate_next_sample,     // Tells us when the codec wants a new sample
    output [15:0] sample_out,       // Our sample output
    output new_sample_ready         // Tells the codec when we've got a sample
);

    // Logic to delay the step size as this is the same timing as note_player
    wire [19:0] step_size, step_delay;

    dffre #(.WIDTH(20)) freq_reg (
       .clk(clk),
       .r(reset),
       .en(load_new_note),
       .d(frequency_to_load),
       .q(step_delay)
    );
   
    dffr #(.WIDTH(20)) freq_delay_reg (
       .clk(clk),
       .r(reset),
       .d(step_delay),
       .q(step_size)
    );

    // Sine reader module to play the sine wave
    sine_reader sine_read(
        .clk(clk),
        .reset(reset || load_new_note),
        .step_size(step_size),
        .generate_next(play_enable && generate_next_sample),
        .sample_ready(new_sample_ready),
        .sample(sample_out)
    );

    // FSM for what state we are on by counting how long to produce the sample
    wire [5:0] state, next_state;
    dffre #(.WIDTH(6)) state_reg (
        .clk(clk),
        .r(reset),
        .en((beat || load_new_note) && play_enable),
        .d(next_state),
        .q(state)
    );
    assign next_state = (reset || done_with_note || load_new_note)
                        ? duration_to_load : state - 1;

    assign done_with_note = (state == 6'b0) && beat;

endmodule
