module instr_decoder(
    input [6:0] opcode,
    output reg [1:0] ImmSrc
);

always @(*) begin
    case(opcode)

        7'b0000011: ImmSrc = 2'b00; // lw
        7'b0010011: ImmSrc = 2'b00; // addi

        7'b0100011: ImmSrc = 2'b01; // sw

        7'b1100011: ImmSrc = 2'b10; // beq

        7'b1101111: ImmSrc = 2'b11; // jal

        default:    ImmSrc = 2'b00;

    endcase
end

endmodule