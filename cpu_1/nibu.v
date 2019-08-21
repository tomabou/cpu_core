module nibu (clk,show);
    input clk;
    output [9:0] show;

    reg [31:0] pc = 32'b0;
    wire [31:0] inst;
    wire [31:0] write_data;
    wire [31:0] read_data1;
    wire [31:0] read_data2;
    wire [31:0] immediate;
    wire [31:0] operand2;
    wire [31:0] alu_res;
    wire [31:0] memory_read;


    wire reg_write_ctrl;
    wire imm_data_ctrl;
    wire [1:0] opcode_alu_ctrl;
    wire [3:0] alu_ctrl;
    wire mem_to_reg_ctrl;

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
        reg_write_ctrl);

    immgen ig1(clk,inst,immediate);
    control ctr1(
        inst[6:0],
        reg_write_ctrl,
        imm_data_ctrl,
        opcode_alu_ctrl,
        mem_to_reg_ctrl);
    mux mux1(read_data2,immediate,operand2,imm_data_ctrl);
    alu_control ac1({inst[30],inst[14:12]},opcode_alu_ctrl,alu_ctrl);
    alu alu1(read_data1,operand2,alu_res,alu_ctrl);
    data_memory dm1(clk,alu_res,read_data2,memory_read, 1'b0,1'b0);
    mux mux2(memory_read,alu_res,write_data,mem_to_reg_ctrl);


    always @ (posedge clk) begin
        pc <= pc + 32'b100;
    end

endmodule