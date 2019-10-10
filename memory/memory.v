module memory (
	//////////// CLOCK //////////
	input 		          		ADC_CLK_10,
	input 		          		MAX10_CLK1_50,
	input 		          		MAX10_CLK2_50,

	//////////// SDRAM //////////
	output		    [12:0]		DRAM_ADDR,
	output		     [1:0]		DRAM_BA,
	output		          		DRAM_CAS_N,
	output		          		DRAM_CKE,
	output		          		DRAM_CLK,
	output		          		DRAM_CS_N,
	inout 		    [15:0]		DRAM_DQ,
	output		          		DRAM_LDQM,
	output		          		DRAM_RAS_N,
	output		          		DRAM_UDQM,
	output		          		DRAM_WE_N,

	//////////// SEG7 //////////
	output		     [7:0]		HEX0,
	output		     [7:0]		HEX1,
	output		     [7:0]		HEX2,
	output		     [7:0]		HEX3,
	output		     [7:0]		HEX4,
	output		     [7:0]		HEX5,

	//////////// KEY //////////
	input 		     [1:0]		KEY,

	//////////// LED //////////
	output		     [9:0]		LEDR

);

    wire  [15:0]  writedata;
    wire  [15:0]  readdata;
    wire          write;
    wire          read;
    wire          clk_test;

    wire  test_software_reset_n;
    wire  test_global_reset_n;
    wire  test_start_n;

    wire  sdram_test_pass;
    wire  sdram_test_fail;
    wire  sdram_test_complete;



    //=======================================================
    //  Structural coding
    //=======================================================

    //	SDRAM frame buffer
    Sdram_Control	u1	(	//	HOST Side
    						.REF_CLK(MAX10_CLK1_50),
					        .RESET_N(test_software_reset_n),
							//	FIFO Write Side 
						    .WR_DATA(writedata),
							.WR(write),
							.WR_ADDR(0),
							.WR_MAX_ADDR(25'h1ffffff),		//	
							.WR_LENGTH(9'h80),
							.WR_LOAD(!test_global_reset_n ),
							.WR_CLK(clk_test),
							//	FIFO Read Side 
						    .RD_DATA(readdata),
				        	.RD(read),
				        	.RD_ADDR(0),			//	Read odd field and bypess blanking
							.RD_MAX_ADDR(25'h1ffffff),
							.RD_LENGTH(9'h80),
				        	.RD_LOAD(!test_global_reset_n ),
							.RD_CLK(clk_test),
                     //	SDRAM Side
						    .SA(DRAM_ADDR),
						    .BA(DRAM_BA),
						    .CS_N(DRAM_CS_N),
						    .CKE(DRAM_CKE),
						    .RAS_N(DRAM_RAS_N),
				            .CAS_N(DRAM_CAS_N),
				            .WE_N(DRAM_WE_N),
						    .DQ(DRAM_DQ),
				            .DQM({DRAM_UDQM,DRAM_LDQM}),
							.SDR_CLK(DRAM_CLK)	);


pll_test u2(
	.areset(),
	.inclk0(MAX10_CLK2_50),
	.c0(clk_test),
	.locked());

	
	
RW_Test u3(
      .iCLK(clk_test),
		.iRST_n(test_software_reset_n),
		.iBUTTON(test_start_n),
      .write(write),
		.writedata(writedata),
	   .read(read),
		.readdata(readdata),
      .drv_status_pass(sdram_test_pass),
		.drv_status_fail(sdram_test_fail),
		.drv_status_test_complete(sdram_test_complete)
		
);			
	
// / //////////////////////////////////////////////
// reset_n and start_n control
reg [31:0]  cont;
always@(posedge MAX10_CLK1_50)
cont<=(cont==32'd4_000_001)?32'd0:cont+1'b1;

reg[4:0] sample;
always@(posedge MAX10_CLK1_50)
begin
	if(cont==32'd4_000_000)
		sample[4:0]={sample[3:0],KEY[0]};
	else 
		sample[4:0]=sample[4:0];
end


assign test_software_reset_n=(sample[1:0]==2'b10)?1'b0:1'b1;
assign test_global_reset_n   =(sample[3:2]==2'b10)?1'b0:1'b1;
assign test_start_n         =(sample[4:3]==2'b01)?1'b0:1'b1;

wire [2:0] test_result;
assign test_result[0] =  KEY[0];
assign test_result[1] =  sdram_test_complete? sdram_test_pass : heart_beat[23];
assign test_result[2] =  heart_beat[23];


assign LEDR[2:0] = KEY[0]?test_result:4'b1111;

reg [23:0] heart_beat;
always @ (posedge MAX10_CLK1_50)
begin
	heart_beat <= heart_beat + 1;
end

endmodule


