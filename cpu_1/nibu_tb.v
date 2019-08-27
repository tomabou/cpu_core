`timescale 1 ns/ 1ps

module nibu_tb();
    reg clk;
    wire [9:0] show;
    wire [6:0] seg1;
    wire [6:0] seg2;
    wire [6:0] seg3;
    wire [6:0] seg4;
    wire [6:0] seg5;
    wire [6:0] seg6;

    nibu u1(clk,show,seg1,seg2,seg3,seg4,seg5,seg6);

    initial clk = 1'b0;
    always #10
        clk = ~clk;
endmodule