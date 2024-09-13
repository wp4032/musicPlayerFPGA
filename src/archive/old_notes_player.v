module old_notes_player(
    input clk,
    input reset,
    input play_enable,                // When high we play, when low we don't.
    input [5:0] note1,                // The 1st note to play
    input [5:0] note2,                // The 2nd note to play
    input [5:0] note3,                // The 3rd note to play
    input [5:0] note4,                // The 4th note to play
    input [5:0] duration,             // The duration of the note to play
    input load_new_note,              // Tells us when we have a new note to load
    input beat,                       // This is our 1/48th second beat
    input generate_next_sample,       // Tells us when the codec wants a new sample
    input [1:0] num_notes,            // Number of notes being played (max is 4, min is 1)
    input [2:0] metadata,
    output wire done_with_note,       // When we are done with the note this stays high.
    output wire [15:0] sample_out,    // Our sample output
    output wire new_sample_ready      // Tells the codec when we've got a sample
);
    wire done1, done2, done3, done4;
    wire new_sample1, new_sample2, new_sample3, new_sample4;
    // Pure sine wave sample from note players
    wire signed [15:0] sample1, sample2, sample3, sample4;
    // Scaled sample (scsample) from divsors
    wire signed [15:0] scsample1, scsample2, scsample3, scsample4;

    // The individual note players with their own sine wave
    note_player np1(
        .clk(clk), .reset(reset), .play_enable(play_enable), 
        .load_new_note(load_new_note), .done_with_note(done1),
        .beat(beat), .generate_next_sample(generate_next_sample), 
        .sample_out(sample1), .new_sample_ready(new_sample1),
        .note_to_load(note1), .duration_to_load(duration)
    );

    note_player np2(
        .clk(clk), .reset(reset), .play_enable(play_enable), 
        .load_new_note(load_new_note), .done_with_note(done2),
        .beat(beat), .generate_next_sample(generate_next_sample), 
        .sample_out(sample2), .new_sample_ready(new_sample2),
        .note_to_load(note2), .duration_to_load(duration)
    );

    note_player np3(
        .clk(clk), .reset(reset), .play_enable(play_enable), 
        .load_new_note(load_new_note), .done_with_note(done3),
        .beat(beat), .generate_next_sample(generate_next_sample), 
        .sample_out(sample3), .new_sample_ready(new_sample3),
        .note_to_load(note3), .duration_to_load(duration)
    );

    note_player np4(
        .clk(clk), .reset(reset), .play_enable(play_enable), 
        .load_new_note(load_new_note), .done_with_note(done4),
        .beat(beat), .generate_next_sample(generate_next_sample), 
        .sample_out(sample4), .new_sample_ready(new_sample4),
        .note_to_load(note4), .duration_to_load(duration)
    );

    // Logic to scale the sample down
    wire [3:0] a1, a2, a3, a4;
    wire [3:0] b1, b2, b3, b4;
    wire [3:0] c1, c2, c3, c4;
    wire [3:0] d1, d2, d3, d4;

    divide div1(
        .numerator((isn_a) ? -sample1 : sample1),
        .a(a1), .b(b1), .c(c1), .d(d1),
        .dout(scsample1)
    );

    divide div2(
        .numerator((isn_b) ? -sample2 : sample2),
        .a(a2), .b(b2), .c(c2), .d(d2),
        .dout(scsample2)
    );

    divide div3(
        .numerator((isn_c) ? -sample3 : sample3),
        .a(a3), .b(b3), .c(c3), .d(d3),
        .dout(scsample3)
    );

    divide div4(
        .numerator((isn_d) ? -sample4 : sample4),
        .a(a4), .b(b4), .c(c4), .d(d4),
        .dout(scsample4)
    );


    // Wires for the addresses for divisor rom
    wire [6:0] addr_a, addr_b, addr_c, addr_d;

    // Wires for whether numbers are negative
    wire isn_a, isn_b, isn_c, isn_d;

    // ROMs to retrieve the Fourier coefficients:
    fourier_rom f1(.clk(clk), .metadata(metadata), .num_notes(num_notes), .dout({addr_a, addr_b, addr_c, addr_d, isn_a, isn_b, isn_c, isn_d}));

    // ROMS to retrieve the divisor coefficients:
    divisor_rom4 divrom1(.clk(clk), .addr(addr_a), .dout({a1, b1, c1, d1}));
    divisor_rom4 divrom2(.clk(clk), .addr(addr_b), .dout({a2, b2, c2, d2}));
    divisor_rom4 divrom3(.clk(clk), .addr(addr_c), .dout({a3, b3, c3, d3}));
    divisor_rom4 divrom4(.clk(clk), .addr(addr_d), .dout({a4, b4, c4, d4}));

    // Outputs for notes_player that sum / and the output from the individual note players
    assign sample_out = scsample1 + scsample2 + scsample3 + scsample4;
    assign new_sample_ready = (new_sample1 & new_sample2 & new_sample3 & new_sample4);
    assign done_with_note = (done1 && done2 && done3 && done4);


endmodule