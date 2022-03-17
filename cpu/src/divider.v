module divider (clk, rst_n, q);

  input clk, rst_n;
  output q;
  reg q;

  reg [19:0] cnt;

  always @(posedge clk, negedge rst_n)
    if (!rst_n) begin 
      cnt <= 20'd0;
      q <= 1'b0;
    end 
    else if (cnt == 100000) begin
      q <= ~q;
      cnt <= 20'b0;
    end
    else
      cnt <= cnt + 1;
  
endmodule