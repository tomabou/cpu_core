module fp_addsub(
    clken,
    clk,
    ope1,
    ope2,
    is_sub,
    q);

    input clken;
    input clk;
    input [31:0] ope1;
    input [31:0] ope2;
    input is_sub;
    output [31:0] q;


    wire [31:0] ope2_new;
    fp_inv fp_inv1(ope2,is_sub,ope2_new);
    fp_add fp_add1(clk,1'b0,clken,ope1,ope2_new,q);

endmodule
