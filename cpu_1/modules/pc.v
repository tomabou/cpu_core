module pc(clken,clk,new_pc,counter);
    input clken;
    input clk;
    input [31:0] new_pc;
    output reg [31:0] counter = 32'b0;

    always @ (posedge clk)
        if (clken)
            counter <= new_pc;
endmodule
