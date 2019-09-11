module forward_ctrl (
    rsia,
    rsib,
    rdi_buf_1,
    legal_1,
    rdi_buf_2,
    legal_2,
    rsa_use1,
    rsa_use2,
    rsb_use1,
    rsb_use2);

    input [4:0] rsa1;
    input [4:0] rsa2;
    input [4:0] rdi_buf_1;
    input legal_1;
    input [4:0] rdi_buf_2;
    input legal_2;
    output rsa_use1;
    output rsa_use2;
    output rsb_use1;
    output rsb_use2;

    assign rsa_use1 = (rsia == rdi_buf_1) & legal_1;
    assign rsa_use1 = (rsia == rdi_buf_2) & legal_2 & (~rsa_use1);

    assign rsb_use1 = (rsib == rdi_buf_1) & legal_1;
    assign rsb_use1 = (rsib == rdi_buf_2) & legal_2 & (~rsb_use1);


endmodule
