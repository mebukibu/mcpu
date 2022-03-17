`include "../data/state_d.v"
module ramreader (clk, cs, opc, add, d, kp, adq, q);

  input clk;
  input [2:0] cs;
  input [7:0] opc, d;
  input [15:0] add;
  output kp;
  output [15:0] adq;
  output [63:0] q;
  reg kp;
  reg [15:0] adq;
  reg [63:0] q;

  reg [2:0] tim;
  reg [2:0] cnt;

  always @(cs, opc, add, d, cnt, tim) begin
    if (cs == `OPCFT) begin
      tim <= 6;
      kp <= 1;
    end
    else if (cs == `ADRD) begin
      case (opc)
        `POP    : begin tim <= 7; kp <= 1; end
        `MOVRA  : begin tim <= 7; kp <= 1; end
        `MOVRA4 : begin tim <= 3; kp <= 1; end
        `MOVRA1 : begin tim <= 0; kp <= 0; end
        default : begin tim <= 0; kp <= 0; end
      endcase
    end
    else if (cs == `OPLRD | cs == `EXERD)
      if (cnt == tim)
        kp <= 0;    
  end

  always @(posedge clk) begin
    if (cs == `OPCFT) begin
      adq <= add + 1;
      cnt <= 0;
    end
     if (cs == `ADRD) begin
      adq <= add;
      cnt <= 0;
     end
     else if (cs == `OPLRD | cs == `EXERD) begin
      cnt <= cnt + 1;
      adq <= adq + 1;
    end
  end

  always @(cnt, d)
    case (cnt)
      0 : q[7:0]   <= d;
      1 : q[15:8]  <= d;
      2 : q[23:16] <= d;
      3 : q[31:24] <= d;
      4 : q[39:32] <= d;
      5 : q[47:40] <= d;
      6 : q[55:48] <= d;
      7 : q[63:56] <= d;
      default : q <= {64{1'bX}};
    endcase

endmodule