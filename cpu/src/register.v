module register (clk, rst_n, load, d, q);
  parameter N = 64;

  input clk, rst_n, load;
  input [N-1:0] d;
  output [N-1:0] q;
  reg [N-1:0] q;

  always @(posedge clk, negedge rst_n)
    if (!rst_n) q <= 0;
    else if (load) q <= d;
  
endmodule