module konoka(clk,rxd,txd);
    input clk;
    input rxd;
    output txd;

    wire slow_clk;

    wire data;

    pll_io pllio1(clk,slow_clk);

    uart_input uart_input1(slow_clk,rxd,data);

endmodule 