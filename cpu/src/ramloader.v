`include "../data/state_d.v"
module ramloader (clk, wr, cs, addr, d, kp, adq, q);

  input clk;
  input [1:0] wr;
  input [2:0] cs;
  input [15:0] addr;
  input [63:0] d;
  output kp;
  output [15:0] adq;
  output [7:0] q;
  reg kp;
  reg [15:0] adq;
  reg [7:0] q;

  reg [2:0] tim;
  reg [2:0] cnt;
  reg [63:0] data;

  always @(cs, wr, addr, d, cnt, tim) begin
    if (cs == `EXE) begin
      data <= d;
      case (wr)
        2'b00 : begin tim <= 0; kp <= 0; end
        2'b01 : begin tim <= 0; kp <= 0; end
        2'b10 : begin tim <= 3; kp <= 1; end
        2'b11 : begin tim <= 7; kp <= 1; end
      endcase
    end
    else if (cs == `LOAD)
      if (cnt == tim)
        kp <= 0;
  end

  always @(posedge clk) begin
    if (cs == `EXE) begin
      cnt <= 0;
      adq <= addr;
    end
    else if (cs == `LOAD) begin
      cnt <= cnt + 1;
      adq <= adq + 1;      
    end
  end

  always @(cnt, data)
    case (cnt)
      3'd0 : q <= data[7:0];
      3'd1 : q <= data[15:8];
      3'd2 : q <= data[23:16];
      3'd3 : q <= data[31:24];
      3'd4 : q <= data[39:32];
      3'd5 : q <= data[47:40];
      3'd6 : q <= data[55:48];
      3'd7 : q <= data[63:56];
      default : q <= 8'hXX;
    endcase

endmodule