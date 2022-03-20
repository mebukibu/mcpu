`include "../../data/inst.v"
`include "../../data/state_d.v"
`include "../../data/alu_d.v"
module mcpu (clk, rst_n, run, out);

  input clk, rst_n, run;
  output [63:0] out;

  wire kpl, kpr;
  wire [1:0] flg;
  wire [3:0] cs;
  wire [4:0] f;
  wire [7:0] opc, sel, rmlout, ramout;
  wire [15:0] abus, pcout, rmladq, rmradq;
  wire [63:0] a, b, opl, selout, aluout, decout, rmrout;
  wire [63:0] dbus;

  reg kp;
  reg a2abus, b2abus, pc2abus, rml2abus, rmr2abus,
      a2dbus, b2dbus, pc2dbus, ram2dbus, dec2dbus, rmr2dbus,
      hlt, loadreg, loadflag, loadram, dbus2pc, dbus2opc, dbus2opl;
  reg [1:0] pcinc, wr;

  flag flag0(.clk(clk), .rst_n(rst_n), .load(loadflag), .d(aluout), .q(flg));
  state state0(.clk(clk), .rst_n(rst_n), .run(run), .hlt(hlt), .kp(kp), .q(cs));
  pc pc0(.clk(clk), .rst_n(rst_n), .load(dbus2pc), .inc(pcinc), .d(dbus[15:0]), .q(pcout));
  ramloader ramloader0(.clk(clk), .wr(wr), .cs(cs), .addr(abus), .d(dbus), .kp(kpl), .adq(rmladq), .q(rmlout));
  ram ram0(.clk(clk), .load(loadram), .addr(abus), .d(rmlout), .q(ramout));
  ramreader ramreader0(.clk(clk), .cs(cs), .opc(opc), .addr(abus), .d(ramout), .kp(kpr), .adq(rmradq), .q(rmrout));
  selector selector0(.opc(opc), .flg(flg), .c(aluout), .d(dbus), .q(selout));
  registers registers0(.clk(clk), .rst_n(rst_n), .load(loadreg), .sel(sel), .d(selout), .a(a), .b(b));
  alu alu0(.a(dbus), .b(b), .f(f), .c(aluout));
  register #(8) opcode(.clk(clk), .rst_n(rst_n), .load(dbus2opc), .d(dbus[7:0]), .q(opc));
  register opland(.clk(clk), .rst_n(rst_n), .load(dbus2opl), .d(dbus), .q(opl));
  decoder decoder0(.opc(opc), .opl(opl), .f(f), .sel(sel), .q(decout));
  outreg outreg0(.clk(clk), .rst_n(rst_n), .load(loadram), .addr(abus), .d(rmlout[3:0]), .q(out));

  assign abus = a2abus ? a[15:0] : {16{1'bZ}};
  assign abus = b2abus ? b[15:0] : {16{1'bZ}};
  assign abus = pc2abus ? pcout : {16{1'bZ}};
  assign abus = rml2abus ? rmladq : {16{1'bZ}};
  assign abus = rmr2abus ? rmradq : {16{1'bZ}};

  assign dbus = a2dbus ? a : {64{1'bZ}};
  assign dbus = b2dbus ? b : {64{1'bZ}};
  assign dbus = pc2dbus ? {{48{1'b0}}, pcout} : {64{1'bZ}};
  assign dbus = ram2dbus ? {{56{1'bX}}, ramout} : {64{1'bZ}};
  assign dbus = dec2dbus ? decout : {64{1'bZ}};
  assign dbus = rmr2dbus ? rmrout : {64{1'bZ}};

  always @(kpl, kpr, cs) begin
    if (cs == `EXE | cs == `LDRD | cs == `LOAD)
      kp <= kpl;
    else if (cs != `IDLE)
      kp <= kpr;
    else
      kp <= 0;
  end

  always @(cs, opc, flg) begin
    a2abus=0; b2abus=0; pc2abus=0; rml2abus=0; rmr2abus=0;
    a2dbus=0; b2dbus=0; pc2dbus=0; ram2dbus=0; dec2dbus=0; rmr2dbus=0;
    hlt=0; loadreg=0; loadflag=0; loadram=0; dbus2pc=0; dbus2opc=0; dbus2opl=0;
    pcinc=2'b00; wr=2'b00;

    if (cs == `OPCFT) begin
      pc2abus=1; ram2dbus=1; dbus2opc=1; pcinc=2'b01;
    end
    else if (cs == `OPLRD) begin
      rmr2abus=1;
    end
    else if (cs == `OPLFT) begin
      rmr2abus=1; rmr2dbus=1; dbus2opl=1;
      if (opc[0] == 1)
        pcinc = 2'b10;
      else if (opc[1] == 1)
        pcinc = 2'b11;
      else
        pcinc = 2'b01;
    end
    else if (cs == `ADRD) begin
      a2abus=1;
    end
    else if (cs == `EXERD) begin
      rmr2abus=1;
    end
    else if (cs == `EXE) begin
      loadflag = 1;

      if (opc[7] == 1) begin
        pcinc=2'b01;
        if (opc[6:2] != `CMP) loadreg=1;
        if (opc[0] == 1) dec2dbus=1;           
        else a2dbus=1;
      end

      else begin
        case (opc)
          `HLT    : hlt=1;
          `PUSH   : begin a2abus=1; b2dbus=1; wr=2'b11; end
          `PUSHN  : begin a2abus=1; dec2dbus=1; wr=2'b11; pcinc=2'b01; end
          `PUSHA  : begin a2abus=1; dec2dbus=1; wr=2'b11; end
          `POP    : begin a2abus=1; rmr2dbus=1; loadreg=1; end
          `MOVPC  : begin pc2dbus=1; loadreg=1; end
          `SETE   : loadreg=1;
          `SETNE  : loadreg=1;
          `SETL   : loadreg=1;
          `SETLE  : loadreg=1;
          `JMPR   : begin b2dbus=1; dbus2pc=1; end
          `JMP    : begin dec2dbus=1; dbus2pc=1; end
          `JE     : if (flg[0] == 1) begin dec2dbus=1; dbus2pc=1; end
          `JNZ    : if (flg[0] == 0) begin dec2dbus=1; dbus2pc=1; end
          `MOV    : begin a2dbus=1; loadreg=1; pcinc=2'b01; end
          `MOVRN  : begin dec2dbus=1; loadreg=1; pcinc=2'b01; end
          `MOVRA  : begin a2abus=1; rmr2dbus=1; loadreg=1; pcinc=2'b01; end
          `MOVRA4 : begin a2abus=1; rmr2dbus=1; loadreg=1; pcinc=2'b01; end
          `MOVRA1 : begin a2abus=1; ram2dbus=1; loadreg=1; pcinc=2'b01; end
          `MOVRR1 : begin a2dbus=1; loadreg=1; pcinc=2'b01; end
          `MOVAR  : begin b2abus=1; a2dbus=1; wr=2'b11; pcinc=2'b01; end
          `MOVAR4 : begin b2abus=1; a2dbus=1; wr=2'b10; pcinc=2'b01; end
          `MOVAR1 : begin b2abus=1; a2dbus=1; loadram=1; wr=2'b01; pcinc=2'b01; end
        endcase
      end    
    end
    else if (cs == `LOAD) begin
      rml2abus=1; loadram=1;
    end
  end

endmodule