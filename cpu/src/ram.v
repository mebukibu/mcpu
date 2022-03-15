module ram (clk, load, wr, addr, d, q);

  input clk, load;
  input [1:0] wr;
  input [15:0] addr;
  input [63:0] d;
  output [63:0] q;
  reg [7:0] mem[0:2**16-1];

  assign q = {{mem[addr+7]}, {mem[addr+6]}, {mem[addr+5]}, {mem[addr+4]},
              {mem[addr+3]}, {mem[addr+2]}, {mem[addr+1]}, {mem[addr]}};

  always @(posedge clk)
    if (load)
      case (wr)
        2'b01 : begin
          mem[addr] <= d[7:0];
        end
        2'b10 : begin
          mem[addr+3] <= d[31:24]; mem[addr+2] <= d[23:16]; mem[addr+1] <= d[15:8]; mem[addr] <= d[7:0];
        end
        2'b11 : begin
          mem[addr+7] <= d[63:56]; mem[addr+6] <= d[55:48]; mem[addr+5] <= d[47:40]; mem[addr+4] <= d[39:32];
          mem[addr+3] <= d[31:24]; mem[addr+2] <= d[23:16]; mem[addr+1] <= d[15:8]; mem[addr] <= d[7:0];
        end
      endcase

  initial begin
    mem[0]  = 8'd65;
    mem[1]  = 8'h06;
    mem[2]  = 8'hF8;
    mem[3]  = 8'hFF;
    mem[4]  = 8'h00;
    mem[5]  = 8'h00;

    mem[6]  = 8'd133;
    mem[7]  = 8'h06;
    mem[8]  = 8'h08;
    mem[9]  = 8'h00;
    mem[10] = 8'h00;
    mem[11] = 8'h00;

    mem[12] = 8'd5;
    mem[13] = 8'h00;
    mem[14] = 8'd42;
    mem[15] = 8'h00;
    mem[16] = 8'h00;
    mem[17] = 8'h00;

    mem[18] = 8'd8;
    mem[19] = 8'h00;

    mem[20] = 8'd129;
    mem[21] = 8'h06;
    mem[22] = 8'h08;
    mem[23] = 8'h00;
    mem[24] = 8'h00;
    mem[25] = 8'h00;

    mem[26] = 8'h00;
    mem[27] = 8'h00;
  end  
  
endmodule