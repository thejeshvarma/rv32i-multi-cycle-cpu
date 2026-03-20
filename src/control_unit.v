module control_unit(
    input clk,
    input reset,

    input [6:0] opcode,
    input [2:0] funct3,
    input [6:0] funct7,
    input Zero,

    output PCWrite,
    output MemWrite,
    output IRWrite,
    output RegWrite,
    output AdrSrc,

    output [1:0] ResultSrc,
    output [1:0] ALUSrcA,
    output [1:0] ALUSrcB,
    output [1:0] ImmSrc,

    output [2:0] ALUControl
);

wire PCUpdate;
wire Branch;
wire [1:0] ALUOp;

//////////////////////////////////////////////////
// Main FSM
//////////////////////////////////////////////////

MainFSM fsm(
    .clk(clk),
    .reset(reset),
    .opcode(opcode),

    .PCUpdate(PCUpdate),
    .RegWrite(RegWrite),
    .MemWrite(MemWrite),
    .IRWrite(IRWrite),
    .Branch(Branch),

    .ResultSrc(ResultSrc),
    .ALUSrcA(ALUSrcA),
    .ALUSrcB(ALUSrcB),
    .ALUOp(ALUOp),
    .AdrSrc(AdrSrc)
);

//////////////////////////////////////////////////
// Instruction Decoder
//////////////////////////////////////////////////

instr_decoder idec(
    .opcode(opcode),
    .ImmSrc(ImmSrc)
);

//////////////////////////////////////////////////
// ALU Decoder
//////////////////////////////////////////////////

alu_decoder adec(
    .ALUOp(ALUOp),
    .funct3(funct3),
    .funct7(funct7),
    .op(opcode),
    .ALUControl(ALUControl)
);

//////////////////////////////////////////////////
// PCWrite Logic
//////////////////////////////////////////////////

assign PCWrite = PCUpdate | (Branch & Zero);

endmodule