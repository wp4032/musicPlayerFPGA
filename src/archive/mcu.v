`define SWIDTH 1
`define PAUSE 1'b0
`define PLAY 1'b1

module mcu(
    input clk,
    input reset,
    input play_button,
    input next_button,
    output play,
    output reset_player,
    output [1:0] song,
    input song_done
);

    dffre #(.WIDTH(2)) song_reg (
        .clk(clk),
        .r(reset),
        .en(next_button || song_done),
        .d(song + 1'b1),
        .q(song)
    );

    wire state;
    reg  next_state;

    dffr #(.WIDTH(`SWIDTH)) playing_reg (
        .clk(clk),
        .r(reset),
        .d(next_state),
        .q(state)
    );

    assign play = (state == `PLAY);
    assign reset_player = next_button || song_done;

    always @* begin
        case (state)
            `PAUSE:  next_state = play_button ? `PLAY : state;
            `PLAY:   next_state =
                (play_button || next_button || song_done) ? `PAUSE : state;
            default: next_state = `PAUSE;
        endcase
    end

endmodule
