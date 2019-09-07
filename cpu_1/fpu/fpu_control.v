module fpu_control(
    funct5,
    funct3,
    opcode,
    reg_write,
    is_sub,
    is_load,
    is_adsb,
    is_mult);

    input [4:0] funct5;
    input [2:0] funct3;
    input [6:0] opcode;
    output reg_write;
    output is_sub;
    output is_load;
    output is_adsb;
    output is_mult;

    parameter OPFP = 7'b1010011;
    parameter LOADFP = 7'b0000111;

    assign reg_write = (opcode == LOADFP) | (opcode == OPFP);
    assign is_sub = (opcode == OPFP) & (funct5 == 5'b00001);
    assign is_load = (opcode ==LOADFP);
    assign is_adsb = (opcode == OPFP) & (funct5[4:1] == 4'b0000);
    assign is_mult = (opcode == OPFP) & (funct5 == 5'b00010);


endmodule
