module delay32(clk,in_data,out_data);
    input clk;
    input [31:0] in_data;
    output reg [31:0] out_data = 32'b0;

    always @ (posedge clk) begin
        out_data <= in_data;
    end
endmodule
