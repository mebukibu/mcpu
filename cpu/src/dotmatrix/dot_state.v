module dot_state (clk, rst_n, q);

  input clk, rst_n;
  output [2:0] q;
  reg [2:0] q;

  always @(posedge clk, negedge rst_n)
    if (!rst_n) q <= 3'b000;
    else case (q)
      3'b000 : q <= 3'b001;
      3'b001 : q <= 3'b010;
      3'b010 : q <= 3'b011;
      3'b011 : q <= 3'b100;
      3'b100 : q <= 3'b101;
      3'b101 : q <= 3'b110;
      3'b110 : q <= 3'b111;
      3'b111 : q <= 3'b000;
    endcase

endmodule