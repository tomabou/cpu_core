module nibu (
    clk,
    show,
    segment7_1,
    segment7_2,
    segment7_3,
    segment7_4,
    segment7_5,
    segment7_6,
    uart_empty,
    uart_in,
    uart_out,
    uart_rdreq,
    uart_wrreq);

    input clk;
    output [9:0] show;
    output [6:0] segment7_1;
    output [6:0] segment7_2;
    output [6:0] segment7_3;
    output [6:0] segment7_4;
    output [6:0] segment7_5;
    output [6:0] segment7_6;
    input uart_empty;
    input [7:0] uart_in;
    output [7:0] uart_out;
    output uart_wrreq;
    output uart_rdreq;

    reg [31:0] show_buf;

    wire [31:0] address;
    reg [31:0] address_buf = 32'b0;
    reg [31:0] address_buf2 = 32'b0;
    wire [31:0] next_address;
    wire [31:0] next_address_immjump;
    wire [31:0] next_address_jump;
    wire [31:0] chosen_next_address;
    reg [31:0] next_address_d1 = 32'b0;
    reg [31:0] next_address_d2 = 32'b0;
    reg [31:0] next_address_d3 = 32'b0;
    wire [31:0] inst;
    wire [31:0] write_data;
    reg [9:0] rdi_buf;
    wire [31:0] read_data1;
    wire [31:0] read_data2;
    reg [4:0] rsi1_buf;
    reg [4:0] rsi2_buf;
    wire [31:0] immediate;
    reg [31:0] immediate_buf;
    wire [31:0] operand1;
    wire [31:0] operand2;
    wire [31:0] alu_res;
    reg [31:0] alu_res_buf;
    wire [31:0] memory_read;
    wire [15:0] seg_io;



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
    reg branch_ctrl_buf =1'b0;
    wire do_branch;
    reg [2:0] do_branch_buf = 3'b0;
    wire wb_pc_ctrl;
    reg [1:0] wb_pc_ctrl_buf = 2'b0;
    wire is_cond_b;
    reg is_cond_b_buf = 1'b0;
    wire mem_write_ctrl;
    reg mem_write_ctrl_buf = 1'b0;
    wire jalr_ctrl;
    reg jalr_ctrl_buf = 1'b0;
    wire [1:0] ope1_ctrl;
    reg [1:0] ope1_ctrl_buf = 2'b0;

    assign show = {show_buf[5:0],4'b0};

    assign do_branch = branch_ctrl_buf & (~do_branch_buf[0]) & (~do_branch_buf[1])& ((~is_cond_b_buf)|alu_res[0]);

    seg7 seg7_1(address[5:2],segment7_1);
    seg7 seg7_2(address[9:6],segment7_2);
    seg7 seg7_3(seg_io[3:0],segment7_3);
    seg7 seg7_4(seg_io[7:4],segment7_4);
    seg7 seg7_5(seg_io[11:8],segment7_5);
    seg7 seg7_6(seg_io[15:12],segment7_6);


    pc pc1(clk,chosen_next_address,address);
    add add1(address,32'b100,next_address);
    add add_jump(address_buf2,immediate_buf,next_address_immjump);//imm_buff is delay 2clk;
    mux mux_jalr(next_address_immjump,alu_res,next_address_jump,jalr_ctrl_buf);
    mux mux_pc(next_address,next_address_jump,chosen_next_address,do_branch);
    registers regs1(
        clk,
        inst[19:15],
        inst[24:20],
        rdi_buf[9:5],
        write_data,
        read_data1,
        read_data2,
        reg_write_ctrl_buf[1]&(~do_branch_buf[1]) & (~do_branch_buf[2]));

    immgen ig1(inst,immediate);
    control ctr1(
        inst[6:0],
        reg_write_ctrl,
        imm_data_ctrl,
        opcode_alu_ctrl,
        mem_to_reg_ctrl,
        branch_ctrl,
        wb_pc_ctrl,
        is_cond_b,
        mem_write_ctrl,
        jalr_ctrl,
        ope1_ctrl);
    mod_readdata mod_readdata1(read_data1,address_buf2,ope1_ctrl_buf,operand1);
    mux mux1(read_data2,immediate_buf,operand2,imm_data_ctrl_buf);
    alu_control ac1({inst[30],inst[14:12]},opcode_alu_ctrl,alu_ctrl);
    alu alu1(operand1,operand2,alu_res,alu_ctrl_buf);
    memory mem1(clk,
        address,inst,
        alu_res,read_data2,memory_read, 
        mem_write_ctrl_buf & (~do_branch_buf[0]) & (~do_branch_buf[1]),
        mem_to_reg_ctrl_buf[0] & (~do_branch_buf[0]) & (~do_branch_buf[1]),
        uart_empty,
        uart_in,
        uart_out,
        uart_wrreq,
        uart_rdreq,
        seg_io);

    wire [31:0] mux2_to_wrbpc;
    mux mux2(alu_res_buf,memory_read,mux2_to_wrbpc,mem_to_reg_ctrl_buf[1]);
    mux mux_wrbpc(mux2_to_wrbpc,next_address_d3,write_data,wb_pc_ctrl_buf[1]);


    always @ (posedge clk) begin
        next_address_d1 <= next_address;
        next_address_d2 <= next_address_d1;
        next_address_d3 <= next_address_d2;
        address_buf <= address;
        address_buf2 <= address_buf;
        immediate_buf <= immediate;
        rsi1_buf <= inst[19:15];
        rsi2_buf <= inst[24:20];
        imm_data_ctrl_buf <= imm_data_ctrl;
        alu_ctrl_buf <= alu_ctrl;
        mem_to_reg_ctrl_buf<= {mem_to_reg_ctrl_buf[0],mem_to_reg_ctrl};
        reg_write_ctrl_buf <= {reg_write_ctrl_buf[0],reg_write_ctrl};
        branch_ctrl_buf <= branch_ctrl;
        do_branch_buf <= {do_branch_buf[1:0],do_branch};
        wb_pc_ctrl_buf <= {wb_pc_ctrl_buf[0],wb_pc_ctrl};
        mem_write_ctrl_buf <= mem_write_ctrl;
        jalr_ctrl_buf <= jalr_ctrl;
        ope1_ctrl_buf <= ope1_ctrl;
        is_cond_b_buf <= is_cond_b;
        alu_res_buf <= alu_res;
        rdi_buf <= {rdi_buf[4:0],inst[11:7]};
        show_buf <= alu_res;
    end
endmodule