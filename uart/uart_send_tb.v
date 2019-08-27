module uart_send_tb();
    reg clk;
    reg [7:0] data;
    reg enable;
    wire txd;

    uart_send u1(clk,data,enable,txd);

    initial begin
        enable = 0;
        #10;
        data <= 8'd85;
        enable <= 1'd1;
        #10;
        enable <= 1'd0;
        #500;
        data <= 8'd7;
        #20
        enable <= 1'd1;
        #10
        enable <= 1'd0;


    end

    initial clk = 1'b1;
    always #5
        clk = ~clk;
endmodule

