`timescale 1 ns /1 ps

module uart_rcv_tb();
  reg clk,rxd;
  wire [7:0] data;
  wire err;
  wire data_clk;
  wire [3:0] rcv_data;
  
  uart_rcv u1(clk,rxd,data,err,data_clk,rcv_data);
  
  
  initial begin
    rxd = 1;
    #2000 rxd = 0;
    #1000 rxd =1 ;
    #1000 rxd =0 ;
    #1000 rxd =1 ;
    #1000 rxd =1 ;
    #1000 rxd =0 ;
    #1000 rxd =1 ;
    #1000 rxd =0 ;
    #1000 rxd =0 ;
    #1000 rxd = 1;
	 #2222 rxd = 0;
    #1000 rxd =1 ;
    #1000 rxd =1 ;
    #1000 rxd =1 ;
    #1000 rxd =1 ;
    #1000 rxd =0 ;
    #1000 rxd =0 ;
    #1000 rxd =0 ;
    #1000 rxd =0 ;
    #1000 rxd = 1;
    #3000 $finish;
  end
  
  initial clk = 1'b0;
  always #125  
    clk <= ~clk;
endmodule