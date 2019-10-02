module float_to_int(
    clken,
    clk,
    x,
    ope2,   
    is_cvt,
    is_cmp,
    is_eq,
    is_le,
    y);
    input clken;
    input clk;
    input [31:0] x;
    input [31:0] ope2;
    input is_cvt;
    input is_cmp;
    input is_eq;
    input is_le;
    output [31:0] y;

    reg [31:0] x_buf;
    wire [31:0] x_cvt;
    wire [31:0] cmp_res;

    assign y = is_cvt ? x_cvt 
             : is_cmp ? cmp_res
             : x_buf ;

    cvt_ftoi cvt_ftoi1(clk,1'b0,clken,x,x_cvt);
    fpu_cmp fpu_cmp(clken,clk,x,ope2,is_eq,is_le,cmp_res);

    always @ (posedge clk) begin
        if (clken)
            x_buf <= x;
    end

endmodule
