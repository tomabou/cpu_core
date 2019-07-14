`timescale 1 ns/ 1ps

module uart_input_tb();
    reg clk,reset,rxd;
    wire [7:0] data;

    uart_input u1(clk,reset,rxd,data);

    initial begin
        rxd = 1;
        #200000 rxd = 0;
        #104166 rxd =1 ;
        #104166 rxd =0 ;
        #104166 rxd =1 ;
        #104166 rxd =1 ;
        #104166 rxd =0 ;
        #104166 rxd =1 ;
        #104166 rxd =0 ;
        #104166 rxd =0 ;
        #104166 rxd = 1;
        #222200 rxd = 0;
        #104166 rxd =1 ;
        #104166 rxd =1 ;
        #104166 rxd =1 ;
        #104166 rxd =1 ;
        #104166 rxd =0 ;
        #104166 rxd =0 ;
        #104166 rxd =0 ;
        #104166 rxd =0 ;
        #104166 rxd = 1;
        #300000 $finish;
    end

    initial clk = 1'b0;
    initial reset = 1'b1;
    always #10
        clk = ~clk;

endmodule