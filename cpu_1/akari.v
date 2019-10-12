module akari(
    clk,
    slow_clk,
    core_clk,
    rxd,
    segment7_1,
    segment7_2,
    segment7_3,
    segment7_4,
    segment7_5,
    segment7_6,
    txd,
	DRAM_ADDR,
	DRAM_BA,
	DRAM_CAS_N,
	DRAM_CKE,
	DRAM_CLK,
	DRAM_CS_N,
	DRAM_DQ,
	DRAM_LDQM,
	DRAM_RAS_N,
	DRAM_UDQM,
	DRAM_WE_N
    );

    input clk;
    input slow_clk;
    input core_clk;
    input rxd;
    output [6:0] segment7_1;
    output [6:0] segment7_2;
    output [6:0] segment7_3;
    output [6:0] segment7_4;
    output [6:0] segment7_5;
    output [6:0] segment7_6;
    output txd;

	//////////// SDRAM //////////
	output		    [12:0]		DRAM_ADDR;
	output		     [1:0]		DRAM_BA;
	output		          		DRAM_CAS_N;
	output		          		DRAM_CKE;
	output		          		DRAM_CLK;
	output		          		DRAM_CS_N;
	inout 		    [15:0]		DRAM_DQ;
	output		          		DRAM_LDQM;
	output		          		DRAM_RAS_N;
	output		          		DRAM_UDQM;
	output		          		DRAM_WE_N;

    wire [9:0] show;

    wire [7:0] uart_in;
    wire [7:0] uart_out;
    wire uart_rdreq;
    wire uart_wrreq;
    wire uart_empty;
    wire uart_full;

    wire [15:0] fifo_wr_data;
    wire fifo_wr;
    wire [24:0] fifo_wr_addr;
    wire fifo_wr_full;
    wire [15:0] fifo_rd_data;
    wire fifo_rd;
    wire [24:0] fifo_rd_addr;
    wire fifo_rd_empty;

    nibu nibu1(
        core_clk,
        show,
        segment7_1,
        segment7_2,
        segment7_3,
        segment7_4,
        segment7_5,
        segment7_6,
        uart_empty,
        uart_full,
        uart_in,
        uart_out,
        uart_rdreq,
        uart_wrreq,
        fifo_wr_data,
        fifo_wr,
        fifo_wr_addr,
        fifo_wr_full,
        fifo_rd_data,
        fifo_rd,
        fifo_rd_addr,
        fifo_rd_empty);

    uart uart1(slow_clk,rxd,txd,
        core_clk,
        uart_wrreq,
        uart_out,
        uart_rdreq,
        uart_in,
        uart_empty,
        uart_full);

    Sdram_Control sdram_control1(
        .REF_CLK(clk),
		//	FIFO Write Side 
	    .WR_DATA(fifo_wr_data),
		.WR(fifo_wr),
		.WR_ADDR(0),
		.WR_MAX_ADDR(25'h1ffffff),		//	
		.WR_LENGTH(9'h80),
		.WR_LOAD(1'b1),
		.WR_CLK(core_clk),
        .WR_FULL(fifo_wr_full),
		//	FIFO Read Side 
	    .RD_DATA(fifo_rd_data),
       	.RD(fifo_rd),
       	.RD_ADDR(0),			//	Read odd field and bypess blanking
		.RD_MAX_ADDR(25'h1ffffff),
		.RD_LENGTH(9'h80),
       	.RD_LOAD(1'b1),
		.RD_CLK(core_clk),
        .RD_EMPTY(fifo_rd_empty),
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

endmodule

