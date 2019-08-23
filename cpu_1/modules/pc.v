module pc(clk,new,counter);
    input clk;
    input [31:0] new;
    output reg [31:0] counter = 32'b0;

    always @ (posedge clk)
        counter <= new;
endmodule
