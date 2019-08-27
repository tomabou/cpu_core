module konoka(clk,rxd,data);
    input clk;
    input rxd;
    output [7:0] data;

    wire slow_clk;
    pll_io pllio1(clk,slow_clk);
    uart_input uart_input1(slow_clk,rxd,data);

endmodule 