`timescale 1 ns /1 ps

module mod_new();
	reg clk;
	wire out;
	
	pll_test u1(clk,out);
	
	
	initial begin
		#500 $finish;
	end
	
	initial clk = 1'b0;
	always #9	
		clk <= ~clk;
endmodule