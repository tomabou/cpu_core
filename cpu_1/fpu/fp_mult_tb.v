`timescale 1 ns/ 1 ns

module fp_mult_tb();

    reg clk;
    reg [31:0] ope1;
    reg [31:0] ope2;
    wire [31:0] q;

    fpu_mult fp_mult1(clk,ope1,ope2,q);

    initial clk <= 1'b0;
    always #10
        clk <= ~clk;

    initial begin
        #15;
        ope1 <= 32'b0_01111101_00110011001100110011001; // 0.3
        ope2 <= 32'b0_01111011_10011001100110011001100; //0.1
        #10;
        #20;
        #20;
        ope2 <= 32'b0_10000010_01000000000000000000000;//10
    end

endmodule
