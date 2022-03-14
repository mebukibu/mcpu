module flag (clk, rst_n, d, q);

  input clk, rst_n;
  input [63:0] d;
  output [1:0] q;
  reg [1:0] q;

  always @(posedge clk, negedge rst_n)
    if (!rst_n) q <= 0;
    else begin
      q[0] <= (d == 0);
      q[1] <= d[63];
    end
  
endmodule