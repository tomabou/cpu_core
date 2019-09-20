module mul_unit (clk,a,b,funct3,res);
    input clk;
    input [31:0] a;
    input [31:0] b;
    input [2:0] funct3;
    output [31:0] res;

    wire is_upperbit;
    wire is_h;
    wire is_hsu;
    wire is_hu;
    wire [39:0] ope1;
    wire [39:0] ope2;
    wire [79:0] q;

    reg is_upperbit_buf1;
    reg is_upperbit_buf2;


    assign is_h = (funct3 == 3'b001);
    assign is_hsu = (funct3 == 3'b010);
    assign is_hu = (funct3 == 3'b011);
    assign is_upperbit = is_h | is_hu | is_hsu;

    assign ope1 = {{8{is_h | is_hsu}},a};
    assign ope2 = {{8{is_h}},b};

    assign res = is_upperbit_buf2 ? q[63:32] 
               : q[31:0];

    multipl_ip multipl_ip1(clk,ope1,ope2,q);

    always @ (posedge clk) begin
        is_upperbit_buf1 <= is_upperbit;
        is_upperbit_buf2 <= is_upperbit_buf1;
    end

endmodule