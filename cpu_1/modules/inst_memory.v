module inst_memory (clk,rd_address,instruction);
    input clk;
    input [31:0] rd_address;
    output [31:0] instruction;
    
    rom1 inst_ram(
        rd_address[15:2],
        clk,
        instruction);
endmodule
