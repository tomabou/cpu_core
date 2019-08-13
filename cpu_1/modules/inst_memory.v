module inst_memory (clk,rd_address,instruction);
    input clk;
    input [31:0] rd_address;
    output [31:0] instruction;
    
    ram1 inst_ram(
        rd_address[15:2],
        clk,
        32'b0,
        1'b0,
        instruction);
endmodule
