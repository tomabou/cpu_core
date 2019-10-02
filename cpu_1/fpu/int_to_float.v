module int_to_float(
    clken,
    clk,
    x,
    y);

    input clken;
    input clk;
    input [31:0] x;
    output reg [31:0] y;

    wire [31:0] x_cvt;

    cvt_itof cvt_itof1(clk,1'b0,clken,x,x_cvt);
    
    always @ (posedge clk) begin
        if (clken)
            y <= x_cvt;        
    end

endmodule
