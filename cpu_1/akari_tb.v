`timescale 1 ns/ 1ns

module akari_tb();
    reg slow_clk;
    reg core_clk;
    reg rxd;
    wire [6:0] segment7_1;
    wire [6:0] segment7_2;
    wire [6:0] segment7_3;
    wire [6:0] segment7_4;
    wire [6:0] segment7_5;
    wire [6:0] segment7_6;
    wire txd;

    akari akari1(slow_clk,core_clk,rxd,segment7_1,segment7_2,segment7_3,segment7_4,segment7_5,segment7_6,txd);

    initial slow_clk <= 1'b0;
    always #10
        slow_clk <= ~slow_clk;

    initial core_clk <= 1'b0;
    always #1
        core_clk <= ~core_clk;

    initial begin
        rxd <= 1;
        #95;
        #80 rxd <= 0;
        #80 rxd <=1 ;
        #80 rxd <=1 ;
        #80 rxd <=1 ;
        #80 rxd <=1 ;
        #80 rxd <=0 ;
        #80 rxd <=0 ;
        #80 rxd <=0 ;
        #80 rxd <=0 ;
        #80 rxd <= 1;
    end
endmodule