module dot_decoder (clk, rst_n, d, q);

  input clk, rst_n;
  input [63:0] d;
  output [15:0] q;

  wire [2:0] cs;
  wire [7:0] xy, col, row;

  dot_selector dot_selector0(.clk(clk), .rst_n(rst_n), .cs(cs), .d(d), .q(xy));
  dot_state dot_state0(.clk(clk), .rst_n(rst_n), .q(cs));
  dot_dec_x dot_dec_x0(.d(xy[2:0]), .q(col));
  dot_dec_y dot_dec_y0(.d(xy[6:4]), .q(row));

  assign q = {row, col};

endmodule