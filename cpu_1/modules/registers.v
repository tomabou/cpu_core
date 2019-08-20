module registers(clk,rs1i,rs2i,rdi,write_data,read_data1,read_data2,reg_write);
    input clk;
    input [4:0] rs1i;
    input [4:0] rs2i;
    input [4:0] rdi;
    input [31:0] write_data;
    input reg_write;
    output read_data1;
    output read_data2;

    reg [31:0] regs [0:31];
    reg [31:0] read_data1;
    reg [31:0] read_data2;


    always @(posedge clk) begin
        read_data1 <= regs[rs1i];
        read_data2 <= regs[rs2i];
        if (reg_write == 1'b1) 
            regs[rdi] <= write_data;
    end
endmodule