module data_memory(
    clk,addr,writedata,readdata,
    writectrl,readctrl,
    empty,uart_in,uart_out,wrreq,rdreq,
    seg_io);
    input clk;
    input [31:0] addr;
    input [31:0] writedata;
    output reg [31:0] readdata;
    input writectrl;
    input readctrl;
    input empty;
    input [7:0] uart_in;
    output [7:0] uart_out;
    output wrreq;
    output rdreq;
    output reg [15:0] seg_io;

    wire [31:0] ram_readdata;
    reg isuart_pre = 1'b0;
    reg empty_pre = 1'b0;

    always @ (*) begin
        if (~isuart_pre) 
            readdata<=ram_readdata;
        else if (~empty_pre)
            readdata<={24'b0,uart_in};
        else
            readdata<={32{1'b1}};
    end



    assign uart_out = writedata[7:0];
    assign wrreq = (addr == 32'b100 & writectrl);
    assign rdreq = (addr == 32'b100 & readctrl & (~empty));
    ram1 data_ram(
        addr[15:2],
        clk,
        writedata,
        writectrl,
        ram_readdata
    );

    always @ (posedge clk) begin
        if (addr == 32'b0 & writectrl)
            seg_io <= writedata[15:0];
        isuart_pre <= (addr == 32'b100 & readctrl);
        empty_pre <= empty;
    end

endmodule
