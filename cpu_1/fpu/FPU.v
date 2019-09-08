module FPU(
    clk,
    inst,
    from_intreg,
    from_mem,
    to_mem,
    to_intreg,
    enable_ftoi);

    input clk;
    input [31:0] inst;
    input [31:0] from_intreg;
    input [31:0] from_mem;
    output [31:0] to_mem;
    output [31:0] to_intreg;
    output enable_ftoi;

    reg [4:0] rdi_buf[0:4];
    wire [31:0] write_data;
    wire [31:0] readdata1;
    wire [31:0] readdata2;
    wire [31:0] ope1;
    wire [31:0] ope2;
    wire [31:0] from_intreg_cvt;

    reg [31:0] result [0:4];
    wire [31:0] to_result [0:4];

    wire [31:0] addsub_out;
    wire [31:0] mul_out;
    

    wire reg_write;
    wire is_sub;
    wire is_load;
    wire is_adsb;
    wire is_mult;
    wire is_cvrt;
    wire is_ftoi;

    reg [4:0] reg_write_buf = 5'b0;
    reg [4:0] is_load_buf = 5'b0;
    reg [4:0] is_adsb_buf = 5'b0;
    reg [4:0] is_mult_buf = 5'b0;
    reg [4:0] is_cvrt_buf = 5'b0;
    reg [4:0] is_ftoi_buf = 5'b0;

    fpu_control fpu_control1(
        inst[31:27],
        inst[14:12],
        inst[6:0],
        reg_write,
        is_sub,
        is_load,
        is_adsb,
        is_mult,
        is_cvrt,
        is_ftoi);

    float_register freg1(
        clk,
        inst[19:15],
        inst[24:20],
        rdi_buf[4],
        write_data,
        reg_write_buf[4],
        readdata1,
        readdata2);

    assign ope1 = readdata1;
    assign ope2 = readdata2;

    assign enable_ftoi = is_ftoi_buf[0];
    float_to_int float_to_int1(ope1,is_cvrt_buf[0],to_intreg);
    int_to_float int_to_float1(from_intreg,is_cvrt_buf[0],from_intreg_cvt);
    assign to_mem = readdata2;

    fp_addsub fp_addsub1(clk,ope1,ope2,is_sub,addsub_out);
    fpu_mult fp_mult1 (clk,ope1,ope2,mul_out);



    // 0 is same as register
    // 0~1  itfcvt, control
    assign to_result[1] = from_intreg_cvt;
    assign to_result[2] = is_load_buf[1] ? from_mem : result[1];
    assign to_result[3] = is_adsb_buf[2] ? addsub_out : result[2];
    assign to_result[4] = result[3];
    assign write_data   = is_mult_buf[4] ? mul_out : result[4];

    always @ (posedge clk) begin
        rdi_buf[0] <= inst[11:7];
        rdi_buf[1] <= rdi_buf[0];
        rdi_buf[2] <= rdi_buf[1];
        rdi_buf[3] <= rdi_buf[2];
        rdi_buf[4] <= rdi_buf[3];

        result[1] <= to_result[1];
        result[2] <= to_result[2];
        result[3] <= to_result[3];
        result[4] <= to_result[4];

        reg_write_buf <= {reg_write_buf[3:0],reg_write};
        is_load_buf <= {is_load_buf[3:0],is_load};
        is_adsb_buf <= {is_adsb_buf[3:0],is_adsb};
        is_mult_buf <= {is_mult_buf[3:0],is_mult};
        is_cvrt_buf <= {is_cvrt_buf[3:0],is_cvrt};
        is_ftoi_buf <= {is_ftoi_buf[3:0],is_ftoi};

    end 

endmodule
