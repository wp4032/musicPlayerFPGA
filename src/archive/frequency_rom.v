// Frequency Rom
// Input: note address.
// Output: step size for the frequency.
module frequency_rom (
    input clk,
    input [5:0] addr,
    output reg [19:0] dout
);

    wire [19:0] memory [63:0];

    always @(posedge clk)
        dout = memory[addr];

    assign memory[   0  ] = {10'd000, 10'd000};  // Note: rest
    assign memory[   1  ] = {10'd009, 10'd395};  // Note: 1A
    assign memory[   2  ] = {10'd009, 10'd963};  // Note: 1A#Bb
    assign memory[   3  ] = {10'd010, 10'd573};  // Note: 1B
    assign memory[   4  ] = {10'd011, 10'd182};  // Note: 1C
    assign memory[   5  ] = {10'd011, 10'd838};  // Note: 1C#Db
    assign memory[   6  ] = {10'd012, 10'd557};  // Note: 1D
    assign memory[   7  ] = {10'd013, 10'd275};  // Note: 1D#Eb
    assign memory[   8  ] = {10'd014, 10'd081};  // Note: 1E
    assign memory[   9  ] = {10'd014, 10'd912};  // Note: 1F
    assign memory[  10  ] = {10'd015, 10'd805};  // Note: 1F#Gb
    assign memory[  11  ] = {10'd016, 10'd742};  // Note: 1G
    assign memory[  12  ] = {10'd017, 10'd723};  // Note: 1G#Ab
    assign memory[  13  ] = {10'd018, 10'd791};  // Note: 2A
    assign memory[  14  ] = {10'd019, 10'd903};  // Note: 2A#Bb
    assign memory[  15  ] = {10'd021, 10'd122};  // Note: 2B
    assign memory[  16  ] = {10'd022, 10'd365};  // Note: 2C
    assign memory[  17  ] = {10'd023, 10'd652};  // Note: 2C#Db
    assign memory[  18  ] = {10'd025, 10'd090};  // Note: 2D
    assign memory[  19  ] = {10'd026, 10'd551};  // Note: 2D#Eb
    assign memory[  20  ] = {10'd028, 10'd163};  // Note: 2E
    assign memory[  21  ] = {10'd029, 10'd800};  // Note: 2F
    assign memory[  22  ] = {10'd031, 10'd587};  // Note: 2F#Gb
    assign memory[  23  ] = {10'd033, 10'd461};  // Note: 2G
    assign memory[  24  ] = {10'd035, 10'd423};  // Note: 2G#Ab
    assign memory[  25  ] = {10'd037, 10'd559};  // Note: 3A
    assign memory[  26  ] = {10'd039, 10'd783};  // Note: 3A#Bb
    assign memory[  27  ] = {10'd042, 10'd245};  // Note: 3B
    assign memory[  28  ] = {10'd044, 10'd731};  // Note: 3C
    assign memory[  29  ] = {10'd047, 10'd281};  // Note: 3C#Db
    assign memory[  30  ] = {10'd050, 10'd180};  // Note: 3D
    assign memory[  31  ] = {10'd053, 10'd079};  // Note: 3D#Eb
    assign memory[  32  ] = {10'd056, 10'd327};  // Note: 3E
    assign memory[  33  ] = {10'd059, 10'd576};  // Note: 3F
    assign memory[  34  ] = {10'd063, 10'd150};  // Note: 3F#Gb
    assign memory[  35  ] = {10'd066, 10'd922};  // Note: 3G
    assign memory[  36  ] = {10'd070, 10'd846};  // Note: 3G#Ab
    assign memory[  37  ] = {10'd075, 10'd095};  // Note: 4A
    assign memory[  38  ] = {10'd079, 10'd543};  // Note: 4A#Bb
    assign memory[  39  ] = {10'd084, 10'd491};  // Note: 4B
    assign memory[  40  ] = {10'd089, 10'd439};  // Note: 4C
    assign memory[  41  ] = {10'd094, 10'd562};  // Note: 4C#Db
    assign memory[  42  ] = {10'd100, 10'd360};  // Note: 4D
    assign memory[  43  ] = {10'd106, 10'd158};  // Note: 4D#Eb
    assign memory[  44  ] = {10'd112, 10'd655};  // Note: 4E
    assign memory[  45  ] = {10'd119, 10'd128};  // Note: 4F
    assign memory[  46  ] = {10'd126, 10'd300};  // Note: 4F#Gb
    assign memory[  47  ] = {10'd133, 10'd821};  // Note: 4G
    assign memory[  48  ] = {10'd141, 10'd669};  // Note: 4G#Ab
    assign memory[  49  ] = {10'd150, 10'd191};  // Note: 5A
    assign memory[  50  ] = {10'd159, 10'd062};  // Note: 5A#Bb
    assign memory[  51  ] = {10'd168, 10'd983};  // Note: 5B
    assign memory[  52  ] = {10'd178, 10'd879};  // Note: 5C
    assign memory[  53  ] = {10'd189, 10'd101};  // Note: 5C#Db
    assign memory[  54  ] = {10'd200, 10'd720};  // Note: 5D
    assign memory[  55  ] = {10'd212, 10'd316};  // Note: 5D#Eb
    assign memory[  56  ] = {10'd225, 10'd286};  // Note: 5E
    assign memory[  57  ] = {10'd238, 10'd256};  // Note: 5F
    assign memory[  58  ] = {10'd252, 10'd600};  // Note: 5F#Gb
    assign memory[  59  ] = {10'd267, 10'd619};  // Note: 5G
    assign memory[  60  ] = {10'd283, 10'd314};  // Note: 5G#Ab
    assign memory[  61  ] = {10'd300, 10'd382};  // Note: 6A
    assign memory[  62  ] = {10'd318, 10'd125};  // Note: 6A#Bb
    assign memory[  63  ] = {10'd337, 10'd942};  // Note: 6B

endmodule


// Harmonics Rom
// Input: note address.
// Output: four harmonics
module harmonics_rom (					
	input clk,				
	input [5:0] addr,				
	output reg [79:0] dout				
);					
					
	wire [79:0] memory [63:0];				
					
	always @(posedge clk)				
		dout = memory[addr];			
					
	assign memory[	 0	] =	{10'd0, 10'd0, 10'd0, 10'd0, 10'd0, 10'd0, 10'd0, 10'd0};	                // Note: rest
	assign memory[	 1	] =	{10'd9, 10'd395, 10'd18, 10'd791, 10'd28, 10'd163, 10'd37, 10'd559};	    // Note: 1A
	assign memory[	 2	] =	{10'd9, 10'd963, 10'd19, 10'd903, 10'd29, 10'd843, 10'd39, 10'd783};	    // Note: 1A#Bb
	assign memory[	 3	] =	{10'd10, 10'd573, 10'd21, 10'd122, 10'd31, 10'd696, 10'd42, 10'd245};	    // Note: 1B
	assign memory[	 4	] =	{10'd11, 10'd182, 10'd22, 10'd365, 10'd33, 10'd548, 10'd44, 10'd731};	    // Note: 1C
	assign memory[	 5	] =	{10'd11, 10'd838, 10'd23, 10'd652, 10'd35, 10'd466, 10'd47, 10'd281};	    // Note: 1C#Db
	assign memory[	 6	] =	{10'd12, 10'd557, 10'd25, 10'd90, 10'd37, 10'd647, 10'd50, 10'd180};	    // Note: 1D
	assign memory[	 7	] =	{10'd13, 10'd275, 10'd26, 10'd551, 10'd39, 10'd827, 10'd53, 10'd79};	    // Note: 1D#Eb
	assign memory[	 8	] =	{10'd14, 10'd81, 10'd28, 10'd163, 10'd42, 10'd245, 10'd56, 10'd327};	    // Note: 1E
	assign memory[	 9	] =	{10'd14, 10'd912, 10'd29, 10'd800, 10'd44, 10'd688, 10'd59, 10'd576};	    // Note: 1F
	assign memory[	10	] =	{10'd15, 10'd805, 10'd31, 10'd587, 10'd47, 10'd368, 10'd63, 10'd150};	    // Note: 1F#Gb
	assign memory[	11	] =	{10'd16, 10'd742, 10'd33, 10'd461, 10'd50, 10'd180, 10'd66, 10'd922};	    // Note: 1G
	assign memory[	12	] =	{10'd17, 10'd723, 10'd35, 10'd423, 10'd53, 10'd122, 10'd70, 10'd846};	    // Note: 1G#Ab
	assign memory[	13	] =	{10'd18, 10'd791, 10'd37, 10'd559, 10'd56, 10'd327, 10'd75, 10'd95};	    // Note: 2A
	assign memory[	14	] =	{10'd19, 10'd903, 10'd39, 10'd783, 10'd59, 10'd663, 10'd79, 10'd543};	    // Note: 2A#Bb
	assign memory[	15	] =	{10'd21, 10'd122, 10'd42, 10'd245, 10'd63, 10'd368, 10'd84, 10'd491};	    // Note: 2B
	assign memory[	16	] =	{10'd22, 10'd365, 10'd44, 10'd731, 10'd67, 10'd73, 10'd89, 10'd439};	    // Note: 2C
	assign memory[	17	] =	{10'd23, 10'd652, 10'd47, 10'd281, 10'd70, 10'd933, 10'd94, 10'd562};	    // Note: 2C#Db
	assign memory[	18	] =	{10'd25, 10'd90, 10'd50, 10'd180, 10'd75, 10'd270, 10'd100, 10'd360};	    // Note: 2D
	assign memory[	19	] =	{10'd26, 10'd551, 10'd53, 10'd79, 10'd79, 10'd630, 10'd106, 10'd158};	    // Note: 2D#Eb
	assign memory[	20	] =	{10'd28, 10'd163, 10'd56, 10'd327, 10'd84, 10'd491, 10'd112, 10'd655};	    // Note: 2E
	assign memory[	21	] =	{10'd29, 10'd800, 10'd59, 10'd576, 10'd89, 10'd352, 10'd119, 10'd128};	    // Note: 2F
	assign memory[	22	] =	{10'd31, 10'd587, 10'd63, 10'd150, 10'd94, 10'd737, 10'd126, 10'd300};	    // Note: 2F#Gb
	assign memory[	23	] =	{10'd33, 10'd461, 10'd66, 10'd922, 10'd100, 10'd360, 10'd133, 10'd821};	    // Note: 2G
	assign memory[	24	] =	{10'd35, 10'd423, 10'd70, 10'd846, 10'd106, 10'd245, 10'd141, 10'd669};	    // Note: 2G#Ab
	assign memory[	25	] =	{10'd37, 10'd559, 10'd75, 10'd95, 10'd112, 10'd655, 10'd150, 10'd191};	    // Note: 3A
	assign memory[	26	] =	{10'd39, 10'd783, 10'd79, 10'd543, 10'd119, 10'd303, 10'd159, 10'd62};	    // Note: 3A#Bb
	assign memory[	27	] =	{10'd42, 10'd245, 10'd84, 10'd491, 10'd126, 10'd737, 10'd168, 10'd983};	    // Note: 3B
	assign memory[	28	] =	{10'd44, 10'd731, 10'd89, 10'd439, 10'd134, 10'd147, 10'd178, 10'd879};	    // Note: 3C
	assign memory[	29	] =	{10'd47, 10'd281, 10'd94, 10'd562, 10'd141, 10'd843, 10'd189, 10'd101};	    // Note: 3C#Db
	assign memory[	30	] =	{10'd50, 10'd180, 10'd100, 10'd360, 10'd150, 10'd540, 10'd200, 10'd720};	// Note: 3D
	assign memory[	31	] =	{10'd53, 10'd79, 10'd106, 10'd158, 10'd159, 10'd237, 10'd212, 10'd316};	    // Note: 3D#Eb
	assign memory[	32	] =	{10'd56, 10'd327, 10'd112, 10'd655, 10'd168, 10'd983, 10'd225, 10'd286};	// Note: 3E
	assign memory[	33	] =	{10'd59, 10'd576, 10'd119, 10'd128, 10'd178, 10'd704, 10'd238, 10'd256};	// Note: 3F
	assign memory[	34	] =	{10'd63, 10'd150, 10'd126, 10'd300, 10'd189, 10'd450, 10'd252, 10'd600};	// Note: 3F#Gb
	assign memory[	35	] =	{10'd66, 10'd922, 10'd133, 10'd821, 10'd200, 10'd720, 10'd267, 10'd619};	// Note: 3G
	assign memory[	36	] =	{10'd70, 10'd846, 10'd141, 10'd669, 10'd212, 10'd491, 10'd283, 10'd314};	// Note: 3G#Ab
	assign memory[	37	] =	{10'd75, 10'd95, 10'd150, 10'd191, 10'd225, 10'd286, 10'd300, 10'd382};	    // Note: 4A
	assign memory[	38	] =	{10'd79, 10'd543, 10'd159, 10'd62, 10'd238, 10'd606, 10'd318, 10'd125};	    // Note: 4A#Bb
	assign memory[	39	] =	{10'd84, 10'd491, 10'd168, 10'd983, 10'd253, 10'd450, 10'd337, 10'd942};	// Note: 4B
	assign memory[	40	] =	{10'd89, 10'd439, 10'd178, 10'd879, 10'd268, 10'd294, 10'd357, 10'd734};	// Note: 4C
	assign memory[	41	] =	{10'd94, 10'd562, 10'd189, 10'd101, 10'd283, 10'd663, 10'd378, 10'd202};	// Note: 4C#Db
	assign memory[	42	] =	{10'd100, 10'd360, 10'd200, 10'd720, 10'd301, 10'd57, 10'd401, 10'd417};	// Note: 4D
	assign memory[	43	] =	{10'd106, 10'd158, 10'd212, 10'd316, 10'd318, 10'd475, 10'd424, 10'd633};	// Note: 4D#Eb
	assign memory[	44	] =	{10'd112, 10'd655, 10'd225, 10'd286, 10'd337, 10'd942, 10'd450, 10'd573};	// Note: 4E
	assign memory[	45	] =	{10'd119, 10'd128, 10'd238, 10'd256, 10'd357, 10'd385, 10'd476, 10'd513};	// Note: 4F
	assign memory[	46	] =	{10'd126, 10'd300, 10'd252, 10'd600, 10'd378, 10'd901, 10'd505, 10'd177};	// Note: 4F#Gb
	assign memory[	47	] =	{10'd133, 10'd821, 10'd267, 10'd619, 10'd401, 10'd417, 10'd535, 10'd215};	// Note: 4G
	assign memory[	48	] =	{10'd141, 10'd669, 10'd283, 10'd314, 10'd424, 10'd983, 10'd566, 10'd628};	// Note: 4G#Ab
	assign memory[	49	] =	{10'd150, 10'd191, 10'd300, 10'd382, 10'd450, 10'd573, 10'd600, 10'd764};	// Note: 5A
	assign memory[	50	] =	{10'd159, 10'd62, 10'd318, 10'd125, 10'd477, 10'd188, 10'd636, 10'd251};	// Note: 5A#Bb
	assign memory[	51	] =	{10'd168, 10'd983, 10'd337, 10'd942, 10'd506, 10'd901, 10'd675, 10'd860};	// Note: 5B
	assign memory[	52	] =	{10'd178, 10'd879, 10'd357, 10'd734, 10'd536, 10'd589, 10'd715, 10'd445};	// Note: 5C
	assign memory[	53	] =	{10'd189, 10'd101, 10'd378, 10'd202, 10'd567, 10'd303, 10'd756, 10'd404};	// Note: 5C#Db
	assign memory[	54	] =	{10'd200, 10'd720, 10'd401, 10'd417, 10'd602, 10'd114, 10'd802, 10'd835};	// Note: 5D
	assign memory[	55	] =	{10'd212, 10'd316, 10'd424, 10'd633, 10'd636, 10'd950, 10'd849, 10'd243};	// Note: 5D#Eb
	assign memory[	56	] =	{10'd225, 10'd286, 10'd450, 10'd573, 10'd675, 10'd860, 10'd901, 10'd122};	// Note: 5E
	assign memory[	57	] =	{10'd238, 10'd256, 10'd476, 10'd513, 10'd714, 10'd770, 10'd953, 10'd2};	    // Note: 5F
	assign memory[	58	] =	{10'd252, 10'd600, 10'd505, 10'd177, 10'd757, 10'd778, 10'd1010, 10'd354};	// Note: 5F#Gb
	assign memory[	59	] =	{10'd267, 10'd619, 10'd535, 10'd215, 10'd802, 10'd835, 10'd0, 10'd0};	    // Note: 5G
	assign memory[	60	] =	{10'd283, 10'd314, 10'd566, 10'd628, 10'd849, 10'd942, 10'd0, 10'd0};	    // Note: 5G#Ab
	assign memory[	61	] =	{10'd300, 10'd382, 10'd600, 10'd764, 10'd901, 10'd122, 10'd0, 10'd0};	    // Note: 6A
	assign memory[	62	] =	{10'd318, 10'd125, 10'd636, 10'd251, 10'd954, 10'd376, 10'd0, 10'd0};	    // Note: 6A#Bb
	assign memory[	63	] =	{10'd337, 10'd942, 10'd675, 10'd860, 10'd1013, 10'd778, 10'd0, 10'd0};	    // Note: 6B

endmodule					