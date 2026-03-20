module datapath(
    input clk , reset,
    input RegWrite, MemWrite, AdrSrc, IRWrite, PCWrite,
    input [1:0] ALUSrcA, ALUSrcB,
    input [1:0] ResultSrc,ImmSrc ,
    input [2:0] ALUControl,
    output Zero,
    output [6:0] opcode,
    output [2:0] funct3,
    output [6:0] funct7
);

wire [31:0] PC;
wire [31:0] OldPC;
wire [31:0] Instr;
wire [31:0] RD1;
wire [31:0] RD2;
wire [31:0] A;
wire [31:0] B;
wire [31:0] ImmExt;
wire [31:0] SrcA;
wire [31:0] SrcB;
wire [31:0] ALUResult;
wire [31:0] ALUOut;
wire [31:0] ReadData;
wire [31:0] Data;
wire [31:0] WriteData;
wire [31:0] Result;
wire [31:0] Adr;



pc pcmod(
.clk(clk),
.reset(reset),
.PCWrite(PCWrite),
.PCNext(ALUResult),
.PC(PC)
);

mux2 AdrSrcMux(
    .A(PC),
    .B(ALUOut),
    .sel(AdrSrc),
    .Y(Adr)
);

main_memory mem(
    .A(Adr),
    .WriteData(RD2),
    .clk(clk) ,
    .WE(MemWrite),
    .ReadData(ReadData)
);

dataReg dReg(
    .clk(clk) , 
    .ReadData(ReadData),
    .Data(Data)
);

instREG inreg(
.clk(clk),
.IRWrite(IRWrite) ,
.PC(PC),
.Instruction_in(ReadData) ,
.Instruction(Instr),
.OldPC(OldPC)
);

regfile regg(
.clk(clk),
.RegWrite(RegWrite),
.A1(Instr[19:15]),
.A2(Instr[24:20]), 
.A3(Instr[11:7]),
.WriteData(Result),
.RD1(RD1),
.RD2(RD2)
);

SrcREG srcRegg(
.clk(clk) ,
.Ain(RD1) ,
.Bin(RD2),
.A(A),
.B(B)
);

extender immextn(
.instr(Instr),
.ImmSrc(ImmSrc),
.ImmExt(ImmExt)
);

mux3 srcAmux(
    .A(PC),
    .B(OldPC),
    .C(A),
    .sel(ALUSrcA),
    .Y(SrcA)
);

mux3 srcBmux(
    .A(B),
    .B(ImmExt),
    .C(32'd4),
    .sel(ALUSrcB),
    .Y(SrcB)
);

ALU mainALU(
.SrcA(SrcA),
.SrcB(SrcB),
.ALUControl(ALUControl),
.ALUResult(ALUResult) ,
.Zero(Zero)    
);

ALUOutReg alreg(
    .clk(clk) ,
    .ALUResult(ALUResult),
    .ALUOut(ALUOut)
);


mux3 resultMux(
    .A(ALUOut),
    .B(Data),
    .C(ALUResult),
    .sel(ResultSrc),
    .Y(Result)
);

assign opcode = Instr[6:0];
assign funct3 = Instr[14:12];
assign funct7 = Instr[31:25];

endmodule