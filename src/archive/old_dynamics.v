`define SWIDTH 3
`define IDLE        3'd0
`define ATTACK      3'd1
`define DECAY       3'd2
`define SUSTAIN     3'd3
`define RELEASE     3'd4

module old_dynamics(
    input clk,
    input reset,
    input play_enable,             
    input [15:0] sample_in,
    input [5:0] duration,   
    input [3:0] attack_time,
    input [3:0] decay_time,
    input [3:0] sustain_time,    
    input [3:0] release_time,
    input beat,
    input new_sample_ready,
    output reg [15:0] sample_out
)

    // Flip flop for FSM state
    reg [`SWIDTH - 1:0] next_state;
    dffr #(`SWIDTH) fsm(
        .clk(clk), .r(reset || !play_enable),
        .d(next_state), .q(state)
    );

    // Note: 0 for count means to skip, 1 is the fastest, and 15 is the slowest (15 - time = time_step)
    // Counter for attack
    wire [3:0] attack_count;
    wire attack_overflow;
    dffre #(4) attack_fsm(
        .clk(beat), .r(reset || new_sample_ready || state == `IDLE),
        .en(state == `ATTACK && !attack_overflow),
        .d({attack_overflow, attack_count} + (4'd15 - attack_time)), .q({attack_overflow, attack_count})
    );

    // Counter for decay
    wire [3:0] decay_count;
    wire decay_overflow;
    dffre #(4) decay_fsm(
        .clk(beat), .r(reset || new_sample_ready || state == `IDLE),
        .en(state == `DECAY && !decay_overflow),
        .d({decay_overflow, decay_count} + (4'd15 - decay_time)), .q({decay_overflow, decay_count})
    );

    // Counter for sustain
    wire [3:0] sustain_count;
    wire sustain_overflow;
    dffre #(4) sustain_fsm(
        .clk(beat), .r(reset || new_sample_ready || state == `IDLE),
        .en(state == `SUSTAIN && !sustain_overflow),
        .d({sustain_overflow, sustain_count} + (4'd15 - sustain_time)), .q({sustain_overflow, sustain_count})
    );

    // Counter for release
    wire [3:0] release_count;
    wire release_overflow;
    dffre #(4) release_fsm(
        .clk(beat), .r(reset || new_sample_ready || state == `IDLE),
        .en(state == `RELEASE && !release_overflow),
        .d({release_overflow, release_count} + (4'd15 - release_time)), .q({release_overflow, release_count})
    );

    // Case statements for FSM
    always @(*) begin
        case(state)
            `IDLE:   next_state = (play_enable && new_sample_ready) ? `ATTACK : `IDLE;
            `ATTACK: next_state = (play_enable && attack_count == 4'd15) ? `DECAY : `ATTACK;
            `DECAY:  next_state = (play_enable && decay_count == 4'd15) ? `SUSTAIN : `DECAY;
            `SUSTAIN: next_state = (play_enable && sustain_count == sustain_time) ? `RELEASE : `SUSTAIN;
            `RELEASE: next_state = (play_enable && release_count == 4'd15) ? `IDLE : `RELEASE;
        endcase
    end

    // Case statements the different parts of the envelop profile
    always @(*) begin
        case(state)
            `IDLE:    sample_out = 0;
            `ATTACK:  sample_out = attack_sample;
            `DECAY:   sample_out = decay_sample;
            `SUSTAIN: sample_out = sample_in >> 4;
            `RELEASE: sample_out = release_sample;
        endcase
    end


    // Table for the exponential decay of the sample
    wire [3:0] decay_exponential_table [15:0];	

    always @(posedge clk)				
		decay_sample = decay_exponential_table[decay_count];	
 
    assign decay_exponential_table[  0 ] = sample_in >> 0;
    assign decay_exponential_table[  1 ] = sample_in >> 0;
    assign decay_exponential_table[  2 ] = sample_in >> 0;
    assign decay_exponential_table[  3 ] = sample_in >> 0;
    assign decay_exponential_table[  4 ] = sample_in >> 1;
    assign decay_exponential_table[  5 ] = sample_in >> 1;
    assign decay_exponential_table[  6 ] = sample_in >> 1;
    assign decay_exponential_table[  7 ] = sample_in >> 1;
    assign decay_exponential_table[  8 ] = sample_in >> 2;
    assign decay_exponential_table[  9 ] = sample_in >> 2;
    assign decay_exponential_table[ 10 ] = sample_in >> 2;
    assign decay_exponential_table[ 11 ] = sample_in >> 2;
    assign decay_exponential_table[ 12 ] = sample_in >> 3;
    assign decay_exponential_table[ 13 ] = sample_in >> 3;
    assign decay_exponential_table[ 14 ] = sample_in >> 3;
    assign decay_exponential_table[ 15 ] = sample_in >> 3;


    // Table for the linear attack of the sample
    wire [15:0] linear_table [15:0];
    wire [3:0] linear_a, linear_b, linear_c, linear_d;

    always @(posedge clk)				
		{linear_a, linear_b, linear_c, linear_d} = linear_table[attack_count];	

    divide linear_divide(.numerator(sample_in), 
                         .a(linear_a), .b(linear_b), .c(linear_b), .c(linear_b),
                         .dout(attack_sample));
 
    assign linear_table[  0 ] = {4'd5,  4'd6,  4'd7,  4'd8 };
    assign linear_table[  1 ] = {4'd3,  4'd8,  4'd10, 4'd14};
    assign linear_table[  2 ] = {4'd3,  4'd4,  4'd9,  4'd11};
    assign linear_table[  3 ] = {4'd2,  4'd0,  4'd0,  4'd0 };
    assign linear_table[  4 ] = {4'd2,  4'd5,  4'd6,  4'd7 };
    assign linear_table[  5 ] = {4'd2,  4'd3,  4'd8,  4'd10};
    assign linear_table[  6 ] = {4'd2,  4'd3,  4'd4,  4'd9 };
    assign linear_table[  7 ] = {4'd1,  4'd0,  4'd0,  4'd0 };
    assign linear_table[  8 ] = {4'd1,  4'd5,  4'd6,  4'd7 };
    assign linear_table[  9 ] = {4'd1,  4'd3,  4'd8,  4'd10};
    assign linear_table[ 10 ] = {4'd1,  4'd3,  4'd4,  4'd9 };
    assign linear_table[ 11 ] = {4'd1,  4'd2,  4'd0,  4'd0 };
    assign linear_table[ 12 ] = {4'd1,  4'd2,  4'd5,  4'd6 };
    assign linear_table[ 13 ] = {4'd1,  4'd2,  4'd3,  4'd8 };
    assign linear_table[ 14 ] = {4'd1,  4'd2,  4'd3,  4'd4 };
    assign linear_table[ 15 ] = {4'd0,  4'd0,  4'd0,  4'd0 };


    // Table for the exponential release of the sample
    wire [3:0] release_exponential_table [15:0];	

    always @(posedge clk)				
		release_sample = release_exponential_table[release_count];	
 
    assign release_exponential_table[  0 ] = sample_in >> 4;
    assign release_exponential_table[  1 ] = sample_in >> 4;
    assign release_exponential_table[  2 ] = sample_in >> 5;
    assign release_exponential_table[  3 ] = sample_in >> 5;
    assign release_exponential_table[  4 ] = sample_in >> 6;
    assign release_exponential_table[  5 ] = sample_in >> 6;
    assign release_exponential_table[  6 ] = sample_in >> 7;
    assign release_exponential_table[  7 ] = sample_in >> 7;
    assign release_exponential_table[  8 ] = sample_in >> 8;
    assign release_exponential_table[  9 ] = sample_in >> 9;
    assign release_exponential_table[ 10 ] = sample_in >> 10;
    assign release_exponential_table[ 11 ] = sample_in >> 11;
    assign release_exponential_table[ 12 ] = sample_in >> 12;
    assign release_exponential_table[ 13 ] = sample_in >> 13;
    assign release_exponential_table[ 14 ] = sample_in >> 14;
    assign release_exponential_table[ 15 ] = sample_in >> 15;
    

endmodule