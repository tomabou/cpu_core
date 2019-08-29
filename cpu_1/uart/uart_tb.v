`timescale 1 ns/ 1ps

module uart_tb();
    reg slow_clk;
    reg rxd;
    wire txd;
    reg clk;
    reg wrreq;
    reg [7:0] write_data = 8'b0;
    reg rdreq = 1'b0;
    wire [7:0] read_data;
    wire empty;

    uart u1(slow_clk,rxd,txd,clk,wrreq,write_data,rdreq,read_data,empty);

    initial begin
        rxd <= 1;
        wrreq <=0;
        #53 rxd <= 0;
        #40 rxd <=1 ;
        #40 rxd <=0 ;
        #40 rxd <=1 ;
        #40 rxd <=1 ;
        #40 rxd <=0 ;
        #40 rxd <=1 ;
        #40 rxd <=0 ;
        #40 rxd <=0 ;
        #40 rxd <= 1;
        #40 rxd <= 0;
        #40 rxd <=1 ;
        #40 rxd <=1 ;
        #40 rxd <=1 ;
        #40 rxd <=1 ;
        #40 rxd <=0 ;
        #40 rxd <=0 ;
        #40 rxd <=0 ;
        #40 rxd <=0 ;
        #40 rxd <= 1;
        #500;
        rdreq <= 1;
        #4;
        rdreq <= 1;
        #8;
        rdreq <= 1;
        #4;
        rdreq <= 0;
        write_data <= 8'b10101010;
        wrreq <= 1;
        #4;
        write_data <= 8'b0;
        wrreq <= 0;
    end

    initial clk <= 1'b1;
    initial slow_clk <= 1'b1;
    always #5
        slow_clk <= ~slow_clk;
    always #2
        clk <= ~clk;

endmodule