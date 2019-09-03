module registers(clk,rs1i,rs2i,rdi,write_data,read_data1,read_data2,reg_write);
    input clk;
    input [4:0] rs1i;
    input [4:0] rs2i;
    input [4:0] rdi;
    input [31:0] write_data;
    input reg_write;
    output reg [31:0] read_data1;
    output reg [31:0] read_data2;

    reg [31:0] regs [0:31];


    always @(posedge clk) begin
        if (rs1i == rdi)
            read_data1 <= write_data;
        else
            read_data1 <= (rs1i == 4'b0) ? 32'b0 : regs[rs1i];
        
        if (rs2i == rdi)
            read_data2 <= write_data;
        else
            read_data2 <= (rs2i == 4'b0) ? 32'b0 : regs[rs2i];
        if (reg_write == 1'b1) 
            regs[rdi] <= write_data;
    end
endmodule