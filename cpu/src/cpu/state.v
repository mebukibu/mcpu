`include "../../data/state_d.v"
module state (clk, rst_n, run, hlt, kp, q);

  input clk, rst_n, run, hlt, kp;
  output [3:0] q;
  reg [3:0] q;

  always @(posedge clk, negedge rst_n)
    if (!rst_n) q <= `IDLE;
    else case (q)
      `IDLE  : if (run) q <= `OPCFT;
      `OPCFT : q <= `OPLRD;
      `OPLRD : if (!kp) q <= `OPLFT;
      `OPLFT : q <= `ADRD;
      `ADRD  : if (!kp) q <= `EXE; else q <= `EXERD;
      `EXERD : if (!kp) q <= `EXE;
      `EXE   : if (hlt) q <= `IDLE; else q <= `LDRD;
      `LDRD  : if (!kp) q <= `OPCFT; else q <= `LOAD;
      `LOAD  : if (!kp) q <= `OPCFT;
      default: q <= 3'bXXX;
    endcase

endmodule