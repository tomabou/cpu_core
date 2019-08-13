`timescale 1 ns/ 1ps

module nibu_tb();
    reg clk;
    wire [9:0] show;

    nibu u1(clk,show);

    initial clk = 1'b0;
    always #10
        clk = ~clk;
endmodule