module alu_control(funct,alu_opcode,alu_ctrl);
    input [3:0] funct;
    input [1:0] alu_opcode;
    output reg [3:0] alu_ctrl;

    always @ (*) begin
        if (alu_opcode[0] == 1'b0)
            case (funct[2:0])
                0: alu_ctrl <= (alu_opcode[1] & funct[3]) ? 4'd3 : 4'd2;
                4: alu_ctrl <= 4'd4; //xor
                6: alu_ctrl <= 4'd1; //or 
                7: alu_ctrl <= 4'd0; //and
                default: alu_ctrl <= 4'd0;
            endcase
        else
            alu_ctrl <= 4'd2;
    end
endmodule
