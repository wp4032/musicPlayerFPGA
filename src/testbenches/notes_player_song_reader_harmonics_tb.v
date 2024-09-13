module notes_player_song_reader_harmonics_tb();

    reg clk, reset, play, note_done, generate_next_sample;
    reg [1:0] song;
    wire [5:0] note1, note2, note3, note4;
    wire [2:0] metadata;
    wire [5:0] duration;
    wire done_with_note, new_sample_ready;
    wire beat;
    wire song_done, new_note;
    wire [1:0] num_notes;
    wire [15:0] sample_out;

    song_reader dut(
        .clk(clk),
        .reset(reset),
        .play(play),
        .song(song),
        .note_done(done_with_note),
        .song_done(song_done),
        .note1(note1),
        .note2(note2),
        .note3(note3),
        .note4(note4),
        .duration(duration),
        .new_note(new_note),
        .num_notes(num_notes),
        .metadata(metadata)
    );

    notes_player nsp(
        .clk(clk),
        .reset(reset),

        .play_enable(play),
        .note1(note1), .note2(note2), .note3(note3), .note4(note4),
        .duration(duration),
        .load_new_note(new_note),
        .done_with_note(done_with_note),

        .beat(beat),
        .generate_next_sample(generate_next_sample),
        .num_notes(num_notes),
        .metadata(metadata),
        .sample_out(sample_out),
        .new_sample_ready(new_sample_ready)
    );

    parameter BEAT_COUNT = 1000;

    beat_generator #(.WIDTH(10), .STOP(BEAT_COUNT)) bg(
        .clk(clk),
        .reset(reset),
        .en(generate_next_sample),
        .beat(beat)
    );

    // Clock and reset
    initial begin
        clk = 1'b0;
        generate_next_sample = 1'b0;
        reset = 1'b1;
        repeat (5) #5 clk = ~clk;
        generate_next_sample = ~generate_next_sample;
        reset = 1'b0;
        forever begin
            #5 clk = ~clk;
            generate_next_sample = ~generate_next_sample;
        end
    end

    // Tests
    initial begin
        note_done = 0;
        play = 0;
        song = 3;
        #40
        play = 1;
        
        //song #0
        // while(!new_note) begin
        //     #5 play = 1;
        // end
        // repeat (12) begin
        //     #5 play = 1;
        // end
        // #5 note_done = 1;
        // #5 note_done = 0;
        
        // while(!new_note) begin
        //     #5 play = 1;
        // end
        // repeat (12) begin
        //     #5 play = 1;
        // end
        // #5 note_done = 1;
        // #5 note_done = 0;
        
        // while(!new_note) begin
        //     #5 play = 1;
        // end
        // repeat (12) begin
        //     #5 play = 1;
        // end
        // #5 note_done = 1;
        // #5 note_done = 0;
        
        // //Simulating Pressing Next Button to switch to next song
        // //song #1
        // // Letting it play out all of its notes, until it swtiches to song #2
        // #5 song = 1;
        // #5
        // repeat (200) begin
        //     #5 note_done = ~note_done;
        // end
        
        // //pause song#2 in middle (note since we're manually making this change, waveform has a bit of delay)
        // song = 2;
        // play = 0;
        // #10;
    end

endmodule

