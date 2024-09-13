module song_reader_tb();

    reg clk, reset, play, note_done;
    reg [1:0] song;
    wire [5:0] note1, note2, note3, note4;
    wire [2:0] metadata;
    wire [5:0] duration;
    wire song_done, new_note;
    wire [1:0] num_notes;

    song_reader dut(
        .clk(clk),
        .reset(reset),
        .play(play),
        .song(song),
        .note_done(note_done),
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


    // Clock and reset
    initial begin
        clk = 1'b0;
        reset = 1'b1;
        repeat (4) #5 clk = ~clk;
        reset = 1'b0;
        forever #5 clk = ~clk;
    end

    // Tests
    initial begin
        note_done = 0;
        play = 0;
        song = 0;
        #40
        play = 1;
        
        //song #0
        while(!new_note) begin
            #5 play = 1;
        end
        repeat (12) begin
            #5 play = 1;
        end
        #5 note_done = 1;
        #5 note_done = 0;
        
        while(!new_note) begin
            #5 play = 1;
        end
        repeat (12) begin
            #5 play = 1;
        end
        #5 note_done = 1;
        #5 note_done = 0;
        
        while(!new_note) begin
            #5 play = 1;
        end
        repeat (12) begin
            #5 play = 1;
        end
        #5 note_done = 1;
        #5 note_done = 0;
        
        //Simulating Pressing Next Button to switch to next song
        //song #1
        // Letting it play out all of its notes, until it swtiches to song #2
        #5 song = 1;
        #5
        repeat (200) begin
            #5 note_done = ~note_done;
        end
        
        //pause song#2 in middle (note since we're manually making this change, waveform has a bit of delay)
        song = 2;
        play = 0;
        #10;
    end

endmodule

