`timescale 1ns/1ps

module tb_cpu;

reg clk;
reg reset;

cpu uut (
    .clk(clk),
    .reset(reset)
);

//////////////////////////////////////////////////
// Clock generation
//////////////////////////////////////////////////

always #5 clk = ~clk;   // 10ns clock

//////////////////////////////////////////////////
// Simulation
//////////////////////////////////////////////////

initial begin

    $dumpfile("cpu.vcd");
    $dumpvars(0,tb_cpu);

    clk = 0;
    reset = 1;

    #20;
    reset = 0;

    #500;

    $finish;

end

//////////////////////////////////////////////////
// Program Memory Initialization
//////////////////////////////////////////////////

initial begin

    // program instructions
    uut.dp.mem.memory[0] = 32'h00500093; // addi x1,x0,5
    uut.dp.mem.memory[1] = 32'h00A00113; // addi x2,x0,10
    uut.dp.mem.memory[2] = 32'h002081B3; // add x3,x1,x2
    uut.dp.mem.memory[3] = 32'h00302023; // sw x3,0(x0)
    uut.dp.mem.memory[4] = 32'h00002203; // lw x4,0(x0)

end

endmodule