module fpu_hazard_detect(
    rs1i,
    rs2i,
    rs3i,
    use_rs1,
    use_rs2,
    use_rs3,
    is_regwrite_0,
    is_regwrite_1,
    is_regwrite_2,
    is_regwrite_3,
    is_regwrite_4,
    is_legal_0,
    is_legal_1,
    is_legal_2,
    is_legal_3,
    is_legal_4,
    is_hazard_0,
    is_hazard_1,
    is_hazard_2,
    is_hazard_3,
    is_hazard_4,
    rdi_0,
    rdi_1,
    rdi_2,
    rdi_3,
    rdi_4,
    hazard
);
    input [4:0] rs1i;
    input [4:0] rs2i;
    input [4:0] rs3i;
    input use_rs1;
    input use_rs2;
    input use_rs3;
    input is_regwrite_0;
    input is_regwrite_1;
    input is_regwrite_2;
    input is_regwrite_3;
    input is_regwrite_4;
    input is_legal_0;
    input is_legal_1;
    input is_legal_2;
    input is_legal_3;
    input is_legal_4;
    input is_hazard_0;
    input is_hazard_1;
    input is_hazard_2;
    input is_hazard_3;
    input is_hazard_4;
    input [4:0] rdi_0;
    input [4:0] rdi_1;
    input [4:0] rdi_2;
    input [4:0] rdi_3;
    input [4:0] rdi_4;
    output hazard;

    wire hazard0;
    wire hazard1;
    wire hazard2;
    wire hazard3;
    wire hazard4;
    

    assign hazard = hazard0 | hazard1 | hazard2 | hazard3 | hazard4;


    assign hazard0 = (((rs1i == rdi_0) & use_rs1) 
                    |((rs2i == rdi_0) & use_rs2)
                    |((rs3i == rdi_0) & use_rs3))
                  & is_regwrite_0
                  & is_legal_0
                  & is_hazard_0;
    assign hazard1 = (((rs1i == rdi_1) & use_rs1) 
                    |((rs2i == rdi_1) & use_rs2)
                    |((rs3i == rdi_1) & use_rs3))
                  & is_regwrite_1
                  & is_legal_1
                  & is_hazard_1;
    assign hazard2 = (((rs1i == rdi_2) & use_rs1) 
                    |((rs2i == rdi_2) & use_rs2)
                    |((rs3i == rdi_2) & use_rs3))
                  & is_regwrite_2
                  & is_legal_2
                  & is_hazard_2;
    assign hazard3 = (((rs1i == rdi_3) & use_rs1) 
                    |((rs2i == rdi_3) & use_rs2)
                    |((rs3i == rdi_3) & use_rs3))
                  & is_regwrite_3
                  & is_legal_3
                  & is_hazard_3;
    assign hazard4 = (((rs1i == rdi_4) & use_rs1) 
                    |((rs2i == rdi_4) & use_rs2)
                    |((rs3i == rdi_4) & use_rs3))
                  & is_regwrite_4
                  & is_legal_4
                  & is_hazard_4;

endmodule