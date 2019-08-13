module nibu (clk,show);
    input clk;
    output [9:0] show;

    reg [31:0] pc = 32'b0;
    wire [31:0] instruction;

    assign show = instruction[9:0];

    inst_memory im1(clk,pc,instruction);

    always @ (posedge clk) begin
        pc <= pc + 32'b100;
    end

endmodule