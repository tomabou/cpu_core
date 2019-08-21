module control(opcode,reg_write,imm_data,opcode_alu,mem_to_reg);
    input [6:0] opcode;
    output reg reg_write;
    output reg imm_data;
    output reg [1:0] opcode_alu;
    output reg mem_to_reg;

    always @(*) begin
        reg_write <= 1'b1;
    end

    always @(*) begin
        case(opcode[6:5]) 
            2'b01: imm_data <= 1'b1;
            default: imm_data <= 1'b0;
        endcase
    end

    always @(*) begin
        case(opcode[4:2])
            3'b100: opcode_alu <= opcode[5] ? 2'b11 : 2'b01;
            default: opcode_alu <= 2'b10;
        endcase
    end

    always @(*) begin
        mem_to_reg <= 1'b0;
    end

endmodule
