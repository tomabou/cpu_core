module pll_test(clk,out);
	input clk;
	output out;
	wire reset;
	assign reset = 1'b0;
	
	pll pll1(reset,clk,out);
	
endmodule