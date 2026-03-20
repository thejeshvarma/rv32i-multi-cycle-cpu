module regfile(
input clk,
input RegWrite,
input [4:0] A1, A2, A3,
input [31:0] WriteData,
output [31:0] RD1, RD2
);

reg [31:0] registers [0:31];
integer i;

// reset registers
initial begin
    for(i=0;i<32;i=i+1)
        registers[i] = 0;
end

assign RD1 = registers[A1];
assign RD2 = registers[A2];

always @(posedge clk) begin
    if(RegWrite && A3 != 0)
        registers[A3] <= WriteData;
end

endmodule