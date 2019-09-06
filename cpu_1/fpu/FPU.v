module FPU(
    clk,
    inst);

    input clk;
    input [31:0] inst;

    reg [4:0] rdi_buf;
    wire [31:0] write_data;
    wire [31:0] readdata1;
    wire [31:0] readdata2;
    wire [31:0] ope1;
    wire [31:0] ope2;

    wire [31:0] addsub_out;
    

    wire reg_write_ctrl;
    wire is_sub_ctrl;


    float_register freg1(
        clk,
        inst[19:15],
        inst[24:20],
        rdi_buf,
        write_data,
        reg_write_ctrl,
        readdata1,
        readdata2);

    assign ope1 = readdata1;
    assign ope2 = readdata2;

    fp_addsub fp_addsub1(clk,ope1,ope2,is_sub_ctrl,addsub_out);

endmodule
