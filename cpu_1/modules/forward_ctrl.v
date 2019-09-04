module forward_ctrl (
    rsi1,
    rsi2,
    mem_wb_di,
    write_ctrl,
    rs1_ctrl,
    rs2_ctrl);

    input [4:0] rsi1;
    input [4:0] rsi2;
    input [4:0] mem_wb_di;
    input write_ctrl;
    output rs1_ctrl;
    output rs2_ctrl;

    assign rs1_ctrl = (rsi1 == mem_wb_di) & write_ctrl;
    assign rs2_ctrl = (rsi2 == mem_wb_di) & write_ctrl;

endmodule
