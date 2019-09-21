module fpu_forward_ctrl(
    rsia,
    rsib,
    rsic,
    rdi_buf_1,
    rdi_buf_2,
    rdi_buf_3,
    rdi_buf_4,
    rdi_buf_5,
    rdi_buf_6,
    legal_1,
    legal_2,
    legal_3,
    legal_4,
    legal_5,
    legal_6,
    rsa_use1,
    rsa_use2,
    rsa_use3,
    rsa_use4,
    rsa_use5,
    rsa_use6,
    rsb_use1,
    rsb_use2,
    rsb_use3,
    rsb_use4,
    rsb_use5,
    rsb_use6,
    rsc_use1,
    rsc_use2,
    rsc_use3,
    rsc_use4,
    rsc_use5,
    rsc_use6
    );

    input [4:0] rsia;
    input [4:0] rsib;
    input [4:0] rsic;
    input [4:0] rdi_buf_1;
    input [4:0] rdi_buf_2;
    input [4:0] rdi_buf_3;
    input [4:0] rdi_buf_4;
    input [4:0] rdi_buf_5;
    input [4:0] rdi_buf_6;
    input       legal_1;
    input       legal_2;
    input       legal_3;
    input       legal_4;
    input       legal_5;
    input       legal_6;
    output rsa_use1;
    output rsa_use2;
    output rsa_use3;
    output rsa_use4;
    output rsa_use5;
    output rsa_use6;
    output rsb_use1;
    output rsb_use2;
    output rsb_use3;
    output rsb_use4;
    output rsb_use5;
    output rsb_use6;
    output rsc_use1;
    output rsc_use2;
    output rsc_use3;
    output rsc_use4;
    output rsc_use5;
    output rsc_use6;

    assign rsa_use1 = (rsia == rdi_buf_1) & legal_1;
    assign rsa_use2 = (rsia == rdi_buf_2) & legal_2;
    assign rsa_use3 = (rsia == rdi_buf_3) & legal_3;
    assign rsa_use4 = (rsia == rdi_buf_4) & legal_4;
    assign rsa_use5 = (rsia == rdi_buf_5) & legal_5;
    assign rsa_use6 = (rsia == rdi_buf_6) & legal_6;
    assign rsb_use1 = (rsib == rdi_buf_1) & legal_1;
    assign rsb_use2 = (rsib == rdi_buf_2) & legal_2;
    assign rsb_use3 = (rsib == rdi_buf_3) & legal_3;
    assign rsb_use4 = (rsib == rdi_buf_4) & legal_4;
    assign rsb_use5 = (rsib == rdi_buf_5) & legal_5;
    assign rsb_use6 = (rsib == rdi_buf_6) & legal_6;
    assign rsc_use1 = (rsic == rdi_buf_1) & legal_1;
    assign rsc_use2 = (rsic == rdi_buf_2) & legal_2;
    assign rsc_use3 = (rsic == rdi_buf_3) & legal_3;
    assign rsc_use4 = (rsic == rdi_buf_4) & legal_4;
    assign rsc_use5 = (rsic == rdi_buf_5) & legal_5;
    assign rsc_use6 = (rsic == rdi_buf_6) & legal_6;

endmodule