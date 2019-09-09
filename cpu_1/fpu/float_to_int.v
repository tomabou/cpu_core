module float_to_int(
    clk,
    x,
    is_cvt,
    y);
    input clk;
    input [31:0] x;
    input is_cvt;
    output [31:0] y;

    reg [31:0] x_buf;
    wire [31:0] x_cvt;

    assign y = is_cvt ? x_cvt : x_buf ;
    cvt_ftoi cvt_ftoi1(clk,1'b0,x,x_cvt);

    always @ (posedge clk) begin
        x_buf <= x;
    end

endmodule
