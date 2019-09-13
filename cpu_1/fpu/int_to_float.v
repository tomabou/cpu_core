module int_to_float(
    clk,
    x,
    y);

    input clk;
    input [31:0] x;
    output reg [31:0] y;

    wire [31:0] x_cvt;

    cvt_itof cvt_itof1(clk,1'b0,x,x_cvt);
    
    always @ (posedge clk) begin
        y <= x_cvt;        
    end

endmodule
