module notes_player(
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
    input [2:0] metadata1,            // Metadata of note 1
    input [2:0] metadata2,            // Metadata of note 2
    input [2:0] metadata3,            // Metadata of note 3
    input [2:0] metadata4,            // Metadata of note 4
    input dtoggle,                    // Dynamics toggle
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
    harmonics_player hp1(
        .clk(clk), .reset(reset), .play_enable(play_enable), 
        .load_new_note(load_new_note), .done_with_note(done1),
        .beat(beat), .generate_next_sample(generate_next_sample), 
        .sample_out(sample1), .new_sample_ready(new_sample1),
        .note(note1), .duration(duration), .metadata(metadata1)
    );

    harmonics_player hp2(
        .clk(clk), .reset(reset), .play_enable(play_enable), 
        .load_new_note(load_new_note), .done_with_note(done2),
        .beat(beat), .generate_next_sample(generate_next_sample), 
        .sample_out(sample2), .new_sample_ready(new_sample2),
        .note(note2), .duration(duration), .metadata(metadata2)
    );

    harmonics_player hp3(
        .clk(clk), .reset(reset), .play_enable(play_enable), 
        .load_new_note(load_new_note), .done_with_note(done3),
        .beat(beat), .generate_next_sample(generate_next_sample), 
        .sample_out(sample3), .new_sample_ready(new_sample3),
        .note(note3), .duration(duration), .metadata(metadata3)
    );

    harmonics_player hp4(
        .clk(clk), .reset(reset), .play_enable(play_enable), 
        .load_new_note(load_new_note), .done_with_note(done4),
        .beat(beat), .generate_next_sample(generate_next_sample), 
        .sample_out(sample4), .new_sample_ready(new_sample4),
        .note(note4), .duration(duration), .metadata(metadata4)
    );


    // Logic to scale the sample down
    wire [3:0] a1, a2, a3, a4;
    wire [3:0] b1, b2, b3, b4;
    wire [3:0] c1, c2, c3, c4;
    wire [3:0] d1, d2, d3, d4;

    divide div1(
        .clk(clk), .reset(reset),
        .numerator(sample1),
        .a(a1), .b(b1), .c(c1), .d(d1),
        .dout(scsample1)
    );

    divide div2(
        .clk(clk), .reset(reset),
        .numerator(sample2),
        .a(a2), .b(b2), .c(c2), .d(d2),
        .dout(scsample2)
    );

    divide div3(
        .clk(clk), .reset(reset),
        .numerator(sample3),
        .a(a3), .b(b3), .c(c3), .d(d3),
        .dout(scsample3)
    );

    divide div4(
        .clk(clk), .reset(reset),
        .numerator(sample4),
        .a(a4), .b(b4), .c(c4), .d(d4),
        .dout(scsample4)
    );


    // Wires for the addresses for divisor rom
    reg [6:0] addr_a, addr_b, addr_c, addr_d;


    // ROMS to retrieve the divisor coefficients:
    divisor_rom4 divrom1(.clk(clk), .addr(addr_a), .dout({a1, b1, c1, d1}));
    divisor_rom4 divrom2(.clk(clk), .addr(addr_b), .dout({a2, b2, c2, d2}));
    divisor_rom4 divrom3(.clk(clk), .addr(addr_c), .dout({a3, b3, c3, d3}));
    divisor_rom4 divrom4(.clk(clk), .addr(addr_d), .dout({a4, b4, c4, d4}));


    // Logic for just playing a regular note (metadata = 0) 
    // and we need to sum each note equally
    // and it depends on the number of notes loaded
    always @(*) begin
        case(num_notes)
            2'b00: {addr_a, addr_b, addr_c, addr_d} = {7'd100, 7'd0  , 7'd0  , 7'd0  }; // 1 note  played @ 100%
            2'b01: {addr_a, addr_b, addr_c, addr_d} = {7'd50 , 7'd50 , 7'd0  , 7'd0  }; // 2 notes played @ 50%
            2'b10: {addr_a, addr_b, addr_c, addr_d} = {7'd33 , 7'd33 , 7'd33 , 7'd0  }; // 3 notes played @ 33%
            2'b11: {addr_a, addr_b, addr_c, addr_d} = {7'd25 , 7'd25 , 7'd25 , 7'd25 }; // 4 notes played @ 25%
        endcase
    end


    // Outputs for notes_player that sum / and the output from the individual note players
    wire [15:0] sample_out_scaled;
    wire notes_player_sample_ready;
    assign sample_out_scaled = scsample1 + scsample2 + scsample3 + scsample4;
    assign notes_player_sample_ready = (new_sample1 & new_sample2 & new_sample3 & new_sample4);
    assign done_with_note = (done1 && done2 && done3 && done4);


    parameter BEAT_COUNT = 1000;
    
    // Creates 1/192 second beats for fine tuned dynamics
    wire minibeat;
    dynamic_generator dg(
        .clk(clk),
        .reset(reset),
        .en(generate_next_sample),
        .beat(minibeat)
    );


    // Toggle wire for the dynamics based on the button
    wire toggle_state; 
    dffre #(.WIDTH(1)) toggle_updater ( 
        .clk(clk),
        .r(reset),
        .en(dtoggle),
        .d(!toggle_state),
        .q(toggle_state)
    );


    // Will determine length of each section of ADSR envelope
    wire [1:0] attack_time_pow, decay_time_pow, release_time_pow;

    // ADR times can be adjusted from 0-3; sustain will fill up the rest of the time
    assign attack_time_pow = 3;
    assign decay_time_pow = 3;
    assign release_time_pow = 3;

    // Dynamics module
    dynamics dyn(
        .clk(clk),
        .reset(reset),
        .play_enable(play_enable),
        .sample_in(sample_out_scaled),
        .duration(duration),
        .attack_time_pow(attack_time_pow),
        .decay_time_pow(decay_time_pow),
        .release_time_pow(release_time_pow),
        .minibeat(minibeat),
        .toggle_dynamics(toggle_state),
        .sample_ready(notes_player_sample_ready),
        .sample_out(sample_out),
        .dynamic_sample_ready(new_sample_ready)
    );


endmodule