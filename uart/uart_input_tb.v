`timescale 1 ns/ 1ps

module uart_input_tb();
    reg clk,rxd;
    wire [7:0] data;

    uart_input u1(clk,rxd,data);

    initial begin
        rxd = 1;
        #53 rxd = 0;
        #40 rxd =1 ;
        #40 rxd =0 ;
        #40 rxd =1 ;
        #40 rxd =1 ;
        #40 rxd =0 ;
        #40 rxd =1 ;
        #40 rxd =0 ;
        #40 rxd =0 ;
        #40 rxd = 1;
        #40 rxd = 0;
        #40 rxd =1 ;
        #40 rxd =1 ;
        #40 rxd =1 ;
        #40 rxd =1 ;
        #40 rxd =0 ;
        #40 rxd =0 ;
        #40 rxd =0 ;
        #40 rxd =0 ;
        #40 rxd = 1;
    end

    initial clk = 1'b0;
    always #5
        clk = ~clk;

endmodule