module fp_addsub(
    clk,
    ope1,
    ope2,
    is_sub,
    q);

    input clk;
    input [31:0] ope1;
    input [31:0] ope2;
    input is_sub;
    output reg [31:0] q;


    wire [31:0] ope2_new;
    wire [31:0] ans;
    fp_inv fp_inv1(ope2,is_sub,ope2_new);
    fp_add fp_add1(clk,1'b0,ope1,ope2_new,ans);

    always @ (posedge clk)
        q <= ans;

endmodule
