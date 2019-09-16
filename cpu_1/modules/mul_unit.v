module mul_unit (a,b,funct3,res);
    input [31:0] a;
    input [31:0] b;
    input [2:0] funct3;
    output [31:0] res;

    wire is_hi;
    wire [63:0] q;

    assign is_hi = (funct3 == 3'b011);

    assign res = is_hi ? q[63:32] 
               : q[31:0];

    multipl_ip multipl_ip1(a,b,q);

endmodule