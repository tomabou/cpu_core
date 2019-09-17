module alu(data1,data2,out,ctrl);
    input [31:0] data1;
    input [31:0] data2;
    output reg [31:0] out;
    input [3:0] ctrl;

    reg slt;
    reg sge;

    always @(*) begin
        case ({data1[31],data2[31]})
            2'b10 : slt <= 1'b1;
            2'b01 : slt <= 1'b0;
            default : slt <= data1 < data2;
        endcase
    end

    always @(*) begin
        case ({data1[31],data2[31]})
            2'b10 : sge <= 1'b0;
            2'b01 : sge <= 1'b1;
            default : sge <= data1 >= data2;
        endcase
    end
    

    always @(*) begin
        case(ctrl)
            0: out <= data1 & data2;
            1: out <= data1 | data2;
            2: out <= data1 + data2;
            3: out <= data1 - data2;
            4: out <= data1 ^ data2;
            5: out <= data1 == data2;
            6: out <= data1 != data2;
            7: out <= slt;
            8: out <= sge;
            9: out <= data1 < data2;
            10: out <= data1 >= data2;
            11: out <= data1 << data2[4:0];
            12: out <= data1 >> data2[4:0];
            13: out <= $signed(data1) >>> data2[4:0];
            default: out <= 32'b0;
        endcase
    end
        
endmodule
