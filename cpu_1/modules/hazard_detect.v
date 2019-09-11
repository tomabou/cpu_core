module hazard_detect (
    rs1i,
    rs2i,
    use_rs1,
    use_rs2,
    is_regwrite_0,
    is_legal_0,
    is_hazard_0,
    rdi_0,
    hazard);

    input [4:0] rs1i;
    input [4:0] rs2i;
    input use_rs1;
    input use_rs2;
    input is_regwrite_0;
    input is_legal_0;
    input is_hazard_0;
    input [4:0] rdi_0;
    output hazard;

    assign hazard = (((rs1i == rdi_0) | use_rs1) 
                    |((rs2i == rdi_0) | use_rs2))
                  & is_regwrite_0
                  & is_legal_0
                  & is_hazard_0;
endmodule
