module fpu_mult(clk,ope1,ope2,q);
    input clk;
    input [31:0] ope1;
    input [31:0] ope2;
    output [31:0] q;

    fpmul fpmul1(clk,1'b0,ope1,ope2,q);
endmodule
