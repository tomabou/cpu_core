module led ( clk, rstb, led_0);
  input clk;    //clk 50MHz
  input rstb;   //reset_b
  output led_0; //led control 0:on 1:off
  reg  [9:0] led_0 = 10'b0;
  reg  [25:0] led_cnt = 26'b0;

  //parameter led_cnt_1s = 26'd4999999;
  parameter led_cnt_1s = 26'd49;

always @ (posedge clk or negedge rstb )
  if (rstb==1'b0)
    led_cnt <= 26'b0;
  else if (led_cnt == led_cnt_1s) 
    led_cnt <= 26'b0;             
  else
    led_cnt <= led_cnt + 26'd1;   
      
     
always @ (posedge clk or negedge rstb )
  if (rstb==1'b0) 
    led_0 <= 9'b0;
  else if (led_cnt == led_cnt_1s ) 
    led_0 <= led_0+ 9'd1;            
  else
    led_0 <= led_0;
endmodule

