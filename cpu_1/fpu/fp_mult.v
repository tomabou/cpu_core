module fpu_mult(clk,ope1,ope2,q);
    input clk;
    input [31:0] ope1;
    input [31:0] ope2;
    output reg [31:0] q;

    wire [31:0] ans;
    fpmul fpmul1(clk,1'b0,ope1,ope2,ans);

    always @ (posedge clk) begin
        q <= ans;
    end

endmodule
