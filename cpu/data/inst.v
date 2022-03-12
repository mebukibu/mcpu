`define HLT     8'b00000000

`define PUSH    8'b00000100
`define PUSHN   8'b00000101
`define PUSHA   8'b00000110
`define POP     8'b00001000
`define MOVPC   8'b00001100

`define SETE    8'b00010000
`define SETNE   8'b00010100
`define SETL    8'b00011000
`define SETLE   8'b00011100

`define JMPR    8'b00100000
`define JMP     8'b00100010
`define JE      8'b00100110
`define JNZ     8'b00101010

`define MOV     8'b01000000
`define MOVRN   8'b01000001
`define MOVRA   8'b01000100
`define MOVRA4  8'b01001000
`define MOVRA1  8'b01001100
`define MOVRR1  8'b01010000
`define MOVAR   8'b01010100
`define MOVAR4  8'b01011000
`define MOVAR1  8'b01011100

`define ADD     8'b10000000
`define ADDN    8'b10000001
`define SUB     8'b10000100
`define SUBN    8'b10000101
`define MUL     8'b10001000
`define MULN    8'b10001001
`define AND     8'b10001100
`define ANDN    8'b10001101
`define CMP     8'b10010000
`define CMPN    8'b10010001