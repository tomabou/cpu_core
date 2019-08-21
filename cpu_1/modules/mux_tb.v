`timescale 1 ns/ 1ps
module mux_tb();
    reg [31:0] data1;
    reg [31:0] data2;
    reg ctrl;
    wire [31:0] out;

    mux u1(data1, data2, out,ctrl);


    initial begin
        ctrl <= 1'b0;
        #10;
        data1 <= 32'd1023;
        data2 <= 32'b0;
        #10;
        ctrl <= 1'b1;
        #10;
        ctrl <= 1'b0;
    end
endmodule