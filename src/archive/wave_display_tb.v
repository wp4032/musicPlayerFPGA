module wave_display_tb (

);
    reg clk, reset, valid, read_index;
    reg [10:0] x;
    reg [9:0] y;
    wire [7:0] read_value;
    wire [8:0] read_address;
    wire valid_pixel;
    wire [7:0] r, g, b;
    
    // use fake RAM(increasing data)
    fake_sample_ram fkr(
        .clk(clk),
        .addr(read_address[7:0]),
        .dout(read_value)
    );

    wave_display wd(
        .clk(clk),
        .reset(reset),
        .x(x),
        .y(y),
        .valid(valid),
        .read_value(read_value),
        .read_index(read_index),
        .read_address(read_address),
        .valid_pixel(valid_pixel),
        .r(r),
        .g(g),
        .b(b)
    );

    // Clock and reset
    initial begin
        clk = 1'b0;
        valid = 1'b0;
        reset = 1'b1;
        repeat (4) #5 clk = ~clk;
        reset = 1'b0;
        forever #5 clk = ~clk;
    end

    // Tests
    initial begin
        // Initialize x and y coordinates.
        x = 11'b0;
        y = 10'b0;
        #25 read_index = 1'b1; // Set read_index
        repeat(1024) begin // loop through the y dimension in the outer loop to simulate sweep behavior
            // $display("y = %d", y);
            repeat(2048) begin //loop through the x dimension in the inner loop to simulate sweep behavior 
                #10 x = x + 11'b1; //increment
                valid = (x < 11'd1280); //set valid
                // $display("x = %d", x);
            end
            y = y + 10'b1; //increment
        end
    end

endmodule