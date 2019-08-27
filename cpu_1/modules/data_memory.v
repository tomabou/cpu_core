module data_memory(clk,addr,writedata,readdata,writectrl,seg_io);
    input clk;
    input [31:0] addr;
    input [31:0] writedata;
    output [31:0] readdata;
    input writectrl;

    output reg [15:0] seg_io;

    ram1 data_ram(
        addr[15:2],
        clk,
        writedata,
        writectrl,
        readdata
    );

    always @ (posedge clk) begin
        if (addr == 32'b0 & writectrl)
            seg_io <= writedata[15:0];
    end

endmodule
