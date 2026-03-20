module ALU(
input [31:0]SrcA,SrcB,
input [2:0] ALUControl,
output reg [31:0]ALUResult ,
output Zero    
);


localparam ADD = 3'b000,
          SUB = 3'b001,
          AND = 3'b010,
          OR  = 3'b011,
          SLT = 3'b101;

always@(*) begin

        case(ALUControl)
            ADD : ALUResult = SrcA + SrcB;
            SUB : ALUResult = SrcA - SrcB;
            AND : ALUResult = SrcA & SrcB;
            OR : ALUResult = SrcA | SrcB;
            SLT : ALUResult = ($signed(SrcA) < $signed(SrcB)) ? 32'd1 : 32'd0;
            default : ALUResult = 32'b0;
        endcase
end

assign Zero = (ALUResult == 32'b0);

endmodule
