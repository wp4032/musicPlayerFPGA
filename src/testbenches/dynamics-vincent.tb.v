module dynamics_vincent_tb();

    reg clk, reset, play, note_done, generate_next_sample;
    reg [1:0] song;
    wire [5:0] note1, note2, note3, note4;
    wire [2:0] metadata1, metadata2, metadata3, metadata4;
    wire [5:0] duration;
    wire done_with_note, new_sample_ready;
    wire beat;
    wire song_done, new_note;
    wire [1:0] num_notes;
    wire [15:0] sample_out;

    wire [15:0] dynamics_sample_out;
    reg [1:0] attack_time_pow, decay_time_pow, release_time_pow;
    reg dtoggle;
    wire minibeat, dynamic_sample_ready;

    song_reader dut(
        .clk(clk),
        .reset(reset),
        .play(play),
        .song(song),
        .note_done(done_with_note),
        .song_done(song_done),
        .note1(note1),
        .note2(note2),
        .note3(note3),
        .note4(note4),
        .duration(duration),
        .new_note(new_note),
        .num_notes(num_notes),
        .metadata1(metadata1),
        .metadata2(metadata2),
        .metadata3(metadata3),
        .metadata4(metadata4)
    );

    notes_player nsp(
        .clk(clk),
        .reset(reset),

        .play_enable(play),
        .note1(note1), .note2(note2), .note3(note3), .note4(note4),
        .duration(duration),
        .load_new_note(new_note),
        .done_with_note(done_with_note),

        .beat(beat),
        .generate_next_sample(generate_next_sample),
        .num_notes(num_notes),
        .metadata1(metadata1), .metadata2(metadata2), .metadata3(metadata3), .metadata4(metadata4),
        .sample_out(sample_out),
        .new_sample_ready(new_sample_ready)
    );

    parameter BEAT_COUNT = 1000;

    beat_generator #(.WIDTH(10), .STOP(BEAT_COUNT)) bg(
        .clk(clk),
        .reset(reset),
        .en(generate_next_sample),
        .beat(beat)
    );

    dynamic_generator dg(
        .clk(clk),
        .reset(reset),
        .en(generate_next_sample),
        .beat(minibeat)
    );

    dynamics dynt(
    .clk(clk),
    .reset(reset),
    .play_enable(play),           
    .sample_in(sample_out),
    .duration(duration),     
    .attack_time_pow(attack_time_pow),
    .decay_time_pow(decay_time_pow),
    .release_time_pow(release_time_pow),
    .minibeat(minibeat),
    .toggle_dynamics(dtoggle),
    .sample_ready(new_sample_ready),
    .sample_out(dynamics_sample_out),
    .dynamic_sample_ready(dynamic_sample_ready)
);

    // Clock and reset
    initial begin
        clk = 1'b0;
        generate_next_sample = 1'b0;
        reset = 1'b1;
        repeat (5) #5 clk = ~clk;
        generate_next_sample = ~generate_next_sample;
        reset = 1'b0;
        forever begin
            #5 clk = ~clk;
            generate_next_sample = ~generate_next_sample;
        end
    end

    // Tests
    initial begin
        note_done = 0;
        play = 0;
        song = 3;
        #40
        play = 1;
        dtoggle = 1;
        attack_time_pow = 3;
        decay_time_pow = 3;
        release_time_pow = 3;
    end

endmodule
