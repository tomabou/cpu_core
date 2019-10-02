module fpu_mult(clken,clk,ope1,ope2,q);
    input clken;
    input clk;
    input [31:0] ope1;
    input [31:0] ope2;
    output [31:0] q;

    fpmul fpmul1(clk,1'b0,clken,ope1,ope2,q);
endmodule
