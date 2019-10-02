module float_register (
    clken,
    clk,
    rs1i,
    rs2i,
    rs3i,
    rdi,
    write_data,
    reg_write,
    read_data1,
    read_data2,
    read_data3);

    input clken;
    input clk;
    input [4:0] rs1i;
    input [4:0] rs2i;
    input [4:0] rs3i;
    input [4:0] rdi;
    input [31:0] write_data;
    input reg_write;
    output reg [31:0] read_data1;
    output reg [31:0] read_data2;
    output reg [31:0] read_data3;

    reg [31:0] regs[0:31];

    always @(posedge clk) begin
        if (clken) begin
            if ((rs1i == rdi) & (reg_write == 1'b1) )
                read_data1 <= write_data;
            else
                read_data1 <= regs[rs1i];
        
            if ((rs2i == rdi) & (reg_write == 1'b1) )
                read_data2 <= write_data;
            else
                read_data2 <= regs[rs2i];

            if ((rs3i == rdi) & (reg_write == 1'b1) )
                read_data3 <= write_data;
            else
                read_data3 <= regs[rs3i];

            if (reg_write == 1'b1) 
                regs[rdi] <= write_data;
        end
    end

endmodule

