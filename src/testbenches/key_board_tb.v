module key_board_tb();

    key_board dut(
        .clk(clk),
        .reset(reset),
        .enable(!play && (key_val != 4'h0)),
        .beat(beat),
        .generate_next_sample(generate_next_sample),
        .key_val(key_val),
        .key_note_sample(key_note_sample),
        .key_note_sample_ready(key_note_sample_ready)
    );

    beat_generator #(.WIDTH(17), .STOP(1500)) beat_generator(
        .clk(clk),
        .reset(reset),
        .en(1'b1),
        .beat(beat)
    );

    reg clk, reset, generate_next_sample;
    reg [3:0] key_val;
    wire [15:0] key_note_sample;
    wire key_note_sample_ready, beat;
    reg [5:0] count_test, duration;

    reg play = 1;
    // Clock and reset
    initial begin
        clk = 1'b0;
        reset = 1'b1;
        repeat (4) #5 clk = ~clk;
        reset = 1'b0;
        forever #5 clk = ~clk;
    end
    initial begin
        #20 play = 0;
        generate_next_sample = 0;
        count_test = 6'd0;
        duration = 6'd10;
        while (count_test != duration) begin
            #10 generate_next_sample = ~generate_next_sample;
            if(beat) begin
                count_test = count_test + 6'd1;
            end
        end

    end 

    initial begin
        key_val = 0;
        #10000
        
        key_val = 1;
        #45000
        key_val = 11;
        #45000
        key_val = 0;
    end 


endmodule