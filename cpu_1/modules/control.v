module control(opcode,reg_write,imm_data,opcode_alu,mem_to_reg,branch,wb_pc);
    input [6:0] opcode;
    output reg reg_write;
    output reg imm_data;
    output reg [1:0] opcode_alu;
    output reg mem_to_reg;
    output reg branch;
    output reg wb_pc;

    always @(*) begin
        case(opcode[6:2])
            5'b00100: reg_write <= 1'b1;//op_imm
            5'b01100: reg_write <= 1'b1;//op
            5'b11011: reg_write <= 1'b1;//JAL
            default: reg_write <= 1'b0;
        endcase
    end

    always @(*) begin
        case(opcode[6:2]) 
            5'b00100: imm_data <= 1'b1;
            5'b01100: imm_data <= 1'b0;
            default: imm_data <= 1'b0;
        endcase
    end

    always @(*) begin
        case(opcode[6:2])
            5'b00100: opcode_alu <= 2'b01;
            5'b01100: opcode_alu <= 2'b11;
            default: opcode_alu <= 2'b10;
        endcase
    end

    always @(*) begin
        case(opcode[6:2])
            default: mem_to_reg <= 1'b0;
        endcase
    end

    always @(*) begin
        case(opcode[6:2])
            5'b11011: {branch,wb_pc} <= 2'b11;
            5'b11000: {branch,wb_pc} <= 2'b10;
            default: {branch,wb_pc} <= 2'b00;
        endcase
    end

endmodule
