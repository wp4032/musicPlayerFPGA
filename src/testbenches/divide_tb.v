module divide_tb;

    reg [15:0] numerator;
    reg [3:0] a, b, c, d;
    wire [15:0] out;

    divide dut (
        .numerator(numerator), 
        .a(a), 
        .b(b), 
        .c(c), 
        .d(d), 
        .dout(out)
    );

    initial begin
        // Test case 1: numerator = 9, a=2, b=4, c=6, d=8
        numerator = 9; a = 2; b = 4; c = 6; d = 8;
        #10;
        $display("Test 1: numerator = %d, a = %d, b = %d, c = %d, d = %d, out = %d", numerator, a, b, c, d, out);
        if(out == 3) $display("Result Correct");
        else $display("Result Incorrect");

        // Test case 2: numerator = 4, a=1, b=0, c=0, d=0
        numerator = 4; a = 1; b = 0; c = 0; d = 0;
        #10;
        $display("Test 2: numerator = %d, a = %d, b = %d, c = %d, d = %d, out = %d", numerator, a, b, c, d, out);
        if(out == 2) $display("Result Correct");
        else $display("Result Incorrect");

        // Test case 3: numerator = 21, a=0, b=0, c=0, d=0
        numerator = 21; a = 0; b = 0; c = 0; d = 0;
        #10;
        $display("Test 3: numerator = %d, a = %d, b = %d, c = %d, d = %d, out = %d", numerator, a, b, c, d, out);
        if(out == 21) $display("Result Correct");
        else $display("Result Incorrect");

        // Test case 4: numerator = 0, a=1, b=2, c=3, d=4
        numerator = 0; a = 1; b = 2; c = 3; d = 4;
        #10;
        $display("Test 4: numerator = %d, a = %d, b = %d, c = %d, d = %d, out = %d", numerator, a, b, c, d, out);
        if(out == 0) $display("Result Correct");
        else $display("Result Incorrect");

        // Test case 5: numerator = 0, a=1, b=15, c=15, d=15
        numerator = 100; a = 0; b = 15; c = 15; d = 15;
        #10;
        $display("Test 4: numerator = %d, a = %d, b = %d, c = %d, d = %d, out = %d", numerator, a, b, c, d, out);
        if(out == 100) $display("Result Correct");
        else $display("Result Incorrect");

        $finish;
    end

endmodule
