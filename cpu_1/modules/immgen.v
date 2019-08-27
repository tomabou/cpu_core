module immgen(inst,imm);
    input [31:0] inst;
    output reg [31:0] imm = 32'b0;

    always @ (*) begin
        case(inst[6:2])
            5'b00100: imm <= {{21{inst[31]}},inst[30:20]}; //op_imm
            5'b11001: imm <= {{21{inst[31]}},inst[30:20]}; //jalr
            5'b00000: imm <= {{21{inst[31]}},inst[30:20]}; //load
            5'b01000: imm <= {{21{inst[31]}},inst[30:25],inst[11:7]};//store
            5'b11011: imm <= {{12{inst[31]}},inst[19:12],inst[20],inst[30:21],1'b0};//JAL
            5'b11000: imm <= {{20{inst[31]}},inst[7],inst[30:25],inst[11:8],1'b0};//BRANCH
            default: imm <= 32'b0;
        endcase
    end
    
endmodule