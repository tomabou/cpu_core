module alu(data1,data2,out,ctrl);
    input [31:0] data1;
    input [31:0] data2;
    output reg [31:0] out;
    input [3:0] ctrl;

    always @(*) begin
        case(ctrl)
            0: out <= data1&data2;
            2: out <= data1+data2;
            3: out <= data1-data2;
            default: out = 0;
        endcase
    end
        
endmodule
