`timescale 1 ns/ 1ps
module alu_tb();
    reg [31:0] data1;
    reg [31:0] data2;
    reg [3:0] ctrl;
    wire [31:0] out;

    alu u1(data1, data2, out,ctrl);

    initial begin
        ctrl <= 4'd7;
        #10;
        data1 <= -32'd1;
        data2 <= 32'd1;
        #10;
        data1 <= 32'd1;
        data2 <= 32'd2;
        #10;
        data1 <= 32'd2;
        data2 <= 32'd1;
        #10;
        data1 <= 32'd1;
        data2 <= -32'd1;
        #10
        ctrl <= 4'd9;
        #10;
        data1 <= -32'd1;
        data2 <= 32'd1;
        #10;
        data1 <= 32'd1;
        data2 <= 32'd2;
        #10;
        data1 <= 32'd2;
        data2 <= 32'd1;
        #10;
        data1 <= 32'd1;
        data2 <= -32'd1;
    end
endmodule