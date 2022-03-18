`include "../data/state_d.v"
module ramreader (clk, cs, opc, addr, d, kp, adq, q);

  input clk;
  input [2:0] cs;
  input [7:0] opc, d;
  input [15:0] addr;
  output kp;
  output [15:0] adq;
  output [63:0] q;
  reg kp;
  reg [15:0] adq;
  reg [63:0] q;

  reg [2:0] tim;
  reg [2:0] cnt;

  always @(posedge clk) begin
    if (cs == `OPCFT) begin
      adq <= addr + 1;
      cnt <= 0;
      kp <= 1;
      tim <= 6;      
    end
    else if (cs == `OPLRD | cs == `EXERD) begin
      adq <= adq + 1;
      cnt <= cnt + 1;
      case (cnt)
        3'd0 : q[7:0]   <= d;
        3'd1 : q[15:8]  <= d;
        3'd2 : q[23:16] <= d;
        3'd3 : q[31:24] <= d;
        3'd4 : q[39:32] <= d;
        3'd5 : q[47:40] <= d;
        3'd6 : q[55:48] <= d;
        3'd7 : q[63:56] <= d;
        default : q <= {64{1'bX}};
      endcase
      if (cnt == tim)
        kp <= 0;
    end
    else if (cs == `OPLFT) begin
      case (opc)
        `POP    : begin tim <= 6; kp <= 1; end
        `MOVRA  : begin tim <= 6; kp <= 1; end
        `MOVRA4 : begin tim <= 2; kp <= 1; end
        `MOVRA1 : begin tim <= 0; kp <= 0; end
        default : begin tim <= 0; kp <= 0; end
      endcase
    end
    else if (cs == `ADRD) begin
      adq <= addr;
      cnt <= 0;
    end  
  end

endmodule