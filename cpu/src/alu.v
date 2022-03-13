`include "../data/alu_d.v"
module alu (a, b, f, c);

  input signed [63:0] a, b;
  input [4:0] f;
  output signed [63:0] c;
  reg signed [63:0] c;

  always @(a, b, f)
    case(f)
      `ADD : c = b + a;
      `SUB : c = b - a;
      `MUL : c = b * a;
      `AND : c = b & a;
      default : c = {64{1'bX}};
    endcase

endmodule