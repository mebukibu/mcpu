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
    mem[0] = 0;
    mem[1] = 1;
    mem[2] = 2;
    mem[3] = 3;
    mem[4] = 4;
    mem[5] = 5;
    mem[6] = 6;
    mem[7] = 7;
  end  
  
endmodule