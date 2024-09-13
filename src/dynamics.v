//
//  dynamics module
//

`define W 3'b000
`define A 3'b001
`define D 3'b010
`define S 3'b011
`define R 3'b100

module dynamics (
    input clk,
    input reset,
    input play_enable,             
    input [15:0] sample_in,
    
    input [5:0] duration,     //not fine grained, in units of beats (48 per s)
    input [1:0] attack_time_pow,  //fine grained, in units of log2 minibeats (minibeats are 4*48 = 192 per s)
    input [1:0] decay_time_pow,   //fine grained, in units of log2 minibeats (minibeats are 4*48 = 192 per s)
    input [1:0] release_time_pow, //fine grained, in units of log2 minibeats (minibeats are 4*48 = 192 per s)
    input minibeat, //fine grained beat to allow for full ADSR within minimum duration of notes (constrained to at least 4 beats)
    input toggle_dynamics, //on if 1, off if 0
    input sample_ready, //shorted these two together, since there's no timing delays
    output dynamic_sample_ready,
    output [15:0] sample_out //muxed between dynamics on/off
);

//our dynamics only progresses when all three conditions are met
wire go;
assign go = minibeat && toggle_dynamics && play_enable;

//holds the processed outputs
wire [15:0] dynamic_sample, next_dynamic_sample; 

dffre #(.WIDTH(16)) sample_updater ( //for sequential updating of samples
    .clk(clk),
    .r(reset),
    .en(play_enable),
    .d(next_dynamic_sample),
    .q(dynamic_sample)
);

//mux to toggle dynamics
assign sample_out = toggle_dynamics ? dynamic_sample : sample_in;

//short together the two sample readys since there is no appreciable delay
assign dynamic_sample_ready = sample_ready;

wire [7:0] count, next_count; //in units of minibeats

dffre #(.WIDTH(8)) counter ( //to count through state's duration
    .clk(clk),
    .r(reset),
    .en(go),
    .d(next_count),
    .q(count)
);

//wire to indicate when each state is done
wire state_done;
assign state_done = (count == duration_to_load);

//next count will initialize with different values depending on the state
assign next_count = (reset || state_done) ? 0 : count + 1;

//this reg helps decompose what next_count would be initialized to, based off the state
reg [7:0] next_duration;
wire [7:0] duration_to_load;

dffr #(8) duration_ff(
    .clk(clk),
    .r(reset),
    .d(next_duration),
    .q(duration_to_load)
);

//map the input time powers into their actual durations for counting
wire [3:0] attack_time, decay_time, release_time;
assign attack_time = 1'b1 << attack_time_pow;
assign decay_time = 1'b1 << decay_time_pow;
assign release_time = 1'b1 << release_time_pow;

//logic for moving between ADSR
wire [2:0] state;
reg [2:0] next_state;

dffre #(.WIDTH(3)) state_fsm ( // to switch between the A D S R states
    .clk(clk),
    .r(reset),
    .en(toggle_dynamics && play_enable),
    .d(next_state),
    .q(state)
);

//wires for logic for preserving the magnitude and sign of bitshifted samples
wire [15:0] unsigned_sample_in;
assign unsigned_sample_in = sample_in[15] ? -sample_in : sample_in;
reg [15:0] unsigned_next_dynamic_sample;

always @(*) begin //cycle through the states
    case (state)
        `A: begin
            next_state = (go && state_done) ? `D : `A;
            next_duration = attack_time;
            unsigned_next_dynamic_sample = count * (unsigned_sample_in >> attack_time_pow);
        end
        `D: begin
            next_state = (go && state_done) ? `S : `D; 
            next_duration = decay_time;
            unsigned_next_dynamic_sample = (unsigned_sample_in >> 1) + (unsigned_sample_in >> (1 + count * (1 << (4 - decay_time_pow))));
        end
        `S: begin
            next_state = (go && state_done) ? `R : `S; 
            next_duration = (duration << 2) - (attack_time + decay_time + release_time);
            unsigned_next_dynamic_sample = unsigned_sample_in >> 1;
        end     
        `R: begin
            next_state = (go && state_done) ? `W : `R; 
            next_duration = release_time;
            unsigned_next_dynamic_sample = unsigned_sample_in >> (1 + count * (1 << (4 - release_time_pow)));
        end
        `W: begin
            next_state = (toggle_dynamics && play_enable && sample_ready) ? `A : `W;
            next_duration = 0;
            unsigned_next_dynamic_sample = 0;
        end
        default:    
            next_state = `W;
    endcase
end

//magic final line to match the sign of the dynamic output with sample input
assign next_dynamic_sample = sample_in[15] ? -unsigned_next_dynamic_sample : unsigned_next_dynamic_sample;


endmodule