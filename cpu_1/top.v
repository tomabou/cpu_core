module top(
    clk,
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

    wire slow_clk;
    wire core_clk;
    akari akari1(clk,
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

    pll_slow pll_slow1(clk,slow_clk);
    pll_core pll_core1(clk,core_clk);
endmodule
