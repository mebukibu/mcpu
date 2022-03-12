`include "../data/state_d.v"
module state (clk, rst_n, run, hlt, q);

  input clk, rst_n, run, hlt;
  output [1:0] q;
  reg [1:0] q;

  always @(posedge clk, negedge rst_n)
    if (!rst_n) q <= `IDLE;
    else case (q)
      `IDLE  : if (run) q <= `OPCFT;
      `OPCFT : q <= `OPLFT;
      `OPLFT : q <= `EXE;
      `EXE   : if (hlt) q <= `IDLE; else q <= `OPCFT;
      default: q <= 2'bXX;
    endcase

endmodule