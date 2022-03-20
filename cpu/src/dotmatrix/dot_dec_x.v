module dot_dec_x (d, q);

  input [2:0] d;
  output [7:0] q;
  reg [7:0] q;

  always @(d)
    case (d)
      3'b000 : q <= 8'b11111110;
      3'b001 : q <= 8'b11111101;
      3'b010 : q <= 8'b11111011;
      3'b011 : q <= 8'b11110111;
      3'b100 : q <= 8'b11101111;
      3'b101 : q <= 8'b11011111;
      3'b110 : q <= 8'b10111111;
      3'b111 : q <= 8'b01111111;
    endcase

endmodule