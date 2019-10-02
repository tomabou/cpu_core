module fmad_add(
    clken,
    clk,
    ope1,
    ope2,
    is_sub,
    is_neg,
    q);

    input clken;
    input clk;
    input [31:0] ope1;
    input [31:0] ope2;
    input is_sub;
    input is_neg;
    output [31:0] q;


    wire [31:0] ope1_new;
    wire [31:0] ope2_new;
    fp_inv fp_inv1(ope1,is_neg,ope1_new);
    fp_inv fp_inv2(ope2,is_sub,ope2_new);
    fp_add fp_add1(clk,1'b0,clken,ope1_new,ope2_new,q);

endmodule
