//
//  music_player module
//
//  This music_player module connects up the MCU, song_reader, note_player,
//  beat_generator, and codec_conditioner. It provides an output that indicates
//  a new sample (new_sample_generated) which will be used in lab 5.
//

module music_player(
    // Standard system clock and reset
    input clk,
    input reset,

    // Our debounced and one-pulsed button inputs.
    input play_button,
    input next_button,
    input dynamics_button,

    // The raw new_frame signal from the ac97_if codec.
    input new_frame,

    // This output must go high for one cycle when a new sample is generated.
    output wire new_sample_generated,

    // Our final output sample to the codec. This needs to be synced to
    // new_frame.
    output wire [15:0] sample_out,
    input wire [3:0] key_val
);
    // The BEAT_COUNT is parameterized so you can reduce this in simulation.
    // If you reduce this to 100 your simulation will be 10x faster.
    parameter BEAT_COUNT = 1000;


//
//  ****************************************************************************
//      Master Control Unit
//  ****************************************************************************
//   The reset_player output from the MCU is run only to the song_reader because
//   we don't need to reset any state in the note_player. If we do it may make
//   a pop when it resets the output sample.
//
 
    wire play;
    wire reset_player;
    wire [1:0] current_song;
    wire song_done;
    mcu mcu(
        .clk(clk),
        .reset(reset),
        .play_button(play_button),
        .next_button(next_button),
        .play(play),
        .reset_player(reset_player),
        .song(current_song),
        .song_done(song_done)
    );

//
//  ****************************************************************************
//      Song Reader
//  ****************************************************************************
//
    wire [5:0] note1, note2, note3, note4;
    wire [5:0] duration_for_note;
    wire new_note;
    wire note_done;
    wire [1:0] num_notes;
    wire [2:0] metadata1, metadata2, metadata3, metadata4;
    song_reader song_reader(
        .clk(clk),
        .reset(reset | reset_player),
        .play(play),
        .song(current_song),
        .note_done(note_done),
        .song_done(song_done),
        .note1(note1),
        .note2(note2),
        .note3(note3),
        .note4(note4),
        .duration(duration_for_note),
        .new_note(new_note),
        .num_notes(num_notes),
        .metadata1(metadata1),
        .metadata2(metadata2),
        .metadata3(metadata3),
        .metadata4(metadata4)
    );

//   
//  ****************************************************************************
//      Note Player
//  ****************************************************************************
//  
    wire beat;
    wire generate_next_sample;
    wire [15:0] note_sample;
    wire note_sample_ready;
    notes_player notes_player(
        .clk(clk),
        .reset(reset),
        .play_enable(play),
        .note1(note1),
        .note2(note2),
        .note3(note3),
        .note4(note4),
        .duration(duration_for_note),
        .load_new_note(new_note),
        .beat(beat),
        .generate_next_sample(generate_next_sample),
        .num_notes(num_notes),
        .metadata1(metadata1),
        .metadata2(metadata2),
        .metadata3(metadata3),
        .metadata4(metadata4),
        .dtoggle(dynamics_button),
        .done_with_note(note_done),
        .sample_out(note_sample),
        .new_sample_ready(note_sample_ready)
    );
      
//   
//  ****************************************************************************
//      Beat Generator
//  ****************************************************************************
//  By default this will divide the generate_next_sample signal (48kHz from the
//  codec's new_frame input) down by 1000, to 48Hz. If you change the BEAT_COUNT
//  parameter when instantiating this you can change it for simulation.
//  
    beat_generator #(.WIDTH(10), .STOP(BEAT_COUNT)) beat_generator(
        .clk(clk),
        .reset(reset),
        .en(generate_next_sample),
        .beat(beat)
    );

//   
//  ****************************************************************************
//      Key_board
//  ****************************************************************************
// 

    key_board key_board(
        .clk(clk),
        .reset(reset),
        .enable((!play) && (key_val != 4'h0)),
        .beat(beat),
        .generate_next_sample(generate_next_sample),
        .key_val(key_val),
        .key_note_sample(key_note_sample),
        .key_note_sample_ready(key_note_sample_ready)
    );

    wire [15:0] key_note_sample;
    wire key_note_sample_ready;
    wire [15:0] note_sample_mux;
    wire note_sample_ready_mux;
    assign note_sample_mux = play? note_sample : 
                                    (key_val == 4'h0)? 0 :  key_note_sample;
    assign note_sample_ready_mux = play? note_sample_ready : 
                                    (key_val == 4'h0)? 0 : key_note_sample_ready;
//  
//  ****************************************************************************
//      Codec Conditioner
//  ****************************************************************************
//  
    assign new_sample_generated = generate_next_sample;
    codec_conditioner codec_conditioner(
        .clk(clk),
        .reset(reset),
        .new_sample_in(note_sample_mux),
        .latch_new_sample_in(note_sample_ready_mux),
        .generate_next_sample(generate_next_sample),
        .new_frame(new_frame),
        .valid_sample(sample_out)
    );

endmodule
