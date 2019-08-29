module top(clk,rxd,segment7_1,segment7_2,segment7_3,segment7_4,segment7_5,segment7_6,txd);
    input clk;
    input rxd;
    output [6:0] segment7_1;
    output [6:0] segment7_2;
    output [6:0] segment7_3;
    output [6:0] segment7_4;
    output [6:0] segment7_5;
    output [6:0] segment7_6;
    output txd;
    akari akari1(slow_clk,core_clk,rxd,segment7_1,segment7_2,segment7_3,segment7_4,segment7_5,segment7_6,txd);
    pll_slow pll_slow1(clk,slow_clk);
    pll_core pll_core1(clk,core_clk);
endmodule
