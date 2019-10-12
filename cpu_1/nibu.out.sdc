## Generated SDC file "nibu.out.sdc"

## Copyright (C) 2018  Intel Corporation. All rights reserved.
## Your use of Intel Corporation's design tools, logic functions 
## and other software and tools, and its AMPP partner logic 
## functions, and any output files from any of the foregoing 
## (including device programming or simulation files), and any 
## associated documentation or information are expressly subject 
## to the terms and conditions of the Intel Program License 
## Subscription Agreement, the Intel Quartus Prime License Agreement,
## the Intel FPGA IP License Agreement, or other applicable license
## agreement, including, without limitation, that your use is for
## the sole purpose of programming logic devices manufactured by
## Intel and sold by Intel or its authorized distributors.  Please
## refer to the applicable agreement for further details.


## VENDOR  "Altera"
## PROGRAM "Quartus Prime"
## VERSION "Version 18.1.0 Build 625 09/12/2018 SJ Lite Edition"

## DATE    "Sat Oct 12 18:09:57 2019"

##
## DEVICE  "10M50DAF484C7G"
##


#**************************************************************
# Time Information
#**************************************************************

set_time_format -unit ns -decimal_places 3



#**************************************************************
# Create Clock
#**************************************************************

create_clock -name {clk} -period 20.000 -waveform { 0.000 10.000 } [get_ports {clk}]


#**************************************************************
# Create Generated Clock
#**************************************************************

create_generated_clock -name {pll_slow1|altpll_component|auto_generated|pll1|clk[0]} -source [get_pins {pll_slow1|altpll_component|auto_generated|pll1|inclk[0]}] -duty_cycle 50/1 -multiply_by 71 -divide_by 7704 -master_clock {clk} [get_pins {pll_slow1|altpll_component|auto_generated|pll1|clk[0]}] 
create_generated_clock -name {pll_core1|altpll_component|auto_generated|pll1|clk[0]} -source [get_pins {pll_core1|altpll_component|auto_generated|pll1|inclk[0]}] -duty_cycle 50/1 -multiply_by 9 -divide_by 10 -master_clock {clk} [get_pins {pll_core1|altpll_component|auto_generated|pll1|clk[0]}] 
create_generated_clock -name {akari1|sdram_control1|sdram_pll0_inst|altpll_component|auto_generated|pll1|clk[0]} -source [get_pins {akari1|sdram_control1|sdram_pll0_inst|altpll_component|auto_generated|pll1|inclk[0]}] -duty_cycle 50/1 -multiply_by 2 -master_clock {clk} [get_pins {akari1|sdram_control1|sdram_pll0_inst|altpll_component|auto_generated|pll1|clk[0]}] 
create_generated_clock -name {akari1|sdram_control1|sdram_pll0_inst|altpll_component|auto_generated|pll1|clk[1]} -source [get_pins {akari1|sdram_control1|sdram_pll0_inst|altpll_component|auto_generated|pll1|inclk[0]}] -duty_cycle 50/1 -multiply_by 2 -phase -108/1 -master_clock {clk} [get_pins {akari1|sdram_control1|sdram_pll0_inst|altpll_component|auto_generated|pll1|clk[1]}] 


#**************************************************************
# Set Clock Latency
#**************************************************************



#**************************************************************
# Set Clock Uncertainty
#**************************************************************

set_clock_uncertainty -rise_from [get_clocks {pll_slow1|altpll_component|auto_generated|pll1|clk[0]}] -rise_to [get_clocks {pll_slow1|altpll_component|auto_generated|pll1|clk[0]}]  0.020  
set_clock_uncertainty -rise_from [get_clocks {pll_slow1|altpll_component|auto_generated|pll1|clk[0]}] -fall_to [get_clocks {pll_slow1|altpll_component|auto_generated|pll1|clk[0]}]  0.020  
set_clock_uncertainty -rise_from [get_clocks {pll_slow1|altpll_component|auto_generated|pll1|clk[0]}] -rise_to [get_clocks {pll_core1|altpll_component|auto_generated|pll1|clk[0]}]  0.150  
set_clock_uncertainty -rise_from [get_clocks {pll_slow1|altpll_component|auto_generated|pll1|clk[0]}] -fall_to [get_clocks {pll_core1|altpll_component|auto_generated|pll1|clk[0]}]  0.150  
set_clock_uncertainty -fall_from [get_clocks {pll_slow1|altpll_component|auto_generated|pll1|clk[0]}] -rise_to [get_clocks {pll_slow1|altpll_component|auto_generated|pll1|clk[0]}]  0.020  
set_clock_uncertainty -fall_from [get_clocks {pll_slow1|altpll_component|auto_generated|pll1|clk[0]}] -fall_to [get_clocks {pll_slow1|altpll_component|auto_generated|pll1|clk[0]}]  0.020  
set_clock_uncertainty -fall_from [get_clocks {pll_slow1|altpll_component|auto_generated|pll1|clk[0]}] -rise_to [get_clocks {pll_core1|altpll_component|auto_generated|pll1|clk[0]}]  0.150  
set_clock_uncertainty -fall_from [get_clocks {pll_slow1|altpll_component|auto_generated|pll1|clk[0]}] -fall_to [get_clocks {pll_core1|altpll_component|auto_generated|pll1|clk[0]}]  0.150  
set_clock_uncertainty -rise_from [get_clocks {pll_core1|altpll_component|auto_generated|pll1|clk[0]}] -rise_to [get_clocks {pll_slow1|altpll_component|auto_generated|pll1|clk[0]}]  0.150  
set_clock_uncertainty -rise_from [get_clocks {pll_core1|altpll_component|auto_generated|pll1|clk[0]}] -fall_to [get_clocks {pll_slow1|altpll_component|auto_generated|pll1|clk[0]}]  0.150  
set_clock_uncertainty -rise_from [get_clocks {pll_core1|altpll_component|auto_generated|pll1|clk[0]}] -rise_to [get_clocks {pll_core1|altpll_component|auto_generated|pll1|clk[0]}]  0.020  
set_clock_uncertainty -rise_from [get_clocks {pll_core1|altpll_component|auto_generated|pll1|clk[0]}] -fall_to [get_clocks {pll_core1|altpll_component|auto_generated|pll1|clk[0]}]  0.020  
set_clock_uncertainty -fall_from [get_clocks {pll_core1|altpll_component|auto_generated|pll1|clk[0]}] -rise_to [get_clocks {pll_slow1|altpll_component|auto_generated|pll1|clk[0]}]  0.150  
set_clock_uncertainty -fall_from [get_clocks {pll_core1|altpll_component|auto_generated|pll1|clk[0]}] -fall_to [get_clocks {pll_slow1|altpll_component|auto_generated|pll1|clk[0]}]  0.150  
set_clock_uncertainty -fall_from [get_clocks {pll_core1|altpll_component|auto_generated|pll1|clk[0]}] -rise_to [get_clocks {pll_core1|altpll_component|auto_generated|pll1|clk[0]}]  0.020  
set_clock_uncertainty -fall_from [get_clocks {pll_core1|altpll_component|auto_generated|pll1|clk[0]}] -fall_to [get_clocks {pll_core1|altpll_component|auto_generated|pll1|clk[0]}]  0.020  
set_clock_uncertainty -rise_from [get_clocks {akari1|sdram_control1|sdram_pll0_inst|altpll_component|auto_generated|pll1|clk[0]}] -rise_to [get_clocks {akari1|sdram_control1|sdram_pll0_inst|altpll_component|auto_generated|pll1|clk[0]}]  0.020  
set_clock_uncertainty -rise_from [get_clocks {akari1|sdram_control1|sdram_pll0_inst|altpll_component|auto_generated|pll1|clk[0]}] -fall_to [get_clocks {akari1|sdram_control1|sdram_pll0_inst|altpll_component|auto_generated|pll1|clk[0]}]  0.020  
set_clock_uncertainty -fall_from [get_clocks {akari1|sdram_control1|sdram_pll0_inst|altpll_component|auto_generated|pll1|clk[0]}] -rise_to [get_clocks {akari1|sdram_control1|sdram_pll0_inst|altpll_component|auto_generated|pll1|clk[0]}]  0.020  
set_clock_uncertainty -fall_from [get_clocks {akari1|sdram_control1|sdram_pll0_inst|altpll_component|auto_generated|pll1|clk[0]}] -fall_to [get_clocks {akari1|sdram_control1|sdram_pll0_inst|altpll_component|auto_generated|pll1|clk[0]}]  0.020  


#**************************************************************
# Set Input Delay
#**************************************************************



#**************************************************************
# Set Output Delay
#**************************************************************



#**************************************************************
# Set Clock Groups
#**************************************************************



#**************************************************************
# Set False Path
#**************************************************************

set_false_path -from [get_keepers {*rdptr_g*}] -to [get_keepers {*ws_dgrp|dffpipe_qe9:dffpipe16|dffe17a*}]
set_false_path -from [get_keepers {*delayed_wrptr_g*}] -to [get_keepers {*rs_dgwp|dffpipe_pe9:dffpipe13|dffe14a*}]
set_false_path -from [get_keepers {*rdptr_g*}] -to [get_keepers {*ws_dgrp|dffpipe_3v8:dffpipe15|dffe16a*}]
set_false_path -from [get_keepers {*delayed_wrptr_g*}] -to [get_keepers {*rs_dgwp|dffpipe_2v8:dffpipe12|dffe13a*}]


#**************************************************************
# Set Multicycle Path
#**************************************************************



#**************************************************************
# Set Maximum Delay
#**************************************************************



#**************************************************************
# Set Minimum Delay
#**************************************************************



#**************************************************************
# Set Input Transition
#**************************************************************

