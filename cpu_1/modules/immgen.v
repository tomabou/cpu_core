module immgen(inst,imm);
    input [31:0] inst;
    output reg [31:0] imm = 32'b0;

    always @ (*) begin
        case(inst[6:2])
            5'b00100: imm <= {{21{inst[31]}},inst[30:20]}; //op_imm
            5'b11011: imm <= {{12{inst[31]}},inst[19:12],inst[20],inst[30:21],1'b0};//JAL
            default: imm <= 32'b0;
        endcase
    end
    
endmodule