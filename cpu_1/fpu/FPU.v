module FPU(
    clken,
    clk,
    is_legl,
    inst,
    from_intreg,
    from_mem,
    to_mem,
    to_intreg,
    hazard);

    input clken;
    input clk;
    input is_legl;
    input [31:0] inst;
    input [31:0] from_intreg;
    input [31:0] from_mem;
    output [31:0] to_mem;
    output [31:0] to_intreg;
    output hazard;

    reg [4:0] rdi_buf[0:6];
    reg [4:0] rs1_buf;
    reg [4:0] rs2_buf;
    reg [4:0] rs3_buf;
    wire [31:0] write_data;
    wire [31:0] readdata1;
    wire [31:0] readdata2;
    wire [31:0] readdata3;
    wire [31:0] ope1;
    wire [31:0] ope2;
    wire [31:0] ope3;
    wire [31:0] from_intreg_cvt;

    reg [31:0] result [0:6];
    wire [31:0] to_result [0:6];

    reg [31:0] readdata3_buf [0:3];

    wire [31:0] addsub_out;
    wire [31:0] mul_out;
    wire [31:0] fsgn_out;
    wire [31:0] fmad_out;

    reg [31:0] from_mem_buf_3;
    
    wire rg1_forward_1;
    wire rg1_forward_2;
    wire rg1_forward_3;
    wire rg1_forward_4;
    wire rg1_forward_5;
    wire rg1_forward_6;
    wire rg2_forward_1;
    wire rg2_forward_2;
    wire rg2_forward_3;
    wire rg2_forward_4;
    wire rg2_forward_5;
    wire rg2_forward_6;
    wire rg3_forward_1;
    wire rg3_forward_2;
    wire rg3_forward_3;
    wire rg3_forward_4;
    wire rg3_forward_5;
    wire rg3_forward_6;

    wire reg_write;
    wire is_sub;
    wire is_load;
    wire is_adsb;
    wire is_mult;
    wire is_cvrt;
    wire is_ftoi;
    wire is_cvif;
    wire is_fcmp;
    wire is_eqal;
    wire is_leth;
    wire is_fsgn;
    wire is_sgnn;
    wire is_sgnx;
    wire is_fmad;
    wire is_FSUB;
    wire is_FNEG;
    wire use_rs1;
    wire use_rs2;
    wire use_rs3;
    wire is_hazard_0;
    wire is_hazard_1;
    wire is_hazard_2;
    wire is_hazard_3;
    wire is_hazard_4;

    reg [6:0] reg_write_buf = 7'b0;
    reg [6:0] is_sub_buf = 7'b0;
    reg [6:0] is_load_buf = 7'b0;
    reg [6:0] is_adsb_buf = 7'b0;
    reg [6:0] is_mult_buf = 7'b0;
    reg [6:0] is_cvrt_buf = 7'b0;
    reg [6:0] is_ftoi_buf = 7'b0;
    reg [6:0] is_cvif_buf = 7'b0;
    reg [6:0] is_legl_buf = 7'b0;
    reg [6:0] is_fcmp_buf = 7'b0;
    reg [6:0] is_eqal_buf = 7'b0;
    reg [6:0] is_leth_buf = 7'b0;
    reg [6:0] is_fsgn_buf = 7'b0;
    reg [6:0] is_sgnn_buf = 7'b0;
    reg [6:0] is_sgnx_buf = 7'b0;
    reg [6:0] is_fmad_buf = 7'b0;
    reg [6:0] is_FSUB_buf = 7'b0;
    reg [6:0] is_FNEG_buf = 7'b0;
    reg [6:0] is_hazard_0_buf = 7'b0;
    reg [6:0] is_hazard_1_buf = 7'b0;
    reg [6:0] is_hazard_2_buf = 7'b0;
    reg [6:0] is_hazard_3_buf = 7'b0;
    reg [6:0] is_hazard_4_buf = 7'b0;

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
        is_ftoi,
        is_cvif,
        is_fcmp,
        is_eqal,
        is_leth,
        is_fsgn,
        is_sgnn,
        is_sgnx,
        is_fmad,
        is_FSUB,
        is_FNEG,
        is_hazard_0,
        is_hazard_1,
        is_hazard_2,
        is_hazard_3,
        is_hazard_4,
        use_rs1,
        use_rs2,
        use_rs3);

    fpu_hazard_detect fpu_hazard_detect1(
        inst[19:15],
        inst[24:20],
        inst[31:27],
        rdi_buf[0],
        rdi_buf[1],
        rdi_buf[2],
        rdi_buf[3],
        rdi_buf[4],
        use_rs1,
        use_rs2,
        use_rs3,
        reg_write_buf[0],
        reg_write_buf[1],
        reg_write_buf[2],
        reg_write_buf[3],
        reg_write_buf[4],
        is_legl_buf[0],
        is_legl_buf[1],
        is_legl_buf[2],
        is_legl_buf[3],
        is_legl_buf[4],
        is_hazard_0_buf[0],
        is_hazard_1_buf[1],
        is_hazard_2_buf[2],
        is_hazard_3_buf[3],
        is_hazard_4_buf[4],
        hazard
    );

    float_register freg1(
        clken,
        clk,
        inst[19:15],
        inst[24:20],
        inst[31:27],
        rdi_buf[6],
        write_data,
        reg_write_buf[6] & is_legl_buf[6],
        readdata1,
        readdata2,
        readdata3);

    mux_forward mux_forward1(
        readdata1,
        to_result[2],
        to_result[3],
        to_result[4],
        to_result[5],
        to_result[6],
        write_data,
        ope1,
        rg1_forward_1,
        rg1_forward_2,
        rg1_forward_3,
        rg1_forward_4,
        rg1_forward_5,
        rg1_forward_6
    );

    mux_forward mux_forward2(
        readdata2,
        to_result[2],
        to_result[3],
        to_result[4],
        to_result[5],
        to_result[6],
        write_data,
        ope2,
        rg2_forward_1,
        rg2_forward_2,
        rg2_forward_3,
        rg2_forward_4,
        rg2_forward_5,
        rg2_forward_6
    );

    mux_forward mux_forward3(
        readdata3,
        to_result[2],
        to_result[3],
        to_result[4],
        to_result[5],
        to_result[6],
        write_data,
        ope3,
        rg3_forward_1,
        rg3_forward_2,
        rg3_forward_3,
        rg3_forward_4,
        rg3_forward_5,
        rg3_forward_6
    );

    fpu_forward_ctrl fpu_forward_ctrl1(
        rs1_buf,
        rs2_buf,
        rs3_buf,
        rdi_buf[1],
        rdi_buf[2], 
        rdi_buf[3], 
        rdi_buf[4],
        rdi_buf[5],
        rdi_buf[6],
        is_legl_buf[1] & reg_write_buf[1],
        is_legl_buf[2] & reg_write_buf[2],
        is_legl_buf[3] & reg_write_buf[3],
        is_legl_buf[4] & reg_write_buf[4],
        is_legl_buf[5] & reg_write_buf[5],
        is_legl_buf[6] & reg_write_buf[6],
        rg1_forward_1,
        rg1_forward_2,
        rg1_forward_3,
        rg1_forward_4,
        rg1_forward_5,
        rg1_forward_6,
        rg2_forward_1,
        rg2_forward_2,
        rg2_forward_3,
        rg2_forward_4,
        rg2_forward_5,
        rg2_forward_6,
        rg3_forward_1,
        rg3_forward_2,
        rg3_forward_3,
        rg3_forward_4,
        rg3_forward_5,
        rg3_forward_6);

    float_to_int float_to_int1(
        clken,
        clk,
        ope1,
        ope2,
        is_cvrt_buf[1],
        is_fcmp_buf[1],
        is_eqal_buf[1],
        is_leth_buf[1],
        to_intreg);

    int_to_float int_to_float1(clken,clk,from_intreg,from_intreg_cvt);
    assign to_mem = ope2;

    fp_addsub fp_addsub1(clken,clk,ope1,ope2,is_sub_buf[0],addsub_out);
    fpu_mult fp_mult1 (clken,clk,ope1,ope2,mul_out);
    fmad_add fmad_add1(
        clken,
        clk,
        mul_out,
        readdata3_buf[3],
        is_FSUB_buf[3],
        is_FNEG_buf[3],
        fmad_out);

    sign_injection sign_injection1(
        ope1,ope2,is_sgnn_buf[0],is_sgnx_buf[0],fsgn_out);

    // 0 is same as register
    // 0~1  itfcvt, control
    assign to_result[1] = is_fsgn_buf[0] ? fsgn_out 
                        : from_intreg;
    assign to_result[2] = result[1];
    assign to_result[3] = is_adsb_buf[2] ? addsub_out
                        : is_cvif_buf[2] ? from_intreg_cvt
                        : result[2];
    assign to_result[4] = is_mult_buf[3] ? mul_out 
                        : is_load_buf[3] ? from_mem_buf_3
                        : result[3];
    assign to_result[5] = result[4];
    assign to_result[6] = is_fmad_buf[5] ? fmad_out
                        : result[5];
    assign write_data   = result[6];

    always @ (posedge clk) begin
        if (clken) begin
            rdi_buf[0] <= inst[11:7];
            rdi_buf[1] <= rdi_buf[0];
            rdi_buf[2] <= rdi_buf[1];
            rdi_buf[3] <= rdi_buf[2];
            rdi_buf[4] <= rdi_buf[3];
            rdi_buf[5] <= rdi_buf[4];
            rdi_buf[6] <= rdi_buf[5];

            rs1_buf <= inst[19:15];
            rs2_buf <= inst[24:20];
            rs3_buf <= inst[31:27];

            from_mem_buf_3 <= from_mem;

            result[1] <= to_result[1];
            result[2] <= to_result[2];
            result[3] <= to_result[3];
            result[4] <= to_result[4];
            result[5] <= to_result[5];
            result[6] <= to_result[6];

            readdata3_buf[1] <= ope3;
            readdata3_buf[2] <= readdata3_buf[1];
            readdata3_buf[3] <= readdata3_buf[2];

            reg_write_buf <= {reg_write_buf[5:0],reg_write};
            is_sub_buf <=  {is_sub_buf[5:0] , is_sub};
            is_load_buf <= {is_load_buf[5:0],is_load};
            is_adsb_buf <= {is_adsb_buf[5:0],is_adsb};
            is_mult_buf <= {is_mult_buf[5:0],is_mult};
            is_cvrt_buf <= {is_cvrt_buf[5:0],is_cvrt};
            is_ftoi_buf <= {is_ftoi_buf[5:0],is_ftoi};
            is_cvif_buf <= {is_cvif_buf[5:0],is_cvif};
            is_legl_buf <= {is_legl_buf[5:0],is_legl};
            is_fcmp_buf <= {is_fcmp_buf[5:0],is_fcmp};
            is_eqal_buf <= {is_eqal_buf[5:0],is_eqal};
            is_leth_buf <= {is_leth_buf[5:0],is_leth};
            is_fsgn_buf <= {is_fsgn_buf[5:0],is_fsgn};
            is_sgnn_buf <= {is_sgnn_buf[5:0],is_sgnn};
            is_sgnx_buf <= {is_sgnx_buf[5:0],is_sgnx};
            is_fmad_buf <= {is_fmad_buf[5:0],is_fmad};
            is_FSUB_buf <= {is_FSUB_buf[5:0],is_FSUB};
            is_FNEG_buf <= {is_FNEG_buf[5:0],is_FNEG};
            is_hazard_0_buf <= {is_hazard_0_buf[5:0],is_hazard_0};
            is_hazard_1_buf <= {is_hazard_1_buf[5:0],is_hazard_1};
            is_hazard_2_buf <= {is_hazard_2_buf[5:0],is_hazard_2};
            is_hazard_3_buf <= {is_hazard_3_buf[5:0],is_hazard_3};
            is_hazard_4_buf <= {is_hazard_4_buf[5:0],is_hazard_4};
        end
    end 
endmodule
