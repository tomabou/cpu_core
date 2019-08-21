module alu_control(funct,alu_opcode,alu_ctrl);
    input [3:0] funct;
    input [1:0] alu_opcode;
    output reg [3:0] alu_ctrl;

    always @ (*) begin
        case (funct[2:0])
            0: alu_ctrl <= (alu_opcode[1] & funct[3]) ? 4'd3 : 4'd2;
            7: alu_ctrl <= 4'd0;
            default: alu_ctrl <= 4'd0;
        endcase
    end
endmodule
