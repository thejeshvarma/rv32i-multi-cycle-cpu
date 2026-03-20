module main_memory (
    input [31:0]A,WriteData,
    input clk , WE,
    output [31:0]ReadData
);
    reg [31:0]memory[0:255];

    always @(posedge clk) begin
        if(WE)
            memory[A[9:2]] <= WriteData;
    end
    assign ReadData =memory[A[9:2]];
endmodule