module top (clk, rst_n, run, out);

  input clk, rst_n, run;
  output [3:0] out;

  wire clkd;

  divider divider0(.clk(clk), .rst_n(rst_n), .q(clkd));
  mcpu mcpu0(.clk(clkd), .rst_n(rst_n), .run(run), .out(out));

endmodule