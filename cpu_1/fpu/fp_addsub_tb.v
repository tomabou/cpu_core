`timescale 1 ns/ 1 ns

module fp_addsub_tb();

    reg clk;
    reg [31:0] ope1;
    reg [31:0] ope2;
    reg is_sub;
    wire [31:0] q;

    fp_addsub fp_addsub1(clk,ope1,ope2,is_sub,q);

    initial clk <= 1'b0;
    always #10
        clk <= ~clk;

    initial begin
        ope1 <= 32'b0_01111101_00110011001100110011001; // 0.3
        ope2 <= 32'b0_01111011_10011001100110011001100; //0.1
        is_sub <= 1'b0;
        #10;
        #20;
        is_sub <= 1'b1;
        #20;
        is_sub <= 1'b0;
    end

endmodule
