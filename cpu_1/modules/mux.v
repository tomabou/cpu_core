module mux(data1,data2,out,ctrl);
    input [31:0] data1;
    input [31:0] data2;
    output [31:0] out;
    input ctrl;
    assign out = ctrl ? data2 : data1;
endmodule