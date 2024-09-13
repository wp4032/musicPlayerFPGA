module wave_capture_tb ();
    reg clk, reset, generate_next, wave_display_idle;
    reg [19:0] step_size;
    wire sample_ready;
    wire [15:0] sample;
    sine_reader reader(
        .clk(clk),
        .reset(reset),
        .step_size(step_size),
        .generate_next(generate_next),
        .sample_ready(sample_ready),
        .sample(sample)
    );

    wire [8:0] write_address;
    wire write_enable;
    wire [7:0] write_sample;
    wire read_index;
    wave_capture capture(
        .clk(clk),
        .reset(reset),
        .new_sample_ready(sample_ready),
        .new_sample_in(sample),
        .wave_display_idle(wave_display_idle),
        .write_address(write_address),
        .write_enable(write_enable),
        .write_sample(write_sample),
        .read_index(read_index)
    );

    // Clock and reset
    initial begin
        clk = 1'b0;
        wave_display_idle = 1'b0;
        reset = 1'b1;
        repeat (4) #5 clk = ~clk;
        reset = 1'b0;
        forever #5 clk = ~clk;
    end

    // Tests
    initial begin
        // First sine wave
        step_size = {10'd018, 10'd791}; // Note: 2A
        generate_next = 1;
        #165
        repeat (256) begin
            #10 generate_next = 1;
        end

        #100 wave_display_idle = 1'b1;
        #10 wave_display_idle = 1'b0;
        
        // A different sine wave
        step_size = {10'd037, 10'd559}; // Note: 2A
        repeat (90) begin
            #25 generate_next = ~generate_next;
            #5 generate_next = ~generate_next;
        end
        
        // Reset should go back to zero
        reset = 1;
        #20 reset = 0;
        repeat (90) begin
            #25 generate_next = ~generate_next;
            #5 generate_next = ~generate_next;
        end
    end

endmodule