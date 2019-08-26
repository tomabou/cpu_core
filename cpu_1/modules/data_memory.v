module data_memory(clk,addr,writedata,readdata,writectrl);
    input clk;
    input [31:0] addr;
    input [31:0] writedata;
    output [31:0] readdata;
    input writectrl;


    ram1 data_ram(
        addr[15:2],
        clk,
        writedata,
        writectrl,
        readdata
    );

endmodule
