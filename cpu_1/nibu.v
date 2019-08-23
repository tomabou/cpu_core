module nibu (clk,show,segment7_1,segment7_2,segment7_3,segment7_4);
    input clk;
    output [9:0] show;
    output [6:0] segment7_1;
    output [6:0] segment7_2;
    output [6:0] segment7_3;
    output [6:0] segment7_4;

    reg [31:0] show_buf;

    wire [31:0] address;
    wire [31:0] next_address;
    wire [31:0] inst;
    reg [31:0] inst_buf;
    wire [31:0] write_data;
    reg [9:0] rdi_buf;
    wire [31:0] read_data1;
    wire [31:0] read_data2;
    wire [31:0] immediate;
    wire [31:0] operand2;
    wire [31:0] alu_res;
    reg [31:0] alu_res_buf;
    wire [31:0] memory_read;



    wire reg_write_ctrl;
    reg [1:0] reg_write_ctrl_buf = 2'b0;
    wire imm_data_ctrl;
    reg imm_data_ctrl_buf = 1'b0;
    wire [1:0] opcode_alu_ctrl;
    wire [3:0] alu_ctrl;
    reg [3:0] alu_ctrl_buf = 4'b0;
    wire mem_to_reg_ctrl;
    reg [1:0] mem_to_reg_ctrl_buf = 2'b0 ;

    assign show = {show_buf[5:0],4'b0};

    seg7 seg7_1(address[5:2],segment7_1);
    seg7 seg7_2(address[9:6],segment7_2);
    seg7 seg7_3(inst_buf[3:0],segment7_3);
    seg7 seg7_4(inst_buf[7:4],segment7_4);


    pc pc1(clk,next_address,address);
    add add1(address,32'b100,next_address);
    inst_memory im1(clk,address,inst);
    registers regs1(
        clk,
        inst[19:15],
        inst[24:20],
        rdi_buf[9:5],
        write_data,
        read_data1,
        read_data2,
        reg_write_ctrl_buf[1]);

    immgen ig1(clk,inst,immediate);
    control ctr1(
        inst[6:0],
        reg_write_ctrl,
        imm_data_ctrl,
        opcode_alu_ctrl,
        mem_to_reg_ctrl);
    mux mux1(read_data2,immediate,operand2,imm_data_ctrl_buf);
    alu_control ac1({inst[30],inst[14:12]},opcode_alu_ctrl,alu_ctrl);
    alu alu1(read_data1,operand2,alu_res,alu_ctrl_buf);
    data_memory dm1(clk,alu_res,read_data2,memory_read, 1'b0,1'b0);
    mux mux2(alu_res_buf,memory_read,write_data,mem_to_reg_ctrl_buf[1]);


    always @ (posedge clk) begin
        imm_data_ctrl_buf <= imm_data_ctrl;
        alu_ctrl_buf <= alu_ctrl;
        mem_to_reg_ctrl_buf<= {mem_to_reg_ctrl_buf[0],mem_to_reg_ctrl};
        reg_write_ctrl_buf <= {reg_write_ctrl_buf[0],reg_write_ctrl};
        alu_res_buf <= alu_res;
        rdi_buf <= {rdi_buf[4:0],inst[11:7]};
        inst_buf <= inst;
        show_buf <= alu_res;
    end
endmodule