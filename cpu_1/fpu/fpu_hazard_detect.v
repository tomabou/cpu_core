module fpu_hazard_detect(
    rs1i,
    rs2i,
    use_rs1,
    use_rs2,
    is_regwrite_0,
    is_regwrite_1,
    is_regwrite_2,
    is_legal_0,
    is_legal_1,
    is_legal_2,
    is_hazard_0,
    is_hazard_1,
    is_hazard_2,
    rdi_0,
    rdi_1,
    rdi_2,
    hazard
);
    input [4:0] rs1i;
    input [4:0] rs2i;
    input use_rs1;
    input use_rs2;
    input is_regwrite_0;
    input is_regwrite_1;
    input is_regwrite_2;
    input is_legal_0;
    input is_legal_1;
    input is_legal_2;
    input is_hazard_0;
    input is_hazard_1;
    input is_hazard_2;
    input rdi_0;
    input rdi_1;
    input rdi_2;
    output hazard;

    wire hazard0;
    wire hazard1;
    wire hazard2;
    

    assign hazard = hazard0 | hazard1 | hazard2;


    assign hazard0 = (((rs1i == rdi_0) | use_rs1) 
                    |((rs2i == rdi_0) | use_rs2))
                  & is_regwrite_0
                  & is_legal_0
                  & is_hazard_0;
    assign hazard1 = (((rs1i == rdi_1) | use_rs1) 
                    |((rs2i == rdi_1) | use_rs2))
                  & is_regwrite_1
                  & is_legal_1
                  & is_hazard_1;
    assign hazard2 = (((rs1i == rdi_2) | use_rs1) 
                    |((rs2i == rdi_2) | use_rs2))
                  & is_regwrite_2
                  & is_legal_2
                  & is_hazard_2;

endmodule