module pc (clk, rst_n, load, inc, d, q);

  input clk, rst_n, load;
  input [1:0] inc;
  input [15:0] d;
  output [15:0] q;
  reg [15:0] q;

  always @(posedge clk, negedge rst_n)
    if (!rst_n) q <= 0;
    else if (load) q <= d;
    else case (inc)
      2'b00 : q <= q;
      2'b01 : q <= q + 1;
      2'b10 : q <= q + 4;
      2'b11 : q <= q + 8;
    endcase      
  
endmodule