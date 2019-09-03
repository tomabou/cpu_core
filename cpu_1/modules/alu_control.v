module alu_control(funct,alu_opcode,alu_ctrl);
    input [3:0] funct;
    input [1:0] alu_opcode;
    output reg [3:0] alu_ctrl;

    always @ (*) begin
        if (alu_opcode[0] == 1'b1)
            case (funct[2:0])
                0: alu_ctrl <= (alu_opcode[1] & funct[3]) ? 4'd3 : 4'd2;
                1: alu_ctrl <= 4'd11; //shift left
                4: alu_ctrl <= 4'd4; //xor
                5: alu_ctrl <= funct[3] ? 4'd13 : 4'd12;// shift right
                6: alu_ctrl <= 4'd1; //or 
                7: alu_ctrl <= 4'd0; //and
                default: alu_ctrl <= 4'd0;
            endcase
        else if (alu_opcode == 2'b00)
            case (funct[2:0])
                0: alu_ctrl <= 4'd5;
                1: alu_ctrl <= 4'd6;
                4: alu_ctrl <= 4'd7;
                5: alu_ctrl <= 4'd8;
                6: alu_ctrl <= 4'd9;
                7: alu_ctrl <= 4'd10;
                default: alu_ctrl <= 4'd5;
            endcase
        else
            alu_ctrl <= 4'd2;
    end
endmodule
