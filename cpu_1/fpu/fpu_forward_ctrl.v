module fpu_forward_ctrl(
    rsia,
    rsib,
    rdi_buf_1,
    rdi_buf_2,
    rdi_buf_3,
    rdi_buf_4,
    legal_1,
    legal_2,
    legal_3,
    legal_4,
    rsa_use1,
    rsa_use2,
    rsa_use3,
    rsa_use4,
    rsb_use1,
    rsb_use2,
    rsb_use3,
    rsb_use4);

    input [4:0] rsia;
    input [4:0] rsib;
    input [4:0] rdi_buf_1;
    input [4:0] rdi_buf_2;
    input [4:0] rdi_buf_3;
    input [4:0] rdi_buf_4;
    input       legal_1;
    input       legal_2;
    input       legal_3;
    input       legal_4;
    output rsa_use1;
    output rsa_use2;
    output rsa_use3;
    output rsa_use4;
    output rsb_use1;
    output rsb_use2;
    output rsb_use3;
    output rsb_use4;

    assign rsa_use1 = (rsia == rdi_buf_1) & legal_1;
    assign rsa_use2 = (rsia == rdi_buf_2) & legal_2;
    assign rsa_use3 = (rsia == rdi_buf_3) & legal_3;
    assign rsa_use4 = (rsia == rdi_buf_4) & legal_4;
    assign rsb_use1 = (rsib == rdi_buf_1) & legal_1;
    assign rsb_use2 = (rsib == rdi_buf_2) & legal_2;
    assign rsb_use3 = (rsib == rdi_buf_3) & legal_3;
    assign rsb_use4 = (rsib == rdi_buf_4) & legal_4;

endmodule