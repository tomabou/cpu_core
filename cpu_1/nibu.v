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
    wire [31:0] read_data1_fetched;
    wire [31:0] read_data2_fetched;
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
    wire [31:0] from_intreg;
    wire [31:0] from_mem;
    wire [31:0] into_mem;
    wire [31:0] into_intreg;
    wire [31:0] memory_write;
    wire enable_ftoi;


    wire is_regwrite;
    wire is_use_imme;
    wire is_memtoreg;
    wire is_pc_toreg;
    wire is_branchop;
    wire is_cond_bra;
    wire is_fstoreop;

    reg [2:0] is_regwrite_buf = 3'b0;
    reg [2:0] is_use_imme_buf = 3'b0;
    reg [2:0] is_memtoreg_buf = 3'b0;
    reg [2:0] is_pc_toreg_buf = 3'b0;
    reg [2:0] is_branchop_buf = 3'b0;
    reg [2:0] is_cond_bra_buf = 3'b0;
    reg [2:0] is_fstoreop_buf = 3'b0;


    wire reg_write;
    wire [1:0] opcode_alu_ctrl;
    wire [3:0] alu_ctrl;
    reg [3:0] alu_ctrl_buf = 4'b0;
    wire do_branch;
    reg [2:0] do_branch_buf = 3'b0;
    wire mem_write_ctrl;
    reg mem_write_ctrl_buf = 1'b0;
    wire jalr_ctrl;
    reg jalr_ctrl_buf = 1'b0;
    wire [1:0] ope1_ctrl;
    reg [1:0] ope1_ctrl_buf = 2'b0;
    wire rg1_forward;
    wire rg2_forward;

    assign show = {show_buf[5:0],4'b0};

    assign do_branch = is_branchop_buf[0] & (~do_branch_buf[0]) & (~do_branch_buf[1])& ((~is_cond_bra_buf[0])|alu_res[0]);

    seg7 seg7_1(address[5:2],segment7_1);
    seg7 seg7_2(address[9:6],segment7_2);
    seg7 seg7_3(seg_io[3:0],segment7_3);
    seg7 seg7_4(seg_io[7:4],segment7_4);
    seg7 seg7_5(seg_io[11:8],segment7_5);
    seg7 seg7_6(seg_io[15:12],segment7_6);

    FPU FPU1(clk,inst,from_intreg,from_mem,into_mem,into_intreg,enable_ftoi);
    assign from_intreg = read_data1;
    assign from_mem = memory_read;
    mux mux_memwrite(read_data2,into_mem,memory_write,is_fstoreop_buf[0]);

    pc pc1(clk,chosen_next_address,address);
    add add1(address,32'b100,next_address);
    add add_jump(address_buf2,immediate_buf,next_address_immjump);//imm_buff is delay 2clk;
    mux mux_jalr(next_address_immjump,alu_res,next_address_jump,jalr_ctrl_buf);
    mux mux_pc(next_address,next_address_jump,chosen_next_address,do_branch);

    assign reg_write = (enable_ftoi|is_regwrite_buf[1])&(~do_branch_buf[1])&(~do_branch_buf[2]);

    registers regs1(
        clk,
        inst[19:15],
        inst[24:20],
        rdi_buf[9:5],
        write_data,
        read_data1_fetched,
        read_data2_fetched,
        reg_write);

    forward_ctrl forward_ctrl1(
        rsi1_buf,
        rsi2_buf,
        rdi_buf[9:5],
        reg_write,
        rg1_forward,
        rg2_forward);

    mux_reg mux_readdata1(
        read_data1_fetched,
        write_data,
        read_data1,
        rg1_forward,
        (rsi1_buf == 5'b0)
    );
    mux_reg mux_readdata2(
        read_data2_fetched,
        write_data,
        read_data2,
        rg2_forward,
        (rsi2_buf == 5'b0)
    );
    

    immgen ig1(inst,immediate);
    control ctr1(
        inst[6:0],
        is_regwrite,
        is_use_imme,
        opcode_alu_ctrl,
        is_memtoreg,
        is_branchop,
        is_pc_toreg,
        is_cond_bra,
        mem_write_ctrl,
        jalr_ctrl,
        ope1_ctrl,
        is_fstoreop);
    mod_readdata mod_readdata1(read_data1,address_buf2,ope1_ctrl_buf,operand1);
    mux mux1(read_data2,immediate_buf,operand2,is_use_imme_buf[0]);
    alu_control ac1({inst[30],inst[14:12]},opcode_alu_ctrl,alu_ctrl);
    alu alu1(operand1,operand2,alu_res,alu_ctrl_buf);

    memory mem1(clk,
        address,inst,
        alu_res,memory_write,memory_read, 
        mem_write_ctrl_buf & (~do_branch_buf[0]) & (~do_branch_buf[1]),
        is_memtoreg_buf[0] & (~do_branch_buf[0]) & (~do_branch_buf[1]),//readctrl
        uart_empty,
        uart_in,
        uart_out,
        uart_wrreq,
        uart_rdreq,
        seg_io);

    wire [31:0] mux2_to_wrbpc;
    wire [31:0] to_alubuf;

    mux_writedata mux_writedata1(
        alu_res_buf,
        next_address_d3,
        into_intreg,
        memory_read,
        is_pc_toreg_buf[1],
        enable_ftoi,
        is_memtoreg_buf[1],
        write_data);

    always @ (posedge clk) begin
        next_address_d1 <= next_address;
        next_address_d2 <= next_address_d1;
        next_address_d3 <= next_address_d2;
        address_buf <= address;
        address_buf2 <= address_buf;
        immediate_buf <= immediate;
        rsi1_buf <= inst[19:15];
        rsi2_buf <= inst[24:20];
        alu_ctrl_buf <= alu_ctrl;
        do_branch_buf <= {do_branch_buf[1:0],do_branch};
        mem_write_ctrl_buf <= mem_write_ctrl;
        jalr_ctrl_buf <= jalr_ctrl;
        ope1_ctrl_buf <= ope1_ctrl;
        alu_res_buf <= alu_res;
        rdi_buf <= {rdi_buf[4:0],inst[11:7]};
        show_buf <= alu_res;

        is_regwrite_buf <= {is_regwrite_buf[1:0],is_regwrite};
        is_use_imme_buf <= {is_use_imme_buf[1:0],is_use_imme};
        is_memtoreg_buf <= {is_memtoreg_buf[1:0],is_memtoreg};
        is_pc_toreg_buf <= {is_pc_toreg_buf[1:0],is_pc_toreg};
        is_branchop_buf <= {is_branchop_buf[1:0],is_branchop};
        is_cond_bra_buf <= {is_cond_bra_buf[1:0],is_cond_bra};
        is_fstoreop_buf <= {is_fstoreop_buf[1:0],is_fstoreop};
    end
endmodule