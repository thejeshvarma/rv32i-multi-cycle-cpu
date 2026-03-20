module alu_decoder (
    input [1:0]ALUOp ,
    input [2:0]funct3,
    input [6:0] funct7,op,
    output reg [2:0]ALUControl
);
    always @(*) begin
        ALUControl = 3'b000; 
        case(ALUOp)
            2'b00 : ALUControl = 3'b000;
            2'b01 : ALUControl = 3'b001;
            2'b10 : begin
                case(funct3)
                    3'b000: begin
                        // ADD/SUB for R-type, ADDI for I-type
                        if (op[5] && (funct7[5]))
                            ALUControl = 3'b001; // SUB
                        else
                            ALUControl = 3'b000; // ADD
                    end
                    3'b010 : ALUControl = 3'b101;  //SLT
                    3'b110 : ALUControl = 3'b010; //OR 
                    3'b111 : ALUControl = 3'b011; //AND

                endcase
            end

        endcase
    end
endmodule