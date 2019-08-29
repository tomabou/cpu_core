module akari(slow_clk,core_clk,rxd,segment7_1,segment7_2,segment7_3,segment7_4,segment7_5,segment7_6,txd);
    input slow_clk;
    input core_clk;
    input rxd;
    output [6:0] segment7_1;
    output [6:0] segment7_2;
    output [6:0] segment7_3;
    output [6:0] segment7_4;
    output [6:0] segment7_5;
    output [6:0] segment7_6;
    output txd;
    wire [9:0] show;

    wire [7:0] uart_in;
    wire [7:0] uart_out;
    wire uart_rdreq;
    wire uart_wrreq;
    wire uart_empty;

    nibu nibu1(
        core_clk,
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
        core_clk,
        uart_wrreq,
        uart_out,
        uart_rdreq,
        uart_in,
        uart_empty);


endmodule

