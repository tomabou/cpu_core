module akari(clk,rxd,seg1,seg2,seg3,seg4,seg5,seg6,txd);
    input clk;
    input rxd;
    output [6:0] seg1;
    output [6:0] seg2;
    output [6:0] seg3;
    output [6:0] seg4;
    output [6:0] seg5;
    output [6:0] seg6;
    output txd;
    wire slow_clk;
    wire [9:0] show;

    wire [7:0] uart_in;
    wire [7:0] uart_out;
    wire uart_rdreq;
    wire uart_wrreq;

    pll_slow pll_slow1(clk,slow_clk);
    nibu nibu1(
        clk,
        show,
        seg1,
        seg2,
        seg3,
        seg4,
        seg5,
        seg6,
        uart_in,
        uart_out,
        uart_rdreq,
        uart_wrreq);

    uart uart1(slow_clk,rxd,txd,
        clk,uart_wrreq,uart_out,uart_rdreq,uart_in,empty);


endmodule

