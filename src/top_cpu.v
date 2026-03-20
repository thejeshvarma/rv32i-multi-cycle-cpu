module cpu(
    input clk,
    input reset
);

//////////////////////////////////////////////////
// Internal Wires (Datapath ↔ Control)
//////////////////////////////////////////////////

wire PCWrite;
wire MemWrite;
wire IRWrite;
wire RegWrite;
wire AdrSrc;

wire [1:0] ResultSrc;
wire [1:0] ALUSrcA;
wire [1:0] ALUSrcB;
wire [1:0] ImmSrc;

wire [2:0] ALUControl;

wire Zero;

wire [6:0] opcode;
wire [2:0] funct3;
wire [6:0] funct7;

//////////////////////////////////////////////////
// Datapath
//////////////////////////////////////////////////

datapath dp(
    .clk(clk),
    .reset(reset),

    .RegWrite(RegWrite),
    .MemWrite(MemWrite),
    .AdrSrc(AdrSrc),
    .IRWrite(IRWrite),
    .PCWrite(PCWrite),

    .ALUSrcA(ALUSrcA),
    .ALUSrcB(ALUSrcB),

    .ResultSrc(ResultSrc),
    .ImmSrc(ImmSrc),

    .ALUControl(ALUControl),

    .Zero(Zero),

    .opcode(opcode),
    .funct3(funct3),
    .funct7(funct7)
);

//////////////////////////////////////////////////
// Control Unit
//////////////////////////////////////////////////

control_unit cu(
    .clk(clk),
    .reset(reset),

    .opcode(opcode),
    .funct3(funct3),
    .funct7(funct7),
    .Zero(Zero),

    .PCWrite(PCWrite),
    .MemWrite(MemWrite),
    .IRWrite(IRWrite),
    .RegWrite(RegWrite),
    .AdrSrc(AdrSrc),

    .ResultSrc(ResultSrc),
    .ALUSrcA(ALUSrcA),
    .ALUSrcB(ALUSrcB),
    .ImmSrc(ImmSrc),

    .ALUControl(ALUControl)
);

endmodule