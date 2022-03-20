module top (clk, rst_n, run, out);

  input clk, rst_n, run;
  output [15:0] out;

  wire [63:0] mcpuout;

  mcpu mcpu0(.clk(clk), .rst_n(rst_n), .run(run), .out(mcpuout));
  dot_decoder dot_decoder0(.clk(clk), .rst_n(rst_n), .d(mcpuout), .q(out));

endmodule