module music_player_tb();
    
    music_player #(.BEAT_COUNT(1000)) dut(
        .clk(clk),
        .reset(reset),
        .play_button(play),
        .next_button(0),
        .new_frame(new_frame),
        .sample_out(key_note_sample),
        .new_sample_generated(key_note_sample_ready)
    );


    initial begin
        clk = 1'b0;
        reset = 1'b1;
        repeat (4) #5 clk = ~clk;
        reset = 1'b0;
        forever #5 clk = ~clk;
    end

    initial begin
        #40
        forever begin
            new_frame = 0;
            #100;
            new_frame = 1;
            #10;
        end
    end 


    reg clk, reset, new_frame, play;
    wire [15:0] key_note_sample;
    wire key_note_sample_ready;

    initial begin
        play = 0;
        #10000;

        play = 1;
        #10000000;

    end

endmodule