module FPU(
    clk,
    inst,
    from_intreg,
    from_mem);

    input clk;
    input [31:0] inst;
    input [31:0] from_intreg;
    input [31:0] from_mem;

    reg [4:0] rdi_buf[0:4];
    wire [31:0] write_data;
    wire [31:0] readdata1;
    wire [31:0] readdata2;
    wire [31:0] ope1;
    wire [31:0] ope2;
    reg [31:0] result [0:4];
    wire [31:0] to_result [0:4];

    wire [31:0] addsub_out;
    wire [31:0] mul_out;
    

    wire reg_write_ctrl;
    wire is_sub_ctrl;
    wire is_itof;
    wire is_load;
    wire is_adsb;
    wire is_mult;

    reg [4:0] is_load_buf = 5'b0;
    reg [4:0] is_adsb_buf = 5'b0;
    reg [4:0] is_mult_buf = 5'b0;

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
    fpu_mult fp_mult1 (clk,ope1,ope2,mul_out);

    // 0 is same as register
    // 0~1  itfcvt, control

    

    assign to_result[1] = from_intreg;
    assign to_result[2] = is_load_buf[1] ? from_mem : result[1];
    assign to_result[3] = is_adsb_buf[2] ? addsub_out : result[2];
    assign to_result[4] = result[3];
    assign write_data   = is_mult_buf[4] ? mul_out : result[4]

    always @ (clk posedge) begin
        rdi_buf[0] <= inst[11:7];
        rdi_buf[1] <= rdi_buf[0];
        rdi_buf[2] <= rdi_buf[1];
        rdi_buf[3] <= rdi_buf[2];
        rdi_buf[4] <= rdi_buf[3];

        result[1] <= to_result[1];
        result[2] <= to_result[2];
        result[3] <= to_result[3];
        result[4] <= to_result[4];

        is_load_buf <= {is_load_buf[3:1],is_load,1'b0};
        is_adsb_buf <= {is_adsb_buf[3:1],is_adsb,1'b0};
        is_mult_buf <= {is_mult_buf[3:1],is_mult,1'b0};

    end 

endmodule
