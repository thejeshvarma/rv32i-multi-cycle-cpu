module ALUOutReg(
    input clk ,
    input [31:0]ALUResult,
    output reg [31:0]ALUOut
);
    always @(posedge clk ) begin
        ALUOut <= ALUResult;
    end

endmodule