module ip_test (
    clk,
    segment7_1,
    segment7_2,
    segment7_3,
    segment7_4,
    segment7_5,
    segment7_6);

    input clk;
    output [6:0] segment7_1;
    output [6:0] segment7_2;
    output [6:0] segment7_3;
    output [6:0] segment7_4;
    output [6:0] segment7_5;
    output [6:0] segment7_6;


    reg [3:0] count = 4'b0;

    wire [31:0] src1 ;
    wire [31:0] src2 ;
    wire [31:0] res;

    assign src1 = (count == 4'b1) ? 32'b010000001_10010011001100110011001 : 32'b0;
    assign src2 = (count == 4'b1) ? 32'b010000001_10010011001100110011001 : 32'b0;

    //cvt_ftoi cvt_ftoi1(clk,1'b0,src,res);
    add add1(clk,1'b0,src1,src2,res);

    seg7 seg7_1(count,segment7_1);
    seg7 seg7_2(src1[3:0],segment7_2);
    seg7 seg7_3(res[3:0],segment7_3);
    seg7 seg7_4(res[7:4],segment7_4);
    seg7 seg7_5(res[27:24],segment7_5);
    seg7 seg7_6(res[31:28],segment7_6);

    always @ (posedge clk) begin
        count <= count + 4'b1;
    end

endmodule
