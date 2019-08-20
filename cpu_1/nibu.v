module nibu (clk,show);
    input clk;
    output [9:0] show;

    reg [31:0] pc = 32'b0;
    wire [31:0] instruction;
    wire [31:0] write_data;
    wire [31:0] read_data1;
    wire [31:0] read_data2;


    wire reg_write_ctl;

    assign show = instruction[9:0];

    inst_memory im1(clk,pc,instruction);

    registers regs1(
        clk,
        instruction[19:15],
        instruction[24:20],
        instruction[11:7],
        write_data,
        reg_write_ctl,
        read_data1;
        read_data2;
    )

    always @ (posedge clk) begin
        pc <= pc + 32'b100;
    end

endmodule