module ram (clk, load, addr, d, q);

  input clk, load;
  input [15:0] addr;
  input [7:0] d;
  output [7:0] q;
  reg [7:0] mem[0:2**16-1];

  assign q = mem[addr];

  always @(posedge clk)
    if (load)
      mem[addr] <= d;

  initial begin
    mem[0]   = 8'h22; //JMP d73
    mem[1]   = 8'h49;
    mem[2]   = 8'h00;
    mem[3]   = 8'h00;
    mem[4]   = 8'h00;
    mem[5]   = 8'h00;
    mem[6]   = 8'h00;
    mem[7]   = 8'h00;
    mem[8]   = 8'h00;

    mem[9]   = 8'h00; // int pos[8][2]
    mem[10]  = 8'h00;
    mem[11]  = 8'h00;
    mem[12]  = 8'h00;
    mem[13]  = 8'h00;
    mem[14]  = 8'h00;
    mem[15]  = 8'h00;
    mem[16]  = 8'h00;
    mem[17]  = 8'h00;
    mem[18]  = 8'h00;
    mem[19]  = 8'h00;
    mem[20]  = 8'h00;
    mem[21]  = 8'h00;
    mem[22]  = 8'h00;
    mem[23]  = 8'h00;
    mem[24]  = 8'h00;
    mem[25]  = 8'h00;
    mem[26]  = 8'h00;
    mem[27]  = 8'h00;
    mem[28]  = 8'h00;
    mem[29]  = 8'h00;
    mem[30]  = 8'h00;
    mem[31]  = 8'h00;
    mem[32]  = 8'h00;
    mem[33]  = 8'h00;
    mem[34]  = 8'h00;
    mem[35]  = 8'h00;
    mem[36]  = 8'h00;
    mem[37]  = 8'h00;
    mem[38]  = 8'h00;
    mem[39]  = 8'h00;
    mem[40]  = 8'h00;
    mem[41]  = 8'h00;
    mem[42]  = 8'h00;
    mem[43]  = 8'h00;
    mem[44]  = 8'h00;
    mem[45]  = 8'h00;
    mem[46]  = 8'h00;
    mem[47]  = 8'h00;
    mem[48]  = 8'h00;
    mem[49]  = 8'h00;
    mem[50]  = 8'h00;
    mem[51]  = 8'h00;
    mem[52]  = 8'h00;
    mem[53]  = 8'h00;
    mem[54]  = 8'h00;
    mem[55]  = 8'h00;
    mem[56]  = 8'h00;
    mem[57]  = 8'h00;
    mem[58]  = 8'h00;
    mem[59]  = 8'h00;
    mem[60]  = 8'h00;
    mem[61]  = 8'h00;
    mem[62]  = 8'h00;
    mem[63]  = 8'h00;
    mem[64]  = 8'h00;
    mem[65]  = 8'h00;
    mem[66]  = 8'h00;
    mem[67]  = 8'h00;
    mem[68]  = 8'h00;
    mem[69]  = 8'h00;
    mem[70]  = 8'h00;
    mem[71]  = 8'h00;
    mem[72]  = 8'h00;
    
    mem[73]  = 8'h41; // MOVRN RSP 0000FFF8
    mem[74]  = 8'h06;
    mem[75]  = 8'hF8;
    mem[76]  = 8'hFF;
    mem[77]  = 8'h00;
    mem[78]  = 8'h00;

    mem[79]  = 8'h85; // SUBN RSP 8
    mem[80]  = 8'h06;
    mem[81]  = 8'h08;
    mem[82]  = 8'h00;
    mem[83]  = 8'h00;
    mem[84]  = 8'h00;

    mem[85]  = 8'h06; // PUSHA 0009
    mem[86]  = 8'h09;
    mem[87]  = 8'h00;
    mem[88]  = 8'h00;
    mem[89]  = 8'h00;
    mem[90]  = 8'h00;
    mem[91]  = 8'h00;
    mem[92]  = 8'h00;
    mem[93]  = 8'h00;

    mem[94]  = 8'h08; // POP RAX
    mem[95]  = 8'h00;

    mem[96]  = 8'h81; // ADDN RSP 8
    mem[97]  = 8'h06;
    mem[98]  = 8'h08;
    mem[99]  = 8'h00;
    mem[100] = 8'h00;
    mem[101] = 8'h00;

    mem[102] = 8'h41; // MOVRN RDI 1
    mem[103] = 8'h01;
    mem[104] = 8'h01;
    mem[105] = 8'h00;
    mem[106] = 8'h00;
    mem[107] = 8'h00;
    
    mem[108] = 8'h41; // MOVRN RSI 4
    mem[109] = 8'h02;
    mem[110] = 8'h04;
    mem[111] = 8'h00;
    mem[112] = 8'h00;
    mem[113] = 8'h00;


    mem[114] = 8'h58; // MOVAR4 RAX RDI
    mem[115] = 8'h00;
    mem[116] = 8'h01;

    mem[117] = 8'h80; // ADD RAX RSI
    mem[118] = 8'h00;
    mem[119] = 8'h02;
    
    mem[120] = 8'h54; // MOVAR RAX RDI
    mem[121] = 8'h00;
    mem[122] = 8'h01;

    mem[123] = 8'h80; // ADD RAX RSI
    mem[124] = 8'h00;
    mem[125] = 8'h02;

    mem[126] = 8'h5C; // MOVAR1 RAX RDI
    mem[127] = 8'h00;
    mem[128] = 8'h01;

    mem[129] = 8'h80; // ADD RAX RSI
    mem[130] = 8'h00;
    mem[131] = 8'h02;

    mem[132] = 8'h5C; // MOVAR4 RAX RDI
    mem[133] = 8'h00;
    mem[134] = 8'h01;


    mem[135] = 8'h44; // MOVRA RDX RAX
    mem[136] = 8'h03;
    mem[137] = 8'h00;

    mem[138] = 8'h48; // MOVRA4 RCX RAX
    mem[139] = 8'h04;
    mem[140] = 8'h00;

    mem[141] = 8'h4C; // MOVRA1 RBP RAX
    mem[142] = 8'h05;
    mem[143] = 8'h00;


    mem[144] = 8'h85; // SUBN RSP 8
    mem[145] = 8'h06;
    mem[146] = 8'h08;
    mem[147] = 8'h00;
    mem[148] = 8'h00;
    mem[149] = 8'h00;

    mem[150] = 8'h04; // PUSH RAX
    mem[151] = 8'h00;

    mem[152] = 8'h08; // POP RBX
    mem[153] = 8'h07;

    mem[154] = 8'h81; // ADDN RSP 8
    mem[155] = 8'h06;
    mem[156] = 8'h08;
    mem[157] = 8'h00;
    mem[158] = 8'h00;
    mem[159] = 8'h00;


    mem[160] = 8'h85; // SUBN RSP 8
    mem[161] = 8'h06;
    mem[162] = 8'h08;
    mem[163] = 8'h00;
    mem[164] = 8'h00;
    mem[165] = 8'h00;

    mem[166] = 8'h05; // PUSHN d34
    mem[167] = 8'h00;
    mem[168] = 8'h22;
    mem[169] = 8'h00;
    mem[170] = 8'h00;
    mem[171] = 8'h00;

    mem[172] = 8'h08; // POP R8
    mem[173] = 8'h08;

    mem[174] = 8'h81; // ADDN RSP 8
    mem[175] = 8'h06;
    mem[176] = 8'h08;
    mem[177] = 8'h00;
    mem[178] = 8'h00;
    mem[179] = 8'h00;


    mem[180] = 8'h0C; // MOVPC R9
    mem[181] = 8'h09;


    mem[182] = 8'h90; // CMP RDX RBX
    mem[183] = 8'h03;
    mem[184] = 8'h07;

    mem[185] = 8'h1C; // SETLE AL
    mem[186] = 8'h00;

    mem[187] = 8'h91; // CMPN RDX 0
    mem[188] = 8'h03;
    mem[189] = 8'h00;
    mem[190] = 8'h00;
    mem[191] = 8'h00;
    mem[192] = 8'h00;

    mem[193] = 8'h10; // SETE R8
    mem[194] = 8'h08;


    mem[195] = 8'h41; // MOVRN RDX FFFFFFFF
    mem[196] = 8'h03;
    mem[197] = 8'hFF;
    mem[198] = 8'hFF;
    mem[199] = 8'hFF;
    mem[200] = 8'hFF;

    mem[201] = 8'h40; // MOV RBX RDX
    mem[202] = 8'h07;
    mem[203] = 8'h03;

    mem[204] = 8'h50; // MOVRR1 RBX RBX
    mem[205] = 8'h07;
    mem[206] = 8'h07;

    
    mem[207] = 8'h84; // SUB RBP RCX
    mem[208] = 8'h05;
    mem[209] = 8'h04;

    mem[210] = 8'h88; // MUL RBX RSI
    mem[211] = 8'h07;
    mem[212] = 8'h02;

    mem[213] = 8'h2A; // JNZ d224
    mem[214] = 8'hE0;
    mem[215] = 8'h00;
    mem[216] = 8'h00;
    mem[217] = 8'h00;
    mem[218] = 8'h00;
    mem[219] = 8'h00;
    mem[220] = 8'h00;
    mem[221] = 8'h00;

    mem[222] = 8'h00; // HLT DMY
    mem[223] = 8'h00;

    mem[224] = 8'h89; // MULN RBX 0
    mem[225] = 8'h07;
    mem[226] = 8'h00;
    mem[227] = 8'h00;
    mem[228] = 8'h00;
    mem[229] = 8'h00;

    mem[230] = 8'h26; // JE d241
    mem[231] = 8'hF1;
    mem[232] = 8'h00;
    mem[233] = 8'h00;
    mem[234] = 8'h00;
    mem[235] = 8'h00;
    mem[236] = 8'h00;
    mem[237] = 8'h00;
    mem[238] = 8'h00;

    mem[239] = 8'h00; // HLT DMY
    mem[240] = 8'h00;

    mem[241] = 8'h8D; // ANDN RDX 0000FFFF
    mem[242] = 8'h03;
    mem[243] = 8'hFF;
    mem[244] = 8'hFF;
    mem[245] = 8'h00;
    mem[246] = 8'h00;

    mem[247] = 8'h8C; // AND RDX RDI
    mem[248] = 8'h03;
    mem[249] = 8'h01;

    // function demo
    mem[250] = 8'h22; // JMP d269
    mem[251] = 8'h0D;
    mem[252] = 8'h01;
    mem[253] = 8'h00;
    mem[254] = 8'h00;
    mem[255] = 8'h00;
    mem[256] = 8'h00;
    mem[257] = 8'h00;
    mem[258] = 8'h00;

                      //ret
    mem[259] = 8'h08; // POP RBX
    mem[260] = 8'h07;

    mem[261] = 8'h81; // ADDN RSP 8
    mem[262] = 8'h06;
    mem[263] = 8'h08;
    mem[264] = 8'h00;
    mem[265] = 8'h00;
    mem[266] = 8'h00;    

    mem[267] = 8'h20; // JMPR RBX
    mem[268] = 8'h07;

                      //call
    mem[269] = 8'h0C; // MOVPC RBX 
    mem[270] = 8'h07;

    mem[271] = 8'h81; // ADDN RBX d23
    mem[272] = 8'h07;
    mem[273] = 8'h17;
    mem[274] = 8'h00;
    mem[275] = 8'h00;
    mem[276] = 8'h00; 

    mem[277] = 8'h85; // SUBN RSP 8
    mem[278] = 8'h06;
    mem[279] = 8'h08;
    mem[280] = 8'h00;
    mem[281] = 8'h00;
    mem[282] = 8'h00;

    mem[283] = 8'h04; // PUSH RBX
    mem[284] = 8'h07;

    mem[285] = 8'h22; // JMP d259
    mem[286] = 8'h03;
    mem[287] = 8'h01;
    mem[288] = 8'h00;
    mem[289] = 8'h00;
    mem[290] = 8'h00;
    mem[291] = 8'h00;
    mem[292] = 8'h00;
    mem[293] = 8'h00;

    mem[294] = 8'h00; // HLT DMY
    mem[295] = 8'h00;

  end  
  
endmodule