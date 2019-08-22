`timescale 1 ns/ 1ps
module delay32_tb();
    reg clk;
    reg [31:0] in;
    wire [31:0] out;

    delay32 u1(clk,in,out);


    initial clk = 1'b1;
    initial begin
        #10;
        in <= 32'd5;
        #10;
        in <= 32'd9;
        #10;
        in <= 32'd14;
        #10;
        in <= 32'd2;
    end
    always #5
        clk = ~clk;
endmodule