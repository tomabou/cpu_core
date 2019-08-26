`timescale 1 ns/ 1ps
module data_memory_tb();
    reg clk;
    reg [31:0] addr;
    reg [31:0] writedata;
    wire [31:0] readdata;
    reg writectrl;

    data_memory u1(clk,addr,writedata,readdata,writectrl);


    initial clk = 1'b1;
    initial begin
        addr <= 32'd20;
        writectrl <= 1'b0;
        #10;
        writedata <= 32'd28;
        writectrl <= 1'b1;
        #10;
        addr <= 32'd24;
        writedata <= 32'd1023;
        writectrl <= 1'b1;
        #10;
        writectrl <= 1'b0;
        addr <= 32'd20;
        #10;
        addr <= 32'd24;
    end
    always #5
        clk = ~clk;
endmodule