`timescale 1 ns/ 1ps
module immgen_tb();
    reg clk;
    reg [31:0] inst;
    wire [31:0] imm;

    immgen u1(clk,inst,imm);


    initial clk = 1'b1;
    initial begin
        #10;
        inst <= {12'b101010101011,5'b0,3'b0,5'b0,7'b0010011};
    end
    always #5
        clk = ~clk;
endmodule