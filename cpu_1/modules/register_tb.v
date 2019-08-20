
`timescale 1 ns/ 1ps

module register_tb();
    reg clk;
    reg [4:0] rs1i;
    reg [4:0] rs2i;
    reg [4:0] rdi;
    reg [31:0] write_data;
    reg reg_write;
    wire [31:0] read_data1;
    wire [31:0] read_data2;

    registers u1(
        clk,
        rs1i,
        rs2i,
        rdi,
        write_data,
        read_data1,
        read_data2,
        reg_write);

    initial clk = 1'b1;

    initial begin
        #10;
        reg_write = 1'b1;
        write_data = 32'b11111;
        rdi = 4'b1010;
        #10;
        reg_write = 1'b0;
        rs1i = 4'b1010;
        #10;
        rs1i = 4'b1111;
        rs2i = 4'b1010;
        rdi = 4'b1111;
        write_data = 32'b110;
        reg_write = 1'b1;
        #10;
        reg_write = 1'b0;


    end

        


    always #5
        clk = ~clk;
endmodule