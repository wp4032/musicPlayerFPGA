// VINCENT / WILLIAM
`define SONG_WIDTH 7
`define NOTE_WIDTH 6
`define DURATION_WIDTH 6
`define METADATA_WIDTH 3 //what width?
// there's a play bit MSB

// ----------------------------------------------
// Define State Assignments
// ----------------------------------------------
// `define SWIDTH 3
// `define IDLE            3'b000
// `define DELAY           3'b001
// `define NOTE1           3'b010
// `define NOTE2           3'b011
// `define NOTE3           3'b100
// `define NOTE4           3'b101
// `define PLAY            3'b110
// `define WAIT            3'b111

`define SWIDTH 4
`define IDLE            4'b0000
`define LOAD            4'b0001
`define DELAY           4'b0010
`define NOTE1           4'b0011
`define NOTE2           4'b0100
`define NOTE3           4'b0101
`define NOTE4           4'b0110
`define PLAY            4'b0111
`define WAIT            4'b1000

module old_song_reader(
   input clk,
   input reset,
   input play,
   input [1:0] song,
   input note_done,
   output wire song_done,
   output wire [5:0] note1,
   output wire [5:0] note2, //new additional
   output wire [5:0] note3, //new additional
   output wire [5:0] note4, //new additional
   output wire [5:0] duration, 
   output wire new_note,  
   output wire [1:0] num_notes, //new output
   output wire [2:0] metadata   //for harmonics
);

    // Declaring wires
    wire [`SONG_WIDTH - 1:0] curr_songaddr, next_songaddr; 
    wire [`SONG_WIDTH + 1:0] rom_addr = {song, curr_songaddr};
    wire [`NOTE_WIDTH + `DURATION_WIDTH + `METADATA_WIDTH:0] note_duration_metadata;

    wire [`SWIDTH-1:0] state;
    reg  [`SWIDTH-1:0] next;

    // ROM for addressing the song
    song_rom rom(.clk(clk), .addr(rom_addr), .dout(note_duration_metadata));

    // Case statements for FSM
    // always @(*) begin
    //     case (state)
    //         `IDLE:      next = play ? `DELAY : `IDLE; 
    //         `DELAY:     next = play ? `NOTE1 : `IDLE; 
    //         `NOTE1:     next = play ? (trigger ? `PLAY : `NOTE2) : `IDLE; 
    //         `NOTE2:     next = play ? (trigger ? `PLAY : `NOTE3) : `IDLE;
    //         `NOTE3:     next = play ? (trigger ? `PLAY : `NOTE4) : `IDLE;
    //         `NOTE4:     next = play ? `PLAY : `IDLE;
    //         `PLAY:      next = play ? `WAIT : `IDLE;
    //         `WAIT:      next = note_done ? `IDLE : `WAIT;
    //         default:    next = `IDLE;
    //     endcase
    // end

    always @(*) begin
        case (state)
            `IDLE:      next = play ? `LOAD : `IDLE; 
            `LOAD:      next = play ? `DELAY : `IDLE; 
            `DELAY:     next = play ? `NOTE1 : `IDLE; 
            `NOTE1:     next = play ? ((trigger && !is_harmonic) ? `PLAY : `NOTE2) : `IDLE; 
            `NOTE2:     next = play ? ((trigger && !is_harmonic) ? `PLAY : `NOTE3) : `IDLE;
            `NOTE3:     next = play ? ((trigger && !is_harmonic) ? `PLAY : `NOTE4) : `IDLE;
            `NOTE4:     next = play ? `PLAY : `IDLE;
            `PLAY:      next = play ? `WAIT : `IDLE;
            `WAIT:      next = note_done ? `IDLE : `WAIT;
            default:    next = `IDLE;
        endcase
    end

    wire trigger;       // For identifying when we should pass time
    wire overflow;      // For identifying when we reach the end of a song
    assign {overflow, next_songaddr} =
       (state == `LOAD || state == `DELAY || state == `NOTE1 || state == `NOTE2) ? {1'b0, curr_songaddr} + 1
                                     : {1'b0, curr_songaddr};

    // To alert notes player that new notes have been added
    assign new_note = (state == `PLAY); 

    wire [5:0] next_duration;
    wire [2:0] next_metadata;

    assign trigger = note_duration_metadata[15];
    assign note = note_duration_metadata[14:9];
    assign next_duration = note_duration_metadata[8:3];
    assign next_metadata = note_duration_metadata[2:0];
    assign song_done = overflow;


    // Flip flop for address
    dffre #(`SONG_WIDTH) note_counter (
       .clk(clk),
       .r(reset),
       .en(!is_harmonic || (is_harmonic && (state <= `LOAD))),
       .d(next_songaddr),
       .q(curr_songaddr)
    );


    // Flip flop for FSM state
    dffr #(`SWIDTH) fsm (
       .clk(clk),
       .r(reset),
       .d(next),
       .q(state)
    );


    // Case statement for number of notes based on state
    reg [1:0] next_num_notes;
    always @(*) begin
        if(is_harmonic) begin
            next_num_notes = 2'b11;
        end
        else begin
            case(state)
                `DELAY: next_num_notes = 2'b00;
                `NOTE1: next_num_notes = 2'b01;
                `NOTE2: next_num_notes = 2'b10;
                `NOTE3: next_num_notes = 2'b11;
                default: next_num_notes = 2'b00;
            endcase
        end
    end


    // Flip flop for number of notes
    dffre #(2) num_notes_ff (
        .clk(clk),
        .r(reset),
        .en(state < `NOTE3),
        .d(next_num_notes),
        .q(num_notes)
    );


    wire [5:0] note;

    // Flip flops for seperate notes
    dffre #(6) note1_FF(
        .clk(clk), .r(reset || state == `IDLE),
        .en(state == `DELAY), 
        .d(note), .q(note1)
    );

    dffre #(6) note2_FF(
        .clk(clk), .r(reset || state == `IDLE),
        .en(state == `NOTE1), 
        .d(is_harmonic ? harmonic2 : note), .q(note2)
    );

    dffre #(6) note3_FF(
        .clk(clk), .r(reset || state == `IDLE),
        .en(state == `NOTE2), 
        .d(is_harmonic ? harmonic3 : note), .q(note3)
    );

    dffre #(6) note4_FF(
        .clk(clk), .r(reset || state == `IDLE),
        .en(state == `NOTE3), 
        .d(is_harmonic ? harmonic4 : note), .q(note4)
    );


    // Flip flop for metadata
    // NOTE: we made the assumption that the song rom has chords that have the same metadata and duration
    // Add new_note
    dffre #(`DURATION_WIDTH + `METADATA_WIDTH) metadata_duration_FF(
        .clk(clk), .r(reset || state == `IDLE),
        .en(state == `DELAY),
        .d({next_duration, next_metadata}), .q({duration, metadata})
    );


    wire is_harmonic;
    assign is_harmonic = (metadata > 3'd0);

    dffre #(6) harmonic_FF(
        .clk(clk), .r(reset || state == `IDLE),
        .en(state == `DELAY), 
        .d(note), .q(harmonic1)
    );

    wire [`NOTE_WIDTH - 1:0] harmonic1, harmonic2, harmonic3, harmonic4;

    assign harmonic2 = (harmonic1 <= 6'd51) ? harmonic1 + 12 : 6'd0;
    assign harmonic3 = (harmonic1 <= 6'd44) ? harmonic1 + 19 : 6'd0;
    assign harmonic4 = (harmonic1 <= 6'd39) ? harmonic1 + 24 : 6'd0;
    // Logic for harmonics
    // always @(*) begin
    //     case(state):
    //         `DELAY: harmonic = base_harmonic;
    //         `NOTE1: harmonic = note;
    //         `NOTE2: harmonic = note;
    //         `NOTE3: harmonic = note;
    //     endcase
    // end


endmodule