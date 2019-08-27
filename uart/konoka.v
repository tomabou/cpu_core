module konoka(clk,rxd,data,txd);
    input clk;
    input rxd;
    output [7:0] data;
    output txd;

    wire slow_clk;
    wire rcv;
    wire [7:0] return;
    assign return = data+8'd1;
    pll_io pllio1(clk,slow_clk);
    uart_input uart_input1(slow_clk,rxd,data,rcv);
    uart_send uart_send1(slow_clk,return,rcv,txd);
    
endmodule 