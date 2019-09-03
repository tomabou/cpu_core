module alu(data1,data2,out,ctrl);
    input [31:0] data1;
    input [31:0] data2;
    output reg [31:0] out;
    input [3:0] ctrl;

    always @(*) begin
        case(ctrl)
            0: out <= data1 & data2;
            1: out <= data1 | data2;
            2: out <= data1 + data2;
            3: out <= data1 - data2;
            4: out <= data1 ^ data2;
            5: out <= data1 == data2;
            6: out <= data1 != data2;
            7: out <= data1 < data2;
            8: out <= data1 >= data2;
            9: out <= $signed(data1) < $signed(data2);
            10: out <= $signed(data1) >= $signed(data2);
            11: out <= data1 << data2[4:0];
            12: out <= data1 >> data2[4:0];
            13: out <= $signed(data1) >>> data2[4:0];
            default: out <= 32'b0;
        endcase
    end
        
endmodule
