module fp_inv (x,ctrl,y);
    input [31:0] x;
    input ctrl;
    output [31:0] y;

    assign y = ctrl ? {~x[31],x[30:0]} : x;

endmodule
