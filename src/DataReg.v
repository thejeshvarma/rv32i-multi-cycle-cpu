module dataReg(
    input clk , 
    input [31:0] ReadData,
    output reg [31:0] Data
);
    always @(posedge clk ) begin
        Data <= ReadData;
    end
endmodule