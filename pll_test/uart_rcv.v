//clock is four times of baud rate

module uart_rcv(clk,rxd,data,err,data_clk,rcv_data);
  input clk;
  input rxd;
  output data;
  output err;
  output data_clk;
  output rcv_data;
  reg [7:0] data = 8'b0;
  reg [7:0] in_data = 8'b0;
  reg err = 1'b0;
  
  reg is_rcv;
  reg [1:0] count = 2'b00;
  reg [3:0] data_count = 4'b0;

  reg [3:0] rcv_data;
  reg data_clk = 1'b0;
  
  always @ ( posedge clk ) begin
    rcv_data[0] <= rxd; 
    rcv_data[1] <= rcv_data[0];
    rcv_data[2] <= rcv_data[1];
    rcv_data[3] <= rcv_data[2];

    if (is_rcv) begin
      count <= count + 2'b01;
      if(count == 2'b11)
        data_clk <= 1'b1;
      else 
        data_clk <= 1'b0;
    end
    else
      if (rcv_data[3:1] == 3'b000)
        is_rcv = 1'b1;
  end
  
  integer i;
  
  always @ (posedge data_clk) begin
    
	 for(i=0;i<7;i=i+1) begin
      in_data[i+1] <= in_data[i];
    end
    in_data[0] <= rcv_data[2];
    data_count <= data_count + 4'b001;

    if (data_count == 4'b1000) begin
      is_rcv = 1'b0;
      data <= in_data;
      data_count <= 4'b0;
    end
  end
endmodule