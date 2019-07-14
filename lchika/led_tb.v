`timescale 1 ns /1 ps

module led_tb();
	reg clk;
	reg reset;
	wire [9:0] led;
	
	led u1(clk,reset,led);
	
	initial reset = 1;
	
	initial begin
		#500000 $finish;
	end
	
	initial clk = 0;
	always #10	
		clk <= ~clk;

endmodule