module nibu (clk,show);
    input clk;
    output [9:0] show;

    reg [31:0] pc = 32'b0;
    wire [31:0] inst;
    wire [31:0] write_data;
    wire [31:0] read_data1;
    wire [31:0] read_data2;


    wire reg_write_ctl;

    assign show = inst[9:0];

    inst_memory im1(clk,pc,inst);
    registers regs1(
        clk,
        inst[19:15],
        inst[24:20],
        inst[11:7],
        write_data,
        read_data1,
        read_data2,
        reg_write_ctl);

    always @ (posedge clk) begin
        pc <= pc + 32'b100;
    end

endmodule