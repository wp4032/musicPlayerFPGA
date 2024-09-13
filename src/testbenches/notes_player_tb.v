module note_player_tb();

    reg clk, reset, play_enable, generate_next_sample;
    reg [5:0] note1, note2, note3, note4;
    reg [5:0] duration;
    reg load_new_note;
    wire done_with_note, new_sample_ready, beat;
    wire [15:0] sample_out;
    reg [5:0] count_test;
    reg [1:0] num_notes;
    reg [2:0] metadata;

    notes_player nsp(
        .clk(clk),
        .reset(reset),

        .play_enable(play_enable),
        .note1(note1), .note2(note2), .note3(note3), .note4(note4),
        .duration(duration),
        .load_new_note(load_new_note),
        .done_with_note(done_with_note),

        .beat(beat),
        .generate_next_sample(generate_next_sample),
        .num_notes(num_notes),
        .metadata(metadata),
        .sample_out(sample_out),
        .new_sample_ready(new_sample_ready)
    );

    beat_generator #(.WIDTH(17), .STOP(1500)) beat_generator(
        .clk(clk),
        .reset(reset),
        .en(1'b1),
        .beat(beat)
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
        #20 play_enable = 1;
        generate_next_sample = 0;
        
        // Chord C
        {note1, note2, note3, note4, duration} = {6'd40, 6'd0, 6'd0, 6'd0, 6'd1};
        metadata = 3'd0;
        num_notes = 2'd0;
        load_new_note = 1;
        #10 load_new_note = 0;
        count_test = 6'd0;
        
        while (count_test != duration) begin
            #10 generate_next_sample = ~generate_next_sample;
            if(beat) begin
                count_test = count_test + 6'd1;
            end
        end
        
        // Major 3rd CE
        {note1, note2, note3, note4, duration} = {6'd40, 6'd44, 6'd0, 6'd0, 6'd1};
        metadata = 3'd0;
        num_notes = 2'd1;
        load_new_note = 1;
        #10 load_new_note = 0;
        count_test = 6'd0;
        
        while (count_test != duration) begin
            #10 generate_next_sample = ~generate_next_sample;
            if(beat) begin
                count_test = count_test + 6'd1;
            end
        end

        // Chord CEG
        {note1, note2, note3, note4, duration} = {6'd40, 6'd44, 6'd47, 6'd0, 6'd1};
        metadata = 3'd0;
        num_notes = 2'd2;
        load_new_note = 1;
        #10 load_new_note = 0;
        count_test = 6'd0;
        
        while (count_test != duration) begin
            #10 generate_next_sample = ~generate_next_sample;
            if(beat) begin
                count_test = count_test + 6'd1;
            end
        end

        // Chord CEG
        {note1, note2, note3, note4, duration} = {6'd40, 6'd44, 6'd47, 6'd0, 6'd1};
        metadata = 3'd0;
        num_notes = 2'd2;
        load_new_note = 1;
        #10 load_new_note = 0;
        count_test = 6'd0;
        
        while (count_test != duration) begin
            #10 generate_next_sample = ~generate_next_sample;
            if(beat) begin
                count_test = count_test + 6'd1;
            end
        end

        // Note A2 as Sawtooth
        {note1, note2, note3, note4, duration} = {6'd13, 6'd25, 6'd32, 6'd37, 6'd1};
        metadata = 3'd1;
        num_notes = 2'd0;
        load_new_note = 1;
        #10 load_new_note = 0;
        count_test = 6'd0;
        
        while (count_test != duration) begin
            #10 generate_next_sample = ~generate_next_sample;
            if(beat) begin
                count_test = count_test + 6'd1;
            end
        end

        // Note A2 as Square
        {note1, note2, note3, note4, duration} = {6'd13, 6'd25, 6'd32, 6'd37, 6'd1};
        metadata = 3'd2;
        num_notes = 2'd0;
        load_new_note = 1;
        #10 load_new_note = 0;
        count_test = 6'd0;
        
        while (count_test != duration) begin
            #10 generate_next_sample = ~generate_next_sample;
            if(beat) begin
                count_test = count_test + 6'd1;
            end
        end

        // Note A2 as Triangle
        {note1, note2, note3, note4, duration} = {6'd13, 6'd25, 6'd32, 6'd37, 6'd1};
        metadata = 3'd3;
        num_notes = 2'd0;
        load_new_note = 1;
        #10 load_new_note = 0;
        count_test = 6'd0;
        
        while (count_test != duration) begin
            #10 generate_next_sample = ~generate_next_sample;
            if(beat) begin
                count_test = count_test + 6'd1;
            end
        end

        // generate_next_sample = 0;
        // count_test = 0;
        // // Second note
        // {note_to_load, duration} = {6'd1, 6'd8};
        // load_new_note = 1;
        // #10 load_new_note = 0;
        // while (count_test != duration - 1) begin
        //     #10 generate_next_sample = ~generate_next_sample;
        //     if(beat) begin
        //         count_test = count_test + 6'd1;
        //     end
        // end
        // generate_next_sample = 0;
        // count_test = 0;
        // // Third note with pause
        // {note_to_load, duration} = {6'd51, 6'd12};
        // load_new_note = 1;
        // #10 load_new_note = 0;
        // while (count_test != 6'd5) begin
        //     #10 generate_next_sample = ~generate_next_sample;
        //     if(beat) begin
        //         count_test = count_test + 6'd1;
        //     end
        // end
        // play_enable = 0;
        // count_test = count_test - 6'd1;
        // #100000 play_enable = 1;
        // while (count_test != duration - 1) begin
        //     #10 generate_next_sample = ~generate_next_sample;
        //     if(beat) begin
        //         count_test = count_test + 6'd1;
        //     end
        // end
    end

endmodule