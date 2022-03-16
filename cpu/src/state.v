`include "../data/state_d.v"
module state (clk, rst_n, run, hlt, kp, q);

  input clk, rst_n, run, hlt, kp;
  output [2:0] q;
  reg [2:0] q;

  always @(posedge clk, negedge rst_n)
    if (!rst_n) q <= `IDLE;
    else case (q)
      `IDLE  : if (run) q <= `OPCFT;
      `OPCFT : q <= `OPLFT;
      `OPLFT : q <= `EXE;
      `EXE   : if (hlt) q <= `IDLE; else if (!kp) q <= `OPCFT; else q <= `LOAD;
      `LOAD  : if (!kp) q <= `OPCFT; else q <= `LOAD;
      default: q <= 3'bXXX;
    endcase

endmodule