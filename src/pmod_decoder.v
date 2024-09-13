module pmod_decoder(
  input clk,
  input reset,
  input [3:0] row,
  output [3:0] col,
  output reg [3:0] key_val);
  
  reg [15:0] button_reg;
  reg [1:0] state;
  wire clk_state, sample;
  reg [15:0] counter;

  assign clk_state = counter[15];
  assign sample = counter[7];

  always@* begin
    casex(button_reg)
      16'b1xxxxxxxxxxxxxxx: key_val = 4'hf;
      16'b01xxxxxxxxxxxxxx: key_val = 4'he;
      16'b001xxxxxxxxxxxxx: key_val = 4'hd;
      16'b0001xxxxxxxxxxxx: key_val = 4'hc;
      16'b00001xxxxxxxxxxx: key_val = 4'hb;
      16'b000001xxxxxxxxxx: key_val = 4'ha;
      16'b0000001xxxxxxxxx: key_val = 4'h9;
      16'b00000001xxxxxxxx: key_val = 4'h8;
      16'b000000001xxxxxxx: key_val = 4'h7;
      16'b0000000001xxxxxx: key_val = 4'h6;
      16'b00000000001xxxxx: key_val = 4'h5;
      16'b000000000001xxxx: key_val = 4'h4;
      16'b0000000000001xxx: key_val = 4'h3;
      16'b00000000000001xx: key_val = 4'h2;
      16'b000000000000001x: key_val = 4'h1;
      16'b0000000000000001: key_val = 4'h0;
      default: key_val = 4'h0;
    endcase
  end

  always@(posedge clk or posedge reset) begin
    if(reset) begin
      counter <= 16'd0;
    end else  begin
      counter <= counter + 16'd1;
    end
  end

  always@(posedge clk_state or posedge reset) begin
    if(reset) begin
      state <= 2'd0;
    end else  begin
      state <= state + 2'd1;
    end
  end
  

  always@(posedge sample) begin
    case(state)
      2'b00: begin
        button_reg[1]  <= ~row[0]; //1
        button_reg[4]  <= ~row[1]; //4
        button_reg[7]  <= ~row[2]; //7
        button_reg[0]  <= ~row[3]; //0
      end
      2'b01: begin
        button_reg[2]  <= ~row[0]; //2
        button_reg[5]  <= ~row[1]; //5
        button_reg[8]  <= ~row[2]; //8
        button_reg[15] <= ~row[3]; //F
      end
      2'b10: begin
        button_reg[3]  <= ~row[0]; //3
        button_reg[6]  <= ~row[1]; //6
        button_reg[9]  <= ~row[2]; //9
        button_reg[14] <= ~row[3]; //E
      end
      2'b11: begin
        button_reg[10] <= ~row[0]; //A
        button_reg[11] <= ~row[1]; //B
        button_reg[12] <= ~row[2]; //C
        button_reg[13] <= ~row[3]; //D
      end
    endcase
  end
  
  assign col[0] = (state != 2'b00);
  assign col[1] = (state != 2'b01);
  assign col[2] = (state != 2'b10);
  assign col[3] = (state != 2'b11);
endmodule