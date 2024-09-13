module divisor_rom4 (
    input clk,
    input [6:0] addr,
    output reg [15:0] dout  // dout = {a, b, c, d}
);
    wire [15:0] memory [100:0];

    always @(posedge clk)
        dout = memory[addr];

    assign memory[0] = {4'd15, 4'd15, 4'd15, 4'd15};	// Decimal = 0.00
    assign memory[1] = {4'd7, 4'd9, 4'd13, 4'd14};		// Decimal = 0.01
    assign memory[2] = {4'd6, 4'd8, 4'd12, 4'd13};		// Decimal = 0.02
    assign memory[3] = {4'd6, 4'd7, 4'd8, 4'd9};		// Decimal = 0.03
    assign memory[4] = {4'd5, 4'd7, 4'd11, 4'd12};		// Decimal = 0.04
    assign memory[5] = {4'd5, 4'd6, 4'd9, 4'd10};		// Decimal = 0.05
    assign memory[6] = {4'd5, 4'd6, 4'd7, 4'd8};		// Decimal = 0.06
    assign memory[7] = {4'd4, 4'd8, 4'd9, 4'd10};		// Decimal = 0.07
    assign memory[8] = {4'd4, 4'd6, 4'd10, 4'd11};		// Decimal = 0.08
    assign memory[9] = {4'd4, 4'd6, 4'd7, 4'd8};		// Decimal = 0.09
    assign memory[10] = {4'd4, 4'd5, 4'd8, 4'd9};		// Decimal = 0.10
    assign memory[11] = {4'd4, 4'd5, 4'd6, 4'd11};		// Decimal = 0.11
    assign memory[12] = {4'd4, 4'd5, 4'd6, 4'd7};		// Decimal = 0.12
    assign memory[13] = {4'd3, 4'd8, 4'd10, 4'd14};		// Decimal = 0.13
    assign memory[14] = {4'd3, 4'd7, 4'd8, 4'd9};		// Decimal = 0.14
    assign memory[15] = {4'd3, 4'd6, 4'd7, 4'd10};		// Decimal = 0.15
    assign memory[16] = {4'd3, 4'd5, 4'd9, 4'd10};		// Decimal = 0.16
    assign memory[17] = {4'd3, 4'd5, 4'd7, 4'd8};		// Decimal = 0.17
    assign memory[18] = {4'd3, 4'd5, 4'd6, 4'd7};		// Decimal = 0.18
    assign memory[19] = {4'd3, 4'd4, 4'd9, 4'd11};		// Decimal = 0.19
    assign memory[20] = {4'd3, 4'd4, 4'd7, 4'd8};		// Decimal = 0.20
    assign memory[21] = {4'd3, 4'd4, 4'd6, 4'd8};		// Decimal = 0.21
    assign memory[22] = {4'd3, 4'd4, 4'd5, 4'd10};		// Decimal = 0.22
    assign memory[23] = {4'd3, 4'd4, 4'd5, 4'd7};		// Decimal = 0.23
    assign memory[24] = {4'd3, 4'd4, 4'd5, 4'd6};		// Decimal = 0.24
    assign memory[25] = {4'd2, 4'd0, 4'd0, 4'd0};		// Decimal = 0.25
    assign memory[26] = {4'd2, 4'd7, 4'd9, 4'd13};		// Decimal = 0.26
    assign memory[27] = {4'd2, 4'd6, 4'd8, 4'd12};		// Decimal = 0.27
    assign memory[28] = {4'd2, 4'd6, 4'd7, 4'd8};		// Decimal = 0.28
    assign memory[29] = {4'd2, 4'd5, 4'd7, 4'd11};		// Decimal = 0.29
    assign memory[30] = {4'd2, 4'd5, 4'd6, 4'd9};		// Decimal = 0.30
    assign memory[31] = {4'd2, 4'd5, 4'd6, 4'd7};		// Decimal = 0.31
    assign memory[32] = {4'd2, 4'd4, 4'd8, 4'd9};		// Decimal = 0.32
    assign memory[33] = {4'd2, 4'd4, 4'd6, 4'd10};		// Decimal = 0.33
    assign memory[34] = {4'd2, 4'd4, 4'd6, 4'd7};		// Decimal = 0.34
    assign memory[35] = {4'd2, 4'd4, 4'd5, 4'd8};		// Decimal = 0.35
    assign memory[36] = {4'd2, 4'd4, 4'd5, 4'd6};		// Decimal = 0.36
    assign memory[37] = {4'd2, 4'd4, 4'd5, 4'd6};		// Decimal = 0.37
    assign memory[38] = {4'd2, 4'd3, 4'd8, 4'd10};		// Decimal = 0.38
    assign memory[39] = {4'd2, 4'd3, 4'd7, 4'd8};		// Decimal = 0.39
    assign memory[40] = {4'd2, 4'd3, 4'd6, 4'd7};		// Decimal = 0.40
    assign memory[41] = {4'd2, 4'd3, 4'd5, 4'd9};		// Decimal = 0.41
    assign memory[42] = {4'd2, 4'd3, 4'd5, 4'd7};		// Decimal = 0.42
    assign memory[43] = {4'd2, 4'd3, 4'd5, 4'd6};		// Decimal = 0.43
    assign memory[44] = {4'd2, 4'd3, 4'd4, 4'd9};		// Decimal = 0.44
    assign memory[45] = {4'd2, 4'd3, 4'd4, 4'd7};		// Decimal = 0.45
    assign memory[46] = {4'd2, 4'd3, 4'd4, 4'd6};		// Decimal = 0.46
    assign memory[47] = {4'd2, 4'd3, 4'd4, 4'd5};		// Decimal = 0.47
    assign memory[48] = {4'd2, 4'd3, 4'd4, 4'd5};		// Decimal = 0.48
    assign memory[49] = {4'd2, 4'd3, 4'd4, 4'd5};		// Decimal = 0.49
    assign memory[50] = {4'd1, 4'd0, 4'd0, 4'd0};		// Decimal = 0.50
    assign memory[51] = {4'd1, 4'd7, 4'd9, 4'd13};		// Decimal = 0.51
    assign memory[52] = {4'd1, 4'd6, 4'd8, 4'd12};		// Decimal = 0.52
    assign memory[53] = {4'd1, 4'd6, 4'd7, 4'd8};		// Decimal = 0.53
    assign memory[54] = {4'd1, 4'd5, 4'd7, 4'd11};		// Decimal = 0.54
    assign memory[55] = {4'd1, 4'd5, 4'd6, 4'd9};		// Decimal = 0.55
    assign memory[56] = {4'd1, 4'd5, 4'd6, 4'd7};		// Decimal = 0.56
    assign memory[57] = {4'd1, 4'd4, 4'd8, 4'd9};		// Decimal = 0.57
    assign memory[58] = {4'd1, 4'd4, 4'd6, 4'd10};		// Decimal = 0.58
    assign memory[59] = {4'd1, 4'd4, 4'd6, 4'd7};		// Decimal = 0.59
    assign memory[60] = {4'd1, 4'd4, 4'd5, 4'd8};		// Decimal = 0.60
    assign memory[61] = {4'd1, 4'd4, 4'd5, 4'd6};		// Decimal = 0.61
    assign memory[62] = {4'd1, 4'd4, 4'd5, 4'd6};		// Decimal = 0.62
    assign memory[63] = {4'd1, 4'd3, 4'd8, 4'd10};		// Decimal = 0.63
    assign memory[64] = {4'd1, 4'd3, 4'd7, 4'd8};		// Decimal = 0.64
    assign memory[65] = {4'd1, 4'd3, 4'd6, 4'd7};		// Decimal = 0.65
    assign memory[66] = {4'd1, 4'd3, 4'd5, 4'd9};		// Decimal = 0.66
    assign memory[67] = {4'd1, 4'd3, 4'd5, 4'd7};		// Decimal = 0.67
    assign memory[68] = {4'd1, 4'd3, 4'd5, 4'd6};		// Decimal = 0.68
    assign memory[69] = {4'd1, 4'd3, 4'd4, 4'd9};		// Decimal = 0.69
    assign memory[70] = {4'd1, 4'd3, 4'd4, 4'd7};		// Decimal = 0.70
    assign memory[71] = {4'd1, 4'd3, 4'd4, 4'd6};		// Decimal = 0.71
    assign memory[72] = {4'd1, 4'd3, 4'd4, 4'd5};		// Decimal = 0.72
    assign memory[73] = {4'd1, 4'd3, 4'd4, 4'd5};		// Decimal = 0.73
    assign memory[74] = {4'd1, 4'd3, 4'd4, 4'd5};		// Decimal = 0.74
    assign memory[75] = {4'd1, 4'd2, 4'd0, 4'd0};		// Decimal = 0.75
    assign memory[76] = {4'd1, 4'd2, 4'd7, 4'd9};		// Decimal = 0.76
    assign memory[77] = {4'd1, 4'd2, 4'd6, 4'd8};		// Decimal = 0.77
    assign memory[78] = {4'd1, 4'd2, 4'd6, 4'd7};		// Decimal = 0.78
    assign memory[79] = {4'd1, 4'd2, 4'd5, 4'd7};		// Decimal = 0.79
    assign memory[80] = {4'd1, 4'd2, 4'd5, 4'd6};		// Decimal = 0.80
    assign memory[81] = {4'd1, 4'd2, 4'd5, 4'd6};		// Decimal = 0.81
    assign memory[82] = {4'd1, 4'd2, 4'd4, 4'd8};		// Decimal = 0.82
    assign memory[83] = {4'd1, 4'd2, 4'd4, 4'd6};		// Decimal = 0.83
    assign memory[84] = {4'd1, 4'd2, 4'd4, 4'd6};		// Decimal = 0.84
    assign memory[85] = {4'd1, 4'd2, 4'd4, 4'd5};		// Decimal = 0.85
    assign memory[86] = {4'd1, 4'd2, 4'd4, 4'd5};		// Decimal = 0.86
    assign memory[87] = {4'd1, 4'd2, 4'd4, 4'd5};		// Decimal = 0.87
    assign memory[88] = {4'd1, 4'd2, 4'd3, 4'd8};		// Decimal = 0.88
    assign memory[89] = {4'd1, 4'd2, 4'd3, 4'd7};		// Decimal = 0.89
    assign memory[90] = {4'd1, 4'd2, 4'd3, 4'd6};		// Decimal = 0.90
    assign memory[91] = {4'd1, 4'd2, 4'd3, 4'd5};		// Decimal = 0.91
    assign memory[92] = {4'd1, 4'd2, 4'd3, 4'd5};		// Decimal = 0.92
    assign memory[93] = {4'd1, 4'd2, 4'd3, 4'd5};		// Decimal = 0.93
    assign memory[94] = {4'd1, 4'd2, 4'd3, 4'd4};		// Decimal = 0.94
    assign memory[95] = {4'd1, 4'd2, 4'd3, 4'd4};		// Decimal = 0.95
    assign memory[96] = {4'd1, 4'd2, 4'd3, 4'd4};		// Decimal = 0.96
    assign memory[97] = {4'd1, 4'd2, 4'd3, 4'd4};		// Decimal = 0.97
    assign memory[98] = {4'd1, 4'd2, 4'd3, 4'd4};		// Decimal = 0.98
    assign memory[99] = {4'd1, 4'd2, 4'd3, 4'd4};		// Decimal = 0.99
    assign memory[100] = {4'd0, 4'd0, 4'd0, 4'd0};		// Decimal = 1.00

endmodule

// For old implementation of dividing with 8 coefficients
module divisor_rom8 (
    input clk,
    input [6:0] addr,
    output reg [31:0] dout // dout = {a, b, c, d, e, f, g, h}
);
    wire [31:0] memory [100:0];

    always @(posedge clk)
        dout = memory[addr];

    assign memory[0] = {4'd15, 4'd15, 4'd15, 4'd15, 4'd15, 4'd15, 4'd15, 4'd15};	// Decimal = 0.00
    assign memory[1] = {4'd7, 4'd9, 4'd13, 4'd14, 4'd15, 4'd0, 4'd0, 4'd0};		    // Decimal = 0.01
    assign memory[2] = {4'd6, 4'd8, 4'd12, 4'd13, 4'd14, 4'd15, 4'd0, 4'd0};		// Decimal = 0.02
    assign memory[3] = {4'd6, 4'd7, 4'd8, 4'd9, 4'd11, 4'd13, 4'd14, 4'd15};		// Decimal = 0.03
    assign memory[4] = {4'd5, 4'd7, 4'd11, 4'd12, 4'd13, 4'd14, 4'd0, 4'd0};		// Decimal = 0.04
    assign memory[5] = {4'd5, 4'd6, 4'd9, 4'd10, 4'd13, 4'd14, 4'd0, 4'd0};		    // Decimal = 0.05
    assign memory[6] = {4'd5, 4'd6, 4'd7, 4'd8, 4'd10, 4'd12, 4'd13, 4'd14};		// Decimal = 0.06
    assign memory[7] = {4'd4, 4'd8, 4'd9, 4'd10, 4'd11, 4'd13, 4'd15, 4'd0};		// Decimal = 0.07
    assign memory[8] = {4'd4, 4'd6, 4'd10, 4'd11, 4'd12, 4'd13, 4'd15, 4'd0};		// Decimal = 0.08
    assign memory[9] = {4'd4, 4'd6, 4'd7, 4'd8, 4'd13, 4'd15, 4'd0, 4'd0};		    // Decimal = 0.09
    assign memory[10] = {4'd4, 4'd5, 4'd8, 4'd9, 4'd12, 4'd13, 4'd0, 4'd0};		    // Decimal = 0.10
    assign memory[11] = {4'd4, 4'd5, 4'd6, 4'd11, 4'd13, 4'd0, 4'd0, 4'd0};		    // Decimal = 0.11
    assign memory[12] = {4'd4, 4'd5, 4'd6, 4'd7, 4'd9, 4'd11, 4'd12, 4'd13};		// Decimal = 0.12
    assign memory[13] = {4'd3, 4'd8, 4'd10, 4'd14, 4'd15, 4'd0, 4'd0, 4'd0};		// Decimal = 0.13
    assign memory[14] = {4'd3, 4'd7, 4'd8, 4'd9, 4'd10, 4'd12, 4'd14, 4'd15};		// Decimal = 0.14
    assign memory[15] = {4'd3, 4'd6, 4'd7, 4'd10, 4'd11, 4'd14, 4'd15, 4'd0};		// Decimal = 0.15
    assign memory[16] = {4'd3, 4'd5, 4'd9, 4'd10, 4'd11, 4'd12, 4'd14, 4'd0};		// Decimal = 0.16
    assign memory[17] = {4'd3, 4'd5, 4'd7, 4'd8, 4'd9, 4'd14, 4'd0, 4'd0};		    // Decimal = 0.17
    assign memory[18] = {4'd3, 4'd5, 4'd6, 4'd7, 4'd12, 4'd14, 4'd0, 4'd0};		    // Decimal = 0.18
    assign memory[19] = {4'd3, 4'd4, 4'd9, 4'd11, 4'd15, 4'd0, 4'd0, 4'd0};		    // Decimal = 0.19
    assign memory[20] = {4'd3, 4'd4, 4'd7, 4'd8, 4'd11, 4'd12, 4'd15, 4'd0};		// Decimal = 0.20
    assign memory[21] = {4'd3, 4'd4, 4'd6, 4'd8, 4'd9, 4'd10, 4'd15, 4'd0};		    // Decimal = 0.21
    assign memory[22] = {4'd3, 4'd4, 4'd5, 4'd10, 4'd12, 4'd0, 4'd0, 4'd0};		    // Decimal = 0.22
    assign memory[23] = {4'd3, 4'd4, 4'd5, 4'd7, 4'd9, 4'd10, 4'd11, 4'd0};		    // Decimal = 0.23
    assign memory[24] = {4'd3, 4'd4, 4'd5, 4'd6, 4'd8, 4'd10, 4'd11, 4'd12};		// Decimal = 0.24
    assign memory[25] = {4'd2, 4'd0, 4'd0, 4'd0, 4'd0, 4'd0, 4'd0, 4'd0};		    // Decimal = 0.25
    assign memory[26] = {4'd2, 4'd7, 4'd9, 4'd13, 4'd14, 4'd15, 4'd0, 4'd0};		// Decimal = 0.26
    assign memory[27] = {4'd2, 4'd6, 4'd8, 4'd12, 4'd13, 4'd14, 4'd15, 4'd0};		// Decimal = 0.27
    assign memory[28] = {4'd2, 4'd6, 4'd7, 4'd8, 4'd9, 4'd11, 4'd13, 4'd14};		// Decimal = 0.28
    assign memory[29] = {4'd2, 4'd5, 4'd7, 4'd11, 4'd12, 4'd13, 4'd14, 4'd0};		// Decimal = 0.29
    assign memory[30] = {4'd2, 4'd5, 4'd6, 4'd9, 4'd10, 4'd13, 4'd14, 4'd0};		// Decimal = 0.30
    assign memory[31] = {4'd2, 4'd5, 4'd6, 4'd7, 4'd8, 4'd10, 4'd12, 4'd13};		// Decimal = 0.31
    assign memory[32] = {4'd2, 4'd4, 4'd8, 4'd9, 4'd10, 4'd11, 4'd13, 4'd15};		// Decimal = 0.32
    assign memory[33] = {4'd2, 4'd4, 4'd6, 4'd10, 4'd11, 4'd12, 4'd13, 4'd15};		// Decimal = 0.33
    assign memory[34] = {4'd2, 4'd4, 4'd6, 4'd7, 4'd8, 4'd13, 4'd15, 4'd0};		    // Decimal = 0.34
    assign memory[35] = {4'd2, 4'd4, 4'd5, 4'd8, 4'd9, 4'd12, 4'd13, 4'd0};		    // Decimal = 0.35
    assign memory[36] = {4'd2, 4'd4, 4'd5, 4'd6, 4'd11, 4'd13, 4'd0, 4'd0};		    // Decimal = 0.36
    assign memory[37] = {4'd2, 4'd4, 4'd5, 4'd6, 4'd7, 4'd9, 4'd11, 4'd12};		    // Decimal = 0.37
    assign memory[38] = {4'd2, 4'd3, 4'd8, 4'd10, 4'd14, 4'd15, 4'd0, 4'd0};		// Decimal = 0.38
    assign memory[39] = {4'd2, 4'd3, 4'd7, 4'd8, 4'd9, 4'd10, 4'd12, 4'd14};		// Decimal = 0.39
    assign memory[40] = {4'd2, 4'd3, 4'd6, 4'd7, 4'd10, 4'd11, 4'd14, 4'd15};		// Decimal = 0.40
    assign memory[41] = {4'd2, 4'd3, 4'd5, 4'd9, 4'd10, 4'd11, 4'd12, 4'd14};		// Decimal = 0.41
    assign memory[42] = {4'd2, 4'd3, 4'd5, 4'd7, 4'd8, 4'd9, 4'd14, 4'd0};		    // Decimal = 0.42
    assign memory[43] = {4'd2, 4'd3, 4'd5, 4'd6, 4'd7, 4'd12, 4'd14, 4'd0};		    // Decimal = 0.43
    assign memory[44] = {4'd2, 4'd3, 4'd4, 4'd9, 4'd11, 4'd15, 4'd0, 4'd0};		    // Decimal = 0.44
    assign memory[45] = {4'd2, 4'd3, 4'd4, 4'd7, 4'd8, 4'd11, 4'd12, 4'd15};		// Decimal = 0.45
    assign memory[46] = {4'd2, 4'd3, 4'd4, 4'd6, 4'd8, 4'd9, 4'd10, 4'd15};		    // Decimal = 0.46
    assign memory[47] = {4'd2, 4'd3, 4'd4, 4'd5, 4'd10, 4'd12, 4'd0, 4'd0};		    // Decimal = 0.47
    assign memory[48] = {4'd2, 4'd3, 4'd4, 4'd5, 4'd7, 4'd9, 4'd10, 4'd11};		    // Decimal = 0.48
    assign memory[49] = {4'd2, 4'd3, 4'd4, 4'd5, 4'd6, 4'd8, 4'd10, 4'd11};		    // Decimal = 0.49
    assign memory[50] = {4'd1, 4'd0, 4'd0, 4'd0, 4'd0, 4'd0, 4'd0, 4'd0};		    // Decimal = 0.50
    assign memory[51] = {4'd1, 4'd7, 4'd9, 4'd13, 4'd14, 4'd15, 4'd0, 4'd0};		// Decimal = 0.51
    assign memory[52] = {4'd1, 4'd6, 4'd8, 4'd12, 4'd13, 4'd14, 4'd15, 4'd0};		// Decimal = 0.52
    assign memory[53] = {4'd1, 4'd6, 4'd7, 4'd8, 4'd9, 4'd11, 4'd13, 4'd14};		// Decimal = 0.53
    assign memory[54] = {4'd1, 4'd5, 4'd7, 4'd11, 4'd12, 4'd13, 4'd14, 4'd0};		// Decimal = 0.54
    assign memory[55] = {4'd1, 4'd5, 4'd6, 4'd9, 4'd10, 4'd13, 4'd14, 4'd0};		// Decimal = 0.55
    assign memory[56] = {4'd1, 4'd5, 4'd6, 4'd7, 4'd8, 4'd10, 4'd12, 4'd13};		// Decimal = 0.56
    assign memory[57] = {4'd1, 4'd4, 4'd8, 4'd9, 4'd10, 4'd11, 4'd13, 4'd15};		// Decimal = 0.57
    assign memory[58] = {4'd1, 4'd4, 4'd6, 4'd10, 4'd11, 4'd12, 4'd13, 4'd15};		// Decimal = 0.58
    assign memory[59] = {4'd1, 4'd4, 4'd6, 4'd7, 4'd8, 4'd13, 4'd15, 4'd0};		    // Decimal = 0.59
    assign memory[60] = {4'd1, 4'd4, 4'd5, 4'd8, 4'd9, 4'd12, 4'd13, 4'd0};		    // Decimal = 0.60
    assign memory[61] = {4'd1, 4'd4, 4'd5, 4'd6, 4'd11, 4'd13, 4'd0, 4'd0};		    // Decimal = 0.61
    assign memory[62] = {4'd1, 4'd4, 4'd5, 4'd6, 4'd7, 4'd9, 4'd11, 4'd12};		    // Decimal = 0.62
    assign memory[63] = {4'd1, 4'd3, 4'd8, 4'd10, 4'd14, 4'd15, 4'd0, 4'd0};		// Decimal = 0.63
    assign memory[64] = {4'd1, 4'd3, 4'd7, 4'd8, 4'd9, 4'd10, 4'd12, 4'd14};		// Decimal = 0.64
    assign memory[65] = {4'd1, 4'd3, 4'd6, 4'd7, 4'd10, 4'd11, 4'd14, 4'd15};		// Decimal = 0.65
    assign memory[66] = {4'd1, 4'd3, 4'd5, 4'd9, 4'd10, 4'd11, 4'd12, 4'd14};		// Decimal = 0.66
    assign memory[67] = {4'd1, 4'd3, 4'd5, 4'd7, 4'd8, 4'd9, 4'd14, 4'd0};		    // Decimal = 0.67
    assign memory[68] = {4'd1, 4'd3, 4'd5, 4'd6, 4'd7, 4'd12, 4'd14, 4'd0};		    // Decimal = 0.68
    assign memory[69] = {4'd1, 4'd3, 4'd4, 4'd9, 4'd11, 4'd15, 4'd0, 4'd0};		    // Decimal = 0.69
    assign memory[70] = {4'd1, 4'd3, 4'd4, 4'd7, 4'd8, 4'd11, 4'd12, 4'd15};		// Decimal = 0.70
    assign memory[71] = {4'd1, 4'd3, 4'd4, 4'd6, 4'd8, 4'd9, 4'd10, 4'd15};		    // Decimal = 0.71
    assign memory[72] = {4'd1, 4'd3, 4'd4, 4'd5, 4'd10, 4'd12, 4'd0, 4'd0};		    // Decimal = 0.72
    assign memory[73] = {4'd1, 4'd3, 4'd4, 4'd5, 4'd7, 4'd9, 4'd10, 4'd11};		    // Decimal = 0.73
    assign memory[74] = {4'd1, 4'd3, 4'd4, 4'd5, 4'd6, 4'd8, 4'd10, 4'd11};		    // Decimal = 0.74
    assign memory[75] = {4'd1, 4'd2, 4'd0, 4'd0, 4'd0, 4'd0, 4'd0, 4'd0};		    // Decimal = 0.75
    assign memory[76] = {4'd1, 4'd2, 4'd7, 4'd9, 4'd13, 4'd14, 4'd15, 4'd0};		// Decimal = 0.76
    assign memory[77] = {4'd1, 4'd2, 4'd6, 4'd8, 4'd12, 4'd13, 4'd14, 4'd15};		// Decimal = 0.77
    assign memory[78] = {4'd1, 4'd2, 4'd6, 4'd7, 4'd8, 4'd9, 4'd11, 4'd13};		    // Decimal = 0.78
    assign memory[79] = {4'd1, 4'd2, 4'd5, 4'd7, 4'd11, 4'd12, 4'd13, 4'd14};		// Decimal = 0.79
    assign memory[80] = {4'd1, 4'd2, 4'd5, 4'd6, 4'd9, 4'd10, 4'd13, 4'd14};		// Decimal = 0.80
    assign memory[81] = {4'd1, 4'd2, 4'd5, 4'd6, 4'd7, 4'd8, 4'd10, 4'd12};		    // Decimal = 0.81
    assign memory[82] = {4'd1, 4'd2, 4'd4, 4'd8, 4'd9, 4'd10, 4'd11, 4'd13};		// Decimal = 0.82
    assign memory[83] = {4'd1, 4'd2, 4'd4, 4'd6, 4'd10, 4'd11, 4'd12, 4'd13};		// Decimal = 0.83
    assign memory[84] = {4'd1, 4'd2, 4'd4, 4'd6, 4'd7, 4'd8, 4'd13, 4'd15};		    // Decimal = 0.84
    assign memory[85] = {4'd1, 4'd2, 4'd4, 4'd5, 4'd8, 4'd9, 4'd12, 4'd13};		    // Decimal = 0.85
    assign memory[86] = {4'd1, 4'd2, 4'd4, 4'd5, 4'd6, 4'd11, 4'd13, 4'd0};		    // Decimal = 0.86
    assign memory[87] = {4'd1, 4'd2, 4'd4, 4'd5, 4'd6, 4'd7, 4'd9, 4'd11};		    // Decimal = 0.87
    assign memory[88] = {4'd1, 4'd2, 4'd3, 4'd8, 4'd10, 4'd14, 4'd15, 4'd0};		// Decimal = 0.88
    assign memory[89] = {4'd1, 4'd2, 4'd3, 4'd7, 4'd8, 4'd9, 4'd10, 4'd12};		    // Decimal = 0.89
    assign memory[90] = {4'd1, 4'd2, 4'd3, 4'd6, 4'd7, 4'd10, 4'd11, 4'd14};		// Decimal = 0.90
    assign memory[91] = {4'd1, 4'd2, 4'd3, 4'd5, 4'd9, 4'd10, 4'd11, 4'd12};		// Decimal = 0.91
    assign memory[92] = {4'd1, 4'd2, 4'd3, 4'd5, 4'd7, 4'd8, 4'd9, 4'd14};		    // Decimal = 0.92
    assign memory[93] = {4'd1, 4'd2, 4'd3, 4'd5, 4'd6, 4'd7, 4'd12, 4'd14};		    // Decimal = 0.93
    assign memory[94] = {4'd1, 4'd2, 4'd3, 4'd4, 4'd9, 4'd11, 4'd15, 4'd0};		    // Decimal = 0.94
    assign memory[95] = {4'd1, 4'd2, 4'd3, 4'd4, 4'd7, 4'd8, 4'd11, 4'd12};		    // Decimal = 0.95
    assign memory[96] = {4'd1, 4'd2, 4'd3, 4'd4, 4'd6, 4'd8, 4'd9, 4'd10};		    // Decimal = 0.96
    assign memory[97] = {4'd1, 4'd2, 4'd3, 4'd4, 4'd5, 4'd10, 4'd12, 4'd0};		    // Decimal = 0.97
    assign memory[98] = {4'd1, 4'd2, 4'd3, 4'd4, 4'd5, 4'd7, 4'd9, 4'd10};		    // Decimal = 0.98
    assign memory[99] = {4'd1, 4'd2, 4'd3, 4'd4, 4'd5, 4'd6, 4'd8, 4'd10};		    // Decimal = 0.99
    assign memory[100] = {4'd0, 4'd0, 4'd0, 4'd0, 4'd0, 4'd0, 4'd0, 4'd0};		    // Decimal = 0.100
endmodule
