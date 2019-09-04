module mux_reg(
    a,b,out,ctrl,iszero);
    input [31:0] a;
    input [31:0] b;
    output [31:0] out;
    input ctrl;
    input iszero;

    assign out = iszero ? 32'b0 : (ctrl ? b : a);

endmodule
