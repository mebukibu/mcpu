`include "../data/inst.v"
`include "../data/register_d.v"
module decoder (opc, opl, f, sel, q);

  input [7:0] opc;
  input [63:0] opl;
  output [4:0] f;
  output [7:0] sel;
  output [63:0] q;
  reg [7:0] sel;

  assign f = opc[6:2];
  assign q = opc[0] ? {{32{opl[39]}}, opl[39:8]} : opl;

  always @(opc, opl) begin
    sel[3:0] <= opl[3:0];
    case (opc)
      `PUSH  : sel[7:4] <= `RSP;
      `PUSHN : sel[7:4] <= `RSP;
      `PUSHA : sel[7:4] <= `RSP;
      `POP   : sel[7:4] <= `RSP;
      default: sel[7:4] <= opl[11:8];
    endcase
  end

endmodule