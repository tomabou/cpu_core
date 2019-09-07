`timescale 1 ns/ 1 ns

module FPU_tb();
    reg clk;
    reg [31:0] inst;

    FPU(clk,inst);

    initial clk <= 1'b0;
    always #10
        clk <= ~clk;


endmodule
