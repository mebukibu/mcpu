module dot_selector (clk, rst_n, cs, d, q);

  input clk, rst_n;
  input [2:0] cs;
  input [63:0] d;
  output [7:0] q;
  reg [7:0] q;

  always @(posedge clk, negedge rst_n)
    if (!rst_n) q <= 0;
    else case (cs)
      3'b000 : q <= d[7:0];
      3'b001 : q <= d[15:8];
      3'b010 : q <= d[23:16];
      3'b011 : q <= d[31:24];
      3'b100 : q <= d[39:32];
      3'b101 : q <= d[47:40];
      3'b110 : q <= d[55:48];
      3'b111 : q <= d[63:56];
    endcase    
  
endmodule