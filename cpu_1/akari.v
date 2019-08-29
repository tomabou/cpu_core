module akari(clk,rxd,segment7_1,segment7_2,segment7_3,segment7_4,segment7_5,segment7_6,txd);
    input clk;
    input rxd;
    output [6:0] segment7_1;
    output [6:0] segment7_2;
    output [6:0] segment7_3;
    output [6:0] segment7_4;
    output [6:0] segment7_5;
    output [6:0] segment7_6;
    output txd;
    wire slow_clk;
    wire [9:0] show;

    wire [7:0] uart_in;
    wire [7:0] uart_out;
    wire uart_rdreq;
    wire uart_wrreq;
    wire uart_empty;

    pll_slow pll_slow1(clk,slow_clk);
    nibu nibu1(
        clk,
        show,
        segment7_1,
        segment7_2,
        segment7_3,
        segment7_4,
        segment7_5,
        segment7_6,
        uart_empty,
        uart_in,
        uart_out,
        uart_rdreq,
        uart_wrreq);

    uart uart1(slow_clk,rxd,txd,
        clk,
        uart_wrreq,
        uart_out,
        uart_rdreq,
        uart_in,
        empty);


endmodule

