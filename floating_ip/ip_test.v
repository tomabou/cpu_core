module ip_test (
    clk,
    segment7_1,
    segment7_2,
    segment7_3,
    segment7_4,
    segment7_5,
    segment7_6);

    input clk;
    output [6:0] segment7_1;
    output [6:0] segment7_2;
    output [6:0] segment7_3;
    output [6:0] segment7_4;
    output [6:0] segment7_5;
    output [6:0] segment7_6;


    reg [3:0] count = 4'b0;

    seg7 seg7_1(address[5:2],segment7_1);
    seg7 seg7_2(address[9:6],segment7_2);
    seg7 seg7_3(seg_io[3:0],segment7_3);
    seg7 seg7_4(seg_io[7:4],segment7_4);
    seg7 seg7_5(seg_io[11:8],segment7_5);
    seg7 seg7_6(seg_io[15:12],segment7_6);

    always @ (posedge clk) begin
        count <= count + 4'b1;
    end

endmodule
