module fpu_control(
    funct5,
    funct3,
    opcode,
    reg_write,
    is_sub,
    is_load,
    is_adsb,
    is_mult,
    is_cvrt,
    is_ftoi,
    is_cvif,
    is_fcmp,
    is_eqal,
    is_leth,
    is_fsgn,
    is_sgnn,
    is_sgnx,
    is_hazard_0,
    is_hazard_1,
    is_hazard_2,
    use_rs1,
    use_rs2);

    input [4:0] funct5;
    input [2:0] funct3;
    input [6:0] opcode;
    output reg_write;
    output is_sub;
    output is_load;
    output is_adsb;
    output is_mult;
    output is_cvrt;
    output is_ftoi;
    output is_cvif;
    output is_fcmp;
    output is_eqal;
    output is_leth;
    output is_fsgn;
    output is_sgnn;
    output is_sgnx;
    output is_hazard_0;
    output is_hazard_1;
    output is_hazard_2;
    output use_rs1;
    output use_rs2;

    parameter OPFP = 7'b1010011;
    parameter LOADFP = 7'b0000111;

    wire is_itof;
    wire is_sqrt;
    wire is_opfp;

    assign is_opfp = (opcode == OPFP);

    assign reg_write = (opcode == LOADFP) | ((opcode == OPFP) & (is_ftoi != 1'b1));
    assign is_sub = (opcode == OPFP) & (funct5 == 5'b00001);
    assign is_load = (opcode ==LOADFP);
    assign is_adsb = is_opfp & (funct5[4:1] == 4'b0000);
    assign is_mult = is_opfp & (funct5 == 5'b00010);
    assign is_cvrt = is_opfp & ((funct5 == 5'b11000) | (funct5 == 5'b11010));
    assign is_ftoi = is_opfp & ((funct5 == 5'b11100) | (funct5 == 5'b11010));
    assign is_itof = is_opfp & ((funct5 == 5'b11000) | (funct5 == 5'b11110));
    assign is_cvif = is_opfp & (funct5 == 5'b11000);
    assign is_fcmp = is_opfp & (funct5 == 5'b10100);
    assign is_fsgn = is_opfp & (funct5 == 5'b00100);
    assign is_leth = is_fcmp & (funct3 == 3'b001);
    assign is_eqal = is_fcmp & (funct3 == 3'b010);
    assign is_sgnn = is_fsgn & (funct3 == 3'b001);
    assign is_sgnx = is_fsgn & (funct3 == 3'b010);
    assign use_rs1 = is_opfp & (~is_itof);
    assign is_sqrt = is_opfp & (funct5 == 5'b01011);
    assign use_rs2 = is_opfp & (~is_ftoi) & (~is_itof); 

    
    assign is_hazard_2 = 1'b0;
    assign is_hazard_1 = is_hazard_2
                       | is_mult
                       | is_load;
    assign is_hazard_0 = is_hazard_1
                       | is_adsb
                       | is_cvif;
endmodule
