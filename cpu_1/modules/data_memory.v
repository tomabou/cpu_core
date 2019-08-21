module data_memory(clk,addr,writedata,readdata,readctrl,writectrl);
    input clk;
    input [31:0] addr;
    input [31:0] writedata;
    output [31:0] readdata;
    input readctrl;
    input writectrl;

    assign readdata = 31'b0;

endmodule
