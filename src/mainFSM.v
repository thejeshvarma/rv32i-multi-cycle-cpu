module MainFSM(
    input clk,
    input reset,
    input [6:0] opcode,

    output reg PCUpdate, RegWrite, MemWrite, IRWrite, Branch,
    output reg [1:0] ResultSrc, ALUSrcA, ALUSrcB, ALUOp,
    output reg AdrSrc
);

parameter FETCH      = 4'b0000,
          DECODE     = 4'b0001,
          MEMADR     = 4'b0010,
          MEMREAD    = 4'b0011,
          MEMWB      = 4'b0100,
          MEMWRITE   = 4'b0101,
          EXECUTER   = 4'b0110,
          ALUWB      = 4'b0111,
          EXECUTEI   = 4'b1000,
          BEQ        = 4'b1001,
          JAL        = 4'b1010;

reg [3:0] state, next_state;

//////////////////////////////
// State Register
//////////////////////////////

always @(posedge clk or posedge reset) begin
    if(reset)
        state <= FETCH;
    else
        state <= next_state;
end

//////////////////////////////
// Next State Logic
//////////////////////////////

always @(*) begin
    case(state)

    FETCH:
        next_state = DECODE;

    DECODE:
        case(opcode)
            7'b0000011: next_state = MEMADR;   // lw
            7'b0100011: next_state = MEMADR;   // sw
            7'b0110011: next_state = EXECUTER; // R-type
            7'b0010011: next_state = EXECUTEI; // I-type
            7'b1100011: next_state = BEQ;      // beq
            7'b1101111: next_state = JAL;      // jal
            default:    next_state = FETCH;
        endcase

    MEMADR:
        if(opcode == 7'b0000011)
            next_state = MEMREAD;
        else
            next_state = MEMWRITE;

    MEMREAD:
        next_state = MEMWB;

    MEMWB:
        next_state = FETCH;

    MEMWRITE:
        next_state = FETCH;

    EXECUTER:
        next_state = ALUWB;

    EXECUTEI:
        next_state = ALUWB;

    ALUWB:
        next_state = FETCH;

    BEQ:
        next_state = FETCH;

    JAL:
        next_state = FETCH;

    default:
        next_state = FETCH;

    endcase
end

//////////////////////////////
// Output Control Signals
//////////////////////////////

always @(*) begin

// default values
PCUpdate = 0;
RegWrite = 0;
MemWrite = 0;
IRWrite  = 0;
Branch   = 0;
AdrSrc   = 0;

ResultSrc = 2'b00;
ALUSrcA   = 2'b00;
ALUSrcB   = 2'b00;
ALUOp     = 2'b00;

case(state)

FETCH: begin
    AdrSrc   = 0;
    IRWrite  = 1;
    ALUSrcA  = 2'b00;
    ALUSrcB  = 2'b10; // 4
    ALUOp    = 2'b00; // add
    PCUpdate = 1;
end

DECODE: begin
    ALUSrcA = 2'b01; // OldPC
    ALUSrcB = 2'b01; // Imm
    ALUOp   = 2'b00;
end

MEMADR: begin
    ALUSrcA = 2'b10; // A
    ALUSrcB = 2'b01; // Imm
    ALUOp   = 2'b00;
end

MEMREAD: begin
    AdrSrc = 1;
end

MEMWB: begin
    ResultSrc = 2'b01; // Data
    RegWrite  = 1;

end

MEMWRITE: begin
    AdrSrc   = 1;
    MemWrite = 1;
end

EXECUTER: begin
    ALUSrcA = 2'b10;
    ALUSrcB = 2'b00;
    ALUOp   = 2'b10;
end

EXECUTEI: begin
    ALUSrcA = 2'b10;
    ALUSrcB = 2'b01;
    ALUOp   = 2'b10;
end

ALUWB: begin
    RegWrite  = 1;
    ResultSrc = 2'b00;
end

BEQ: begin
    ALUSrcA = 2'b10;
    ALUSrcB = 2'b00;
    ALUOp   = 2'b01;
    Branch  = 1;
end

JAL: begin
    RegWrite  = 1;
    ResultSrc = 2'b10;
    PCUpdate  = 1;
end

endcase

end

endmodule