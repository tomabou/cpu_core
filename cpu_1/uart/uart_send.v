module uart_send(clk,data,enable,txd,is_send);
    input clk;
    input [7:0] data;
    input enable;
    output reg txd = 1'b1;
    output reg is_send = 1'b0;

    reg [5:0] count = 6'b0;
    reg [9:0] send_buf;

    always @ (posedge clk) begin
        if (is_send == 1'b0) begin
            txd <= 1'b1;
            if (enable == 1'b1) begin
                is_send <= 1'b1;
                send_buf <= {1'b1,data,1'b0};
            end
        end
        else
        begin
            count <= (count == 6'd39) ? 6'd0: count + 5'd1;
            if (count[1:0] == 2'b0) 
                txd <= send_buf[count[5:2]];
            if (count == 6'd39)
                is_send <= 1'b0;
        end
    end

endmodule