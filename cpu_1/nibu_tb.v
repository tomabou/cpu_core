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
    reg uart_empty =1'b0;
    reg [7:0] uart_in = 1'b0;
    wire [7:0] uart_out;
    wire uart_wrreq;
    wire uart_rdreq;

    nibu u1(clk,show,seg1,seg2,seg3,seg4,seg5,seg6,
        uart_empty,uart_in,uart_out,uart_wrreq,uart_rdreq);

    initial clk = 1'b0;
    always #10
        clk = ~clk;
endmodule