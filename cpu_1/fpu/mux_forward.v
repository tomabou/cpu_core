module mux_forward(
    a,
    forward1,
    forward2,
    forward3,
    forward4,
    out,
    use1,
    use2,
    use3,
    use4
);
    input [31:0] a;
    input [31:0] forward1;
    input [31:0] forward2;
    input [31:0] forward3;
    input [31:0] forward4;
    output [31:0] out;
    input use1;
    input use2;
    input use3;
    input use4;

    assign out = use1 ? forward1
               : use2 ? forward2
               : use3 ? forward3
               : use4 ? forward4
               : a;
endmodule