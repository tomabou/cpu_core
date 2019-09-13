module fpu_cmp(
    clk,
    a,
    b,
    is_eq,
    is_le,
    q
);
    input clk;
    input [31:0] a;
    input [31:0] b;
    input is_eq;
    input is_le;
    output [31:0] q;

    wire eq;
    wire lt;

    fpu_equal fpu_equal1(clk,1'b0,a,b,eq);
    less_than less_than1(clk,1'b0,a,b,lt);

    assign q = is_eq ? {31'b0,eq}
             : is_le ? {31'b0,(eq | lt)}
             : {31'b0,lt};

endmodule