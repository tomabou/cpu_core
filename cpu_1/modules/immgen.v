module immgen(clk,inst,imm);
    input clk;
    input [31:0] inst;
    output imm;

    reg [31:0] imm = 32'b0;

    wire itype;
    assign itype = inst[4:2] == 3'b100;
    always @ (posedge clk) begin
        if (itype)
            imm <= {{21{inst[31]}},inst[30:20]};
    end
    
endmodule