module nibu (clk,show,segment7_1,segment7_2,segment7_3,segment7_4);
    input clk;
    output [9:0] show;
    output [6:0] segment7_1;
    output [6:0] segment7_2;
    output [6:0] segment7_3;
    output [6:0] segment7_4;

    reg [31:0] show_buf;

    wire [31:0] address;
    reg [31:0] address_buf;
    wire [31:0] next_address;
    wire [31:0] next_address_jump;
    wire [31:0] chosen_next_address;
    reg [31:0] next_address_d1 = 32'b0;
    reg [31:0] next_address_d2 = 32'b0;
    wire [31:0] inst;
    reg [31:0] inst_buf;
    wire [31:0] write_data;
    reg [9:0] rdi_buf;
    wire [31:0] read_data1;
    wire [31:0] read_data2;
    wire [31:0] immediate;
    reg [31:0] immediate_buf;
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
    wire branch_ctrl;
    wire wb_pc_ctrl;
    reg [1:0] wb_pc_ctrl_buf = 2'b0;

    assign show = {show_buf[5:0],4'b0};

    seg7 seg7_1(address[5:2],segment7_1);
    seg7 seg7_2(address[9:6],segment7_2);
    seg7 seg7_3(inst_buf[3:0],segment7_3);
    seg7 seg7_4(inst_buf[7:4],segment7_4);


    pc pc1(clk,chosen_next_address,address);
    add add1(address,32'b100,next_address);
    add add_jump(address_buf,immediate,next_address_jump);//imm is delay 1clk;
    mux mux_pc(next_address,next_address_jump,chosen_next_address,branch_ctrl);
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

    immgen ig1(inst,immediate);
    control ctr1(
        inst[6:0],
        reg_write_ctrl,
        imm_data_ctrl,
        opcode_alu_ctrl,
        mem_to_reg_ctrl,
        branch_ctrl,
        wb_pc_ctrl);
    mux mux1(read_data2,immediate_buf,operand2,imm_data_ctrl_buf);
    alu_control ac1({inst[30],inst[14:12]},opcode_alu_ctrl,alu_ctrl);
    alu alu1(read_data1,operand2,alu_res,alu_ctrl_buf);
    data_memory dm1(clk,alu_res,read_data2,memory_read, 1'b0,1'b0);

    wire [31:0] mux2_to_wrbpc;
    mux mux2(alu_res_buf,memory_read,mux2_to_wrbpc,mem_to_reg_ctrl_buf[1]);
    mux mux_wrbpc(mux2_to_wrbpc,next_address_d2,write_data,wb_pc_ctrl_buf[1]);


    always @ (posedge clk) begin
        next_address_d1 <= next_address;
        next_address_d2 <= next_address_d1;
        address_buf <= address;
        immediate_buf <= immediate;
        imm_data_ctrl_buf <= imm_data_ctrl;
        alu_ctrl_buf <= alu_ctrl;
        mem_to_reg_ctrl_buf<= {mem_to_reg_ctrl_buf[0],mem_to_reg_ctrl};
        reg_write_ctrl_buf <= {reg_write_ctrl_buf[0],reg_write_ctrl};
        wb_pc_ctrl_buf <= {wb_pc_ctrl_buf[0],wb_pc_ctrl};
        alu_res_buf <= alu_res;
        rdi_buf <= {rdi_buf[4:0],inst[11:7]};
        inst_buf <= inst;
        show_buf <= alu_res;
    end
endmodule