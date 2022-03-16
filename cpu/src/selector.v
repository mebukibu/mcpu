`include "../data/inst.v"
module selector (opc, flg, c, d, q);

  input [7:0] opc;
  input [1:0] flg;
  input [63:0] c;
  input [63:0] d;
  output [63:0] q;

  reg op, set, ma4, ma1, mr1, df;
  reg val;

  assign q = op  ? c : {64{1'bZ}};
  assign q = set ? {{63{1'b0}}, val} : {64{1'bZ}};
  assign q = ma4 ? {{32{d[31]}}, d[31:0]} : {64{1'bZ}};
  assign q = ma1 ? {{56{d[7]}}, d[7:0]} : {64{1'bZ}};
  assign q = mr1 ? {{56{1'b0}}, d[7:0]} : {64{1'bZ}};
  assign q = df  ? d : {64{1'bZ}};


  always @(opc, flg) begin
    set = 0; ma4 = 0; ma1 = 0; mr1 = 0;
    df = 0; val = 0;

    op = opc[7];

    if (!op)
      case (opc)
        `SETE  : begin set = 1; val = flg[0]; end
        `SETNE : begin set = 1; val = ~flg[0]; end
        `SETL  : begin set = 1; val = flg[1]; end
        `SETLE : begin set = 1; val = (flg[1] | flg[0]); end
        `MOVRA4: ma4 = 1;
        `MOVRA1: ma1 = 1;
        `MOVRR1: mr1 = 1;
        default: df = 1;
      endcase
  end

endmodule