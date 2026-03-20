module SrcREG(input clk ,
input [31:0] Ain ,Bin,
output reg [31:0] A,B
);
    always @(posedge clk) begin
        A <= Ain;
        B <= Bin;
    end

endmodule