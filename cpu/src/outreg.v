module outreg (rst_n, addr, d, q);

  input rst_n;
  input [3:0] d;
  input [15:0] addr;
  output [63:0] q;
  reg [63:0] q;

  always @(addr, d, negedge rst_n)
    if (!rst_n) q <= 0;
    else
      case (addr)
        16'd69 : q[63:60] <= d;
        16'd65 : q[59:56] <= d;
        16'd61 : q[55:52] <= d;
        16'd57 : q[51:48] <= d;
        16'd53 : q[47:44] <= d;
        16'd49 : q[43:40] <= d;
        16'd45 : q[39:36] <= d;
        16'd41 : q[35:32] <= d;
        16'd37 : q[31:28] <= d;
        16'd33 : q[27:24] <= d;
        16'd29 : q[23:20] <= d;
        16'd25 : q[19:16] <= d;
        16'd21 : q[15:12]  <= d;
        16'd17 : q[11:8]  <= d;
        16'd13 : q[7:4]   <= d;
        16'd9  : q[3:0]   <= d;
        default: q <= q;
      endcase

endmodule