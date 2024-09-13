module harmonic_fourier_rom(
    input clk,
    input [2:0] metadata,
    output reg [31:0] dout // dout = {addr1, addr2, addr3, addr4, is_neg1, is_neg2, is_neg3, is_neg4}
);

    wire [31:0] memory [7:0];

    // ROM for the different harmonic wave types 
    always @(posedge clk)
        dout = memory[metadata];

    assign memory[0] = {7'd100 , 7'd0   , 7'd0   , 7'd0    , 1'b0, 1'b0, 1'b0, 1'b0};    // Metadata 0: Simple Sine Wave
    assign memory[1] = {7'd55  , 7'd30  , 7'd19  , 7'd14   , 1'b0, 1'b1, 1'b0, 1'b1};    // Metadata 1: Sawtooth Wave
    assign memory[2] = {7'd75  , 7'd0   , 7'd25  , 7'd0    , 1'b0, 1'b0, 1'b0, 1'b0};    // Metadata 2: Square Wave
    assign memory[3] = {7'd0   , 7'd90  , 7'd0   , 7'd10   , 1'b0, 1'b0, 1'b0, 1'b0};    // Metadata 3: Triangle Wave
    assign memory[4] = {7'd67  , 7'd7   , 7'd21  , 7'd5    , 1'b0, 1'b0, 1'b0, 1'b0};    // Metadata 4: Piano 
    assign memory[5] = {7'd32  , 7'd22  , 7'd41  , 7'd5    , 1'b0, 1'b0, 1'b0, 1'b0};    // Metadata 5: Guitar
    assign memory[6] = {7'd53  , 7'd21  , 7'd14  , 7'd12   , 1'b0, 1'b0, 1'b0, 1'b0};    // Metadata 6: Horn
    assign memory[7] = {7'd60  , 7'd22   , 7'd16  , 7'd2   , 1'b0, 1'b0, 1'b0, 1'b0};    // Metadata 7: Clarinet

endmodule



// For older implementation
module fourier_rom(
    input clk,
    input [2:0] metadata,
    input [1:0] num_notes,
    output reg [31:0] dout // dout = {addr1, addr2, addr3, addr4, is_neg1, is_neg2, is_neg3, is_neg4}
);

    wire [31:0] memory [2:0];

    // ROM for the different harmonic wave types 
    always @(posedge clk)
        // {addr1, addr2, addr3, addr4, is_neg1, is_neg2, is_neg3, is_neg4} = memory[metadata];
        dout = memory[metadata];

    assign memory[0] = {meta0_1, meta0_2, meta0_3, meta0_4, 1'b0, 1'b0, 1'b0, 1'b0};    // Metadata 0: Simple Sine Wave
    assign memory[1] = {7'd55  , 7'd30  , 7'd19  , 7'd14  , 1'b0, 1'b1, 1'b0, 1'b1};    // Metadata 1: Sawtooth Wave
    assign memory[2] = {7'd75  , 7'd0   , 7'd25  , 7'd0   , 1'b0, 1'b0, 1'b0, 1'b0};    // Metadata 2: Square Wave
    assign memory[3] = {7'd0   , 7'd90  , 7'd0   , 7'd10  , 1'b0, 1'b0, 1'b0, 1'b0};    // Metadata 3: Triangle Wave
    assign memory[4] = {7'd50  , 7'd5   , 7'd16  , 7'd4   , 1'b0, 1'b0, 1'b0, 1'b0};    // Metadata 4: Piano 
    assign memory[5] = {7'd79  , 7'd54  , 7'd100 , 7'd11  , 1'b0, 1'b0, 1'b0, 1'b0};    // Metadata 5: Guitar
    assign memory[6] = {7'd100 , 7'd40  , 7'd25  , 7'd22  , 1'b0, 1'b0, 1'b0, 1'b0};    // Metadata 6: Horn
    assign memory[7] = {7'd100 , 7'd37  , 7'd27  , 7'd2   , 1'b0, 1'b0, 1'b0, 1'b0};    // Metadata 7: Clarinet


    // Logic for just playing a regular note (metadata = 0) 
    // and we need to sum each note equally
    // and it depends on the number of notes loaded
    reg [6:0] meta0_1, meta0_2, meta0_3, meta0_4;
    always @(*) begin
        case(num_notes)
            2'b00: {meta0_1, meta0_2, meta0_3, meta0_4} = {7'd100, 7'd0  , 7'd0  , 7'd0  }; // 1 note  played @ 100%
            2'b01: {meta0_1, meta0_2, meta0_3, meta0_4} = {7'd50 , 7'd50 , 7'd0  , 7'd0  }; // 2 notes played @ 50%
            2'b10: {meta0_1, meta0_2, meta0_3, meta0_4} = {7'd33 , 7'd33 , 7'd33 , 7'd0  }; // 3 notes played @ 33%
            2'b11: {meta0_1, meta0_2, meta0_3, meta0_4} = {7'd25 , 7'd25 , 7'd25 , 7'd25 }; // 4 notes played @ 25%
        endcase
    end

endmodule