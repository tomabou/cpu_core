module control(opcode,reg_write,imm_data,opcode_alu,mem_to_reg,branch,wb_pc,cond_b,store,jalr);
    input [6:0] opcode;
    output reg reg_write;
    output reg imm_data;
    output reg [1:0] opcode_alu;
    output mem_to_reg;
    output reg branch;
    output reg wb_pc;
    output cond_b;
    output store;
    output jalr;

    assign cond_b = (opcode == 7'b1100011); 
    assign store = (opcode == 7'b0100011);
    assign mem_to_reg = (opcode == 7'b0000011);//load
    assign jalr = (opcode == 7'b1100111);

    always @(*) begin
        case(opcode[6:2])
            5'b00100: reg_write <= 1'b1;//op_imm
            5'b01100: reg_write <= 1'b1;//op
            5'b11011: reg_write <= 1'b1;//JAL
            5'b11001: reg_write <= 1'b1;//JALR
            5'b00000: reg_write <= 1'b1;//LOAD
            default: reg_write <= 1'b0;
        endcase
    end

    //jal use immediate directly.
    always @(*) begin
        case(opcode[6:2]) 
            5'b00100: imm_data <= 1'b1;//opimm
            5'b00000: imm_data <= 1'b1;//load
            5'b01000: imm_data <= 1'b1;//store
            5'b11001: imm_data <= 1'b1;//jalr
            5'b01100: imm_data <= 1'b0;//op
            default: imm_data <= 1'b0;
        endcase
    end

    // 2'b10 always alu add
    always @(*) begin
        case(opcode[6:2])
            5'b00100: opcode_alu <= 2'b01;
            5'b01100: opcode_alu <= 2'b11;
            5'b11000: opcode_alu <= 2'b00; //BRANCH
            5'b11001: opcode_alu <= 2'b10; //jalr
            default: opcode_alu <= 2'b10;
        endcase
    end


    always @(*) begin
        case(opcode[6:2])
            5'b11011: {branch,wb_pc} <= 2'b11;
            5'b11001: {branch,wb_pc} <= 2'b11;
            5'b11000: {branch,wb_pc} <= 2'b10;
            default: {branch,wb_pc} <= 2'b00;
        endcase
    end


endmodule
