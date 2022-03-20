`include "../../data/register_d.v"
module registers (clk, rst_n, load, sel, d, a, b);

  input clk, rst_n, load;
  input [7:0] sel;
  input [63:0] d;
  output [63:0] a, b;

  wire [63:0] raxout, rdiout, rsiout, rdxout, rcxout,
              rbpout, rspout, rbxout, r8out, r9out;
  reg raxld, rdild, rsild, rdxld, rcxld,
      rbpld, rspld, rbxld, r8ld, r9ld;
  reg rax2a, rdi2a, rsi2a, rdx2a, rcx2a,
      rbp2a, rsp2a, rbx2a, r82a, r92a;
  reg rax2b, rdi2b, rsi2b, rdx2b, rcx2b,
      rbp2b, rsp2b, rbx2b, r82b, r92b;

  register rax(.clk(clk), .rst_n(rst_n), .load(raxld), .d(d), .q(raxout));
  register rdi(.clk(clk), .rst_n(rst_n), .load(rdild), .d(d), .q(rdiout));
  register rsi(.clk(clk), .rst_n(rst_n), .load(rsild), .d(d), .q(rsiout));
  register rdx(.clk(clk), .rst_n(rst_n), .load(rdxld), .d(d), .q(rdxout));
  register rcx(.clk(clk), .rst_n(rst_n), .load(rcxld), .d(d), .q(rcxout));
  register rbp(.clk(clk), .rst_n(rst_n), .load(rbpld), .d(d), .q(rbpout));
  register rsp(.clk(clk), .rst_n(rst_n), .load(rspld), .d(d), .q(rspout));
  register rbx(.clk(clk), .rst_n(rst_n), .load(rbxld), .d(d), .q(rbxout));
  register r8(.clk(clk), .rst_n(rst_n), .load(r8ld), .d(d), .q(r8out));
  register r9(.clk(clk), .rst_n(rst_n), .load(r9ld), .d(d), .q(r9out));

  assign a = rax2a ? raxout : {64{1'bZ}};
  assign a = rdi2a ? rdiout : {64{1'bZ}};
  assign a = rsi2a ? rsiout : {64{1'bZ}};
  assign a = rdx2a ? rdxout : {64{1'bZ}};
  assign a = rcx2a ? rcxout : {64{1'bZ}};
  assign a = rbp2a ? rbpout : {64{1'bZ}};
  assign a = rsp2a ? rspout : {64{1'bZ}};
  assign a = rbx2a ? rbxout : {64{1'bZ}};
  assign a = r82a ? r8out : {64{1'bZ}};
  assign a = r92a ? r9out : {64{1'bZ}};

  assign b = rax2b ? raxout : {64{1'bZ}};
  assign b = rdi2b ? rdiout : {64{1'bZ}};
  assign b = rsi2b ? rsiout : {64{1'bZ}};
  assign b = rdx2b ? rdxout : {64{1'bZ}};
  assign b = rcx2b ? rcxout : {64{1'bZ}};
  assign b = rbp2b ? rbpout : {64{1'bZ}};
  assign b = rsp2b ? rspout : {64{1'bZ}};
  assign b = rbx2b ? rbxout : {64{1'bZ}};
  assign b = r82b ? r8out : {64{1'bZ}};
  assign b = r92b ? r9out : {64{1'bZ}};

  always @(sel[7:4]) begin
    rax2a = 0; rdi2a = 0; rsi2a = 0; rdx2a = 0; rcx2a = 0;
    rbp2a = 0; rsp2a = 0; rbx2a = 0; r82a = 0; r92a = 0;
    case (sel[7:4])
      `RAX : rax2a = 1;
      `RDI : rdi2a = 1;
      `RSI : rsi2a = 1;
      `RDX : rdx2a = 1;
      `RCX : rcx2a = 1;
      `RBP : rbp2a = 1;
      `RSP : rsp2a = 1;
      `RBX : rbx2a = 1;
      `R8  : r82a = 1;
      `R9  : r92a = 1;
    endcase
  end

  always @(sel[3:0]) begin
    rax2b = 0; rdi2b = 0; rsi2b = 0; rdx2b = 0; rcx2b = 0;
    rbp2b = 0; rsp2b = 0; rbx2b = 0; r82b = 0; r92b = 0;
    case (sel[3:0])
      `RAX : rax2b = 1;
      `RDI : rdi2b = 1;
      `RSI : rsi2b = 1;
      `RDX : rdx2b = 1;
      `RCX : rcx2b = 1;
      `RBP : rbp2b = 1;
      `RSP : rsp2b = 1;
      `RBX : rbx2b = 1;
      `R8  : r82b = 1;
      `R9  : r92b = 1;
    endcase
  end

  always @(sel[3:0], load) begin
    raxld = 0; rdild = 0; rsild = 0; rdxld = 0; rcxld = 0;
    rbpld = 0; rspld = 0; rbxld = 0; r8ld = 0; r9ld = 0;
    if (load)
      case (sel[3:0])
        `RAX : raxld = 1;
        `RDI : rdild = 1;
        `RSI : rsild = 1;
        `RDX : rdxld = 1;
        `RCX : rcxld = 1;
        `RBP : rbpld = 1;
        `RSP : rspld = 1;
        `RBX : rbxld = 1;
        `R8  : r8ld = 1;
        `R9  : r9ld = 1;
      endcase
  end


endmodule