module mux_reg(
    a,
    forward1,
    forward2,
    out,
    use1,
    use2,
    iszero);
    input [31:0] a;
    input [31:0] forward1;
    input [31:0] forward2;
    output [31:0] out;
    input use1;
    input use2;
    input iszero;

    assign out = iszero ? 32'b0 
               : use1   ? forward1 
               : use2   ? forward2
               : a;

endmodule
