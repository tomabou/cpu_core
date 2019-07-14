module uart_input(clk, reset,rxd,data,count,buffer);
    input clk,reset,rxd;
    output data,count,buffer;

    reg [10:0] count = 11'b0;
    reg [3:0] buffer = 4'b1111;
    reg [3:0] rcv_data = 3'b111;
    reg is_rcv = 1'b0;
    reg [1:0] clk_count = 2'b0;
    reg [4:0] data_count = 4'b0;
    reg [7:0] in_data = 8'b0;
    reg [7:0] data = 8'b0;

    //baudrate 9600 
    // 50M / (9600 * 4) = 1302
    parameter baud_rate_cnt = 11'd1302;


    always @(posedge clk or negedge reset)
        if (reset == 1'b0)
            count <= 11'b0;
        else if (count == baud_rate_cnt)
            count <= 0;
        else
            count <= count + 11'b1;

    always @(posedge clk)
        buffer <= {buffer[2:0],rxd};

    always @(posedge clk )
        if (count == baud_rate_cnt) begin
            rcv_data <= {rcv_data[2:0],buffer[3]};
            if (rcv_data[2:0] == 3'b000)
                is_rcv <= 1'b1;
            else if (data_count == 4'b1000 && clk_count == 2'b11)
                is_rcv <= 1'b0;
            end
        else
            rcv_data <= rcv_data;

    always @(posedge clk)
        if ((count == baud_rate_cnt) && (is_rcv == 1'b1)) begin
            clk_count <= clk_count + 2'b1;
            if (clk_count == 2'b11) begin
                in_data <= {in_data[7:0],rcv_data[2]};
                if (data_count == 4'b1000) begin
                    data <= in_data;
                    data_count <= 4'b0;
                end
                else
                    data_count <= data_count + 4'b1;
            end
        end
endmodule


