module instREG(input clk , IRWrite ,
input [31:0] Instruction_in , PC ,
output reg [31:0] Instruction , OldPC
);
    always @(posedge clk) begin
        if(IRWrite) begin
            Instruction <= Instruction_in;
            OldPC <= PC;
        end
    end

endmodule