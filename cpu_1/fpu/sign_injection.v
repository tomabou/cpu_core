module sign_injection(a,b,is_n,is_x,q);
    input [31:0] a;
    input [31:0] b;
    input is_n;
    input is_x;
    output [31:0] q;
    
    wire top_bit;
    assign top_bit = is_n ? ~b[31]
                   : is_x ? (a[31] ^ b[31])
                   : b[31];

    assign q = {top_bit,a[30:0]};
endmodule