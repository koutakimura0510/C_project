
# Efinity Interface Designer SDC
# Version: 2022.2.322
# Date: 2023-01-29 18:03

# Copyright (C) 2017 - 2022 Efinix Inc. All rights reserved.

# Device: Ti180M484
# Project: Ti180_FMB_R1W1_k256m32_230125
# Timing Model: C4 (preliminary)
#               NOTE: The timing data is not final

# PLL Constraints
#################
create_clock -period 10.0000 iPLLCLK
create_clock -period 10.0000 iSCLK
create_clock -period 10.0000 iACLK
create_clock -period 7.5008 iDdrFCLK

# GPIO Constraints
####################
# set_input_delay -clock <CLOCK> [-reference_pin <clkout_pad>] -max <MAX CALCULATION> [get_ports {iOscDdr}]
# set_input_delay -clock <CLOCK> [-reference_pin <clkout_pad>] -min <MIN CALCULATION> [get_ports {iOscDdr}]

# DDR Constraints
#####################
set_output_delay -clock iACLK -reference_pin [get_ports {iACLK~CLKOUT~2~150}] -max 3.675 [get_ports {ddr4_ARSTN_0}]
set_output_delay -clock iACLK -reference_pin [get_ports {iACLK~CLKOUT~2~150}] -min -0.000 [get_ports {ddr4_ARSTN_0}]
set_output_delay -clock iACLK -reference_pin [get_ports {iACLK~CLKOUT~2~150}] -max 2.310 [get_ports {ddr4_ARADDR_0[*]}]
set_output_delay -clock iACLK -reference_pin [get_ports {iACLK~CLKOUT~2~150}] -min -0.140 [get_ports {ddr4_ARADDR_0[*]}]
set_output_delay -clock iACLK -reference_pin [get_ports {iACLK~CLKOUT~2~150}] -max 2.310 [get_ports {ddr4_ARAPCMD_0}]
set_output_delay -clock iACLK -reference_pin [get_ports {iACLK~CLKOUT~2~150}] -min -0.140 [get_ports {ddr4_ARAPCMD_0}]
set_output_delay -clock iACLK -reference_pin [get_ports {iACLK~CLKOUT~2~150}] -max 2.310 [get_ports {ddr4_ARBURST_0[1] ddr4_ARBURST_0[0]}]
set_output_delay -clock iACLK -reference_pin [get_ports {iACLK~CLKOUT~2~150}] -min -0.140 [get_ports {ddr4_ARBURST_0[1] ddr4_ARBURST_0[0]}]
set_output_delay -clock iACLK -reference_pin [get_ports {iACLK~CLKOUT~2~150}] -max 2.310 [get_ports {ddr4_ARID_0[*]}]
set_output_delay -clock iACLK -reference_pin [get_ports {iACLK~CLKOUT~2~150}] -min -0.140 [get_ports {ddr4_ARID_0[*]}]
set_output_delay -clock iACLK -reference_pin [get_ports {iACLK~CLKOUT~2~150}] -max 2.310 [get_ports {ddr4_ARLEN_0[*]}]
set_output_delay -clock iACLK -reference_pin [get_ports {iACLK~CLKOUT~2~150}] -min -0.140 [get_ports {ddr4_ARLEN_0[*]}]
set_output_delay -clock iACLK -reference_pin [get_ports {iACLK~CLKOUT~2~150}] -max 2.310 [get_ports {ddr4_ARSIZE_0[2] ddr4_ARSIZE_0[1] ddr4_ARSIZE_0[0]}]
set_output_delay -clock iACLK -reference_pin [get_ports {iACLK~CLKOUT~2~150}] -min -0.140 [get_ports {ddr4_ARSIZE_0[2] ddr4_ARSIZE_0[1] ddr4_ARSIZE_0[0]}]
set_output_delay -clock iACLK -reference_pin [get_ports {iACLK~CLKOUT~2~150}] -max 2.310 [get_ports {ddr4_ARVALID_0}]
set_output_delay -clock iACLK -reference_pin [get_ports {iACLK~CLKOUT~2~150}] -min -0.140 [get_ports {ddr4_ARVALID_0}]
set_output_delay -clock iACLK -reference_pin [get_ports {iACLK~CLKOUT~2~150}] -max 2.310 [get_ports {ddr4_ARLOCK_0}]
set_output_delay -clock iACLK -reference_pin [get_ports {iACLK~CLKOUT~2~150}] -min -0.140 [get_ports {ddr4_ARLOCK_0}]
set_output_delay -clock iACLK -reference_pin [get_ports {iACLK~CLKOUT~2~150}] -max 2.310 [get_ports {ddr4_ARQOS_0}]
set_output_delay -clock iACLK -reference_pin [get_ports {iACLK~CLKOUT~2~150}] -min -0.140 [get_ports {ddr4_ARQOS_0}]
set_output_delay -clock iACLK -reference_pin [get_ports {iACLK~CLKOUT~2~150}] -max 2.310 [get_ports {ddr4_AWADDR_0[*]}]
set_output_delay -clock iACLK -reference_pin [get_ports {iACLK~CLKOUT~2~150}] -min -0.140 [get_ports {ddr4_AWADDR_0[*]}]
set_output_delay -clock iACLK -reference_pin [get_ports {iACLK~CLKOUT~2~150}] -max 2.310 [get_ports {ddr4_AWAPCMD_0}]
set_output_delay -clock iACLK -reference_pin [get_ports {iACLK~CLKOUT~2~150}] -min -0.350 [get_ports {ddr4_AWAPCMD_0}]
set_output_delay -clock iACLK -reference_pin [get_ports {iACLK~CLKOUT~2~150}] -max 2.310 [get_ports {ddr4_AWALLSTRB_0}]
set_output_delay -clock iACLK -reference_pin [get_ports {iACLK~CLKOUT~2~150}] -min -0.140 [get_ports {ddr4_AWALLSTRB_0}]
set_output_delay -clock iACLK -reference_pin [get_ports {iACLK~CLKOUT~2~150}] -max 2.310 [get_ports {ddr4_AWBURST_0[1] ddr4_AWBURST_0[0]}]
set_output_delay -clock iACLK -reference_pin [get_ports {iACLK~CLKOUT~2~150}] -min -0.140 [get_ports {ddr4_AWBURST_0[1] ddr4_AWBURST_0[0]}]
set_output_delay -clock iACLK -reference_pin [get_ports {iACLK~CLKOUT~2~150}] -max 2.310 [get_ports {ddr4_AWCOBUF_0}]
set_output_delay -clock iACLK -reference_pin [get_ports {iACLK~CLKOUT~2~150}] -min -0.140 [get_ports {ddr4_AWCOBUF_0}]
set_output_delay -clock iACLK -reference_pin [get_ports {iACLK~CLKOUT~2~150}] -max 2.310 [get_ports {ddr4_AWID_0[*]}]
set_output_delay -clock iACLK -reference_pin [get_ports {iACLK~CLKOUT~2~150}] -min -0.140 [get_ports {ddr4_AWID_0[*]}]
set_output_delay -clock iACLK -reference_pin [get_ports {iACLK~CLKOUT~2~150}] -max 2.310 [get_ports {ddr4_AWLEN_0[*]}]
set_output_delay -clock iACLK -reference_pin [get_ports {iACLK~CLKOUT~2~150}] -min -0.140 [get_ports {ddr4_AWLEN_0[*]}]
set_output_delay -clock iACLK -reference_pin [get_ports {iACLK~CLKOUT~2~150}] -max 2.310 [get_ports {ddr4_AWSIZE_0[2] ddr4_AWSIZE_0[1] ddr4_AWSIZE_0[0]}]
set_output_delay -clock iACLK -reference_pin [get_ports {iACLK~CLKOUT~2~150}] -min -0.140 [get_ports {ddr4_AWSIZE_0[2] ddr4_AWSIZE_0[1] ddr4_AWSIZE_0[0]}]
set_output_delay -clock iACLK -reference_pin [get_ports {iACLK~CLKOUT~2~150}] -max 2.310 [get_ports {ddr4_AWVALID_0}]
set_output_delay -clock iACLK -reference_pin [get_ports {iACLK~CLKOUT~2~150}] -min -0.140 [get_ports {ddr4_AWVALID_0}]
set_output_delay -clock iACLK -reference_pin [get_ports {iACLK~CLKOUT~2~150}] -max 2.310 [get_ports {ddr4_AWLOCK_0}]
set_output_delay -clock iACLK -reference_pin [get_ports {iACLK~CLKOUT~2~150}] -min -0.140 [get_ports {ddr4_AWLOCK_0}]
set_output_delay -clock iACLK -reference_pin [get_ports {iACLK~CLKOUT~2~150}] -max 2.310 [get_ports {ddr4_AWCACHE_0[3] ddr4_AWCACHE_0[2] ddr4_AWCACHE_0[1] ddr4_AWCACHE_0[0]}]
set_output_delay -clock iACLK -reference_pin [get_ports {iACLK~CLKOUT~2~150}] -min -0.140 [get_ports {ddr4_AWCACHE_0[3] ddr4_AWCACHE_0[2] ddr4_AWCACHE_0[1] ddr4_AWCACHE_0[0]}]
set_output_delay -clock iACLK -reference_pin [get_ports {iACLK~CLKOUT~2~150}] -max 2.310 [get_ports {ddr4_AWQOS_0}]
set_output_delay -clock iACLK -reference_pin [get_ports {iACLK~CLKOUT~2~150}] -min -0.140 [get_ports {ddr4_AWQOS_0}]
set_output_delay -clock iACLK -reference_pin [get_ports {iACLK~CLKOUT~2~150}] -max 2.310 [get_ports {ddr4_BREADY_0}]
set_output_delay -clock iACLK -reference_pin [get_ports {iACLK~CLKOUT~2~150}] -min -0.140 [get_ports {ddr4_BREADY_0}]
set_output_delay -clock iACLK -reference_pin [get_ports {iACLK~CLKOUT~2~150}] -max 2.310 [get_ports {ddr4_RREADY_0}]
set_output_delay -clock iACLK -reference_pin [get_ports {iACLK~CLKOUT~2~150}] -min -0.140 [get_ports {ddr4_RREADY_0}]
set_output_delay -clock iACLK -reference_pin [get_ports {iACLK~CLKOUT~2~150}] -max 2.310 [get_ports {ddr4_WDATA_0[*]}]
set_output_delay -clock iACLK -reference_pin [get_ports {iACLK~CLKOUT~2~150}] -min -0.140 [get_ports {ddr4_WDATA_0[*]}]
set_output_delay -clock iACLK -reference_pin [get_ports {iACLK~CLKOUT~2~150}] -max 2.310 [get_ports {ddr4_WLAST_0}]
set_output_delay -clock iACLK -reference_pin [get_ports {iACLK~CLKOUT~2~150}] -min -0.140 [get_ports {ddr4_WLAST_0}]
set_output_delay -clock iACLK -reference_pin [get_ports {iACLK~CLKOUT~2~150}] -max 2.310 [get_ports {ddr4_WSTRB_0[*]}]
set_output_delay -clock iACLK -reference_pin [get_ports {iACLK~CLKOUT~2~150}] -min -0.140 [get_ports {ddr4_WSTRB_0[*]}]
set_output_delay -clock iACLK -reference_pin [get_ports {iACLK~CLKOUT~2~150}] -max 2.310 [get_ports {ddr4_WVALID_0}]
set_output_delay -clock iACLK -reference_pin [get_ports {iACLK~CLKOUT~2~150}] -min -0.140 [get_ports {ddr4_WVALID_0}]
set_input_delay -clock iACLK -reference_pin [get_ports {iACLK~CLKOUT~2~150}] -max 2.625 [get_ports {ddr4_ARREADY_0}]
set_input_delay -clock iACLK -reference_pin [get_ports {iACLK~CLKOUT~2~150}] -min 1.750 [get_ports {ddr4_ARREADY_0}]
set_input_delay -clock iACLK -reference_pin [get_ports {iACLK~CLKOUT~2~150}] -max 2.520 [get_ports {ddr4_AWREADY_0}]
set_input_delay -clock iACLK -reference_pin [get_ports {iACLK~CLKOUT~2~150}] -min 1.680 [get_ports {ddr4_AWREADY_0}]
set_input_delay -clock iACLK -reference_pin [get_ports {iACLK~CLKOUT~2~150}] -max 2.520 [get_ports {ddr4_BID_0[*]}]
set_input_delay -clock iACLK -reference_pin [get_ports {iACLK~CLKOUT~2~150}] -min 1.680 [get_ports {ddr4_BID_0[*]}]
set_input_delay -clock iACLK -reference_pin [get_ports {iACLK~CLKOUT~2~150}] -max 2.625 [get_ports {ddr4_BRESP_0[1] ddr4_BRESP_0[0]}]
set_input_delay -clock iACLK -reference_pin [get_ports {iACLK~CLKOUT~2~150}] -min 1.750 [get_ports {ddr4_BRESP_0[1] ddr4_BRESP_0[0]}]
set_input_delay -clock iACLK -reference_pin [get_ports {iACLK~CLKOUT~2~150}] -max 2.625 [get_ports {ddr4_BVALID_0}]
set_input_delay -clock iACLK -reference_pin [get_ports {iACLK~CLKOUT~2~150}] -min 1.750 [get_ports {ddr4_BVALID_0}]
set_input_delay -clock iACLK -reference_pin [get_ports {iACLK~CLKOUT~2~150}] -max 2.625 [get_ports {ddr4_RDATA_0[*]}]
set_input_delay -clock iACLK -reference_pin [get_ports {iACLK~CLKOUT~2~150}] -min 1.750 [get_ports {ddr4_RDATA_0[*]}]
set_input_delay -clock iACLK -reference_pin [get_ports {iACLK~CLKOUT~2~150}] -max 2.625 [get_ports {ddr4_RID_0[*]}]
set_input_delay -clock iACLK -reference_pin [get_ports {iACLK~CLKOUT~2~150}] -min 1.750 [get_ports {ddr4_RID_0[*]}]
set_input_delay -clock iACLK -reference_pin [get_ports {iACLK~CLKOUT~2~150}] -max 2.625 [get_ports {ddr4_RLAST_0}]
set_input_delay -clock iACLK -reference_pin [get_ports {iACLK~CLKOUT~2~150}] -min 1.750 [get_ports {ddr4_RLAST_0}]
set_input_delay -clock iACLK -reference_pin [get_ports {iACLK~CLKOUT~2~150}] -max 2.625 [get_ports {ddr4_RRESP_0[1] ddr4_RRESP_0[0]}]
set_input_delay -clock iACLK -reference_pin [get_ports {iACLK~CLKOUT~2~150}] -min 1.750 [get_ports {ddr4_RRESP_0[1] ddr4_RRESP_0[0]}]
set_input_delay -clock iACLK -reference_pin [get_ports {iACLK~CLKOUT~2~150}] -max 2.625 [get_ports {ddr4_RVALID_0}]
set_input_delay -clock iACLK -reference_pin [get_ports {iACLK~CLKOUT~2~150}] -min 1.750 [get_ports {ddr4_RVALID_0}]
set_input_delay -clock iACLK -reference_pin [get_ports {iACLK~CLKOUT~2~150}] -max 2.625 [get_ports {ddr4_WREADY_0}]
set_input_delay -clock iACLK -reference_pin [get_ports {iACLK~CLKOUT~2~150}] -min 1.750 [get_ports {ddr4_WREADY_0}]
set_output_delay -clock iACLK -reference_pin [get_ports {iACLK~CLKOUT~1~338}] -max 3.675 [get_ports {ddr4_ARSTN_1}]
set_output_delay -clock iACLK -reference_pin [get_ports {iACLK~CLKOUT~1~338}] -min -0.000 [get_ports {ddr4_ARSTN_1}]
set_output_delay -clock iACLK -reference_pin [get_ports {iACLK~CLKOUT~1~338}] -max 2.310 [get_ports {ddr4_ARADDR_1[*]}]
set_output_delay -clock iACLK -reference_pin [get_ports {iACLK~CLKOUT~1~338}] -min -0.140 [get_ports {ddr4_ARADDR_1[*]}]
set_output_delay -clock iACLK -reference_pin [get_ports {iACLK~CLKOUT~1~338}] -max 2.310 [get_ports {ddr4_ARAPCMD_1}]
set_output_delay -clock iACLK -reference_pin [get_ports {iACLK~CLKOUT~1~338}] -min -0.140 [get_ports {ddr4_ARAPCMD_1}]
set_output_delay -clock iACLK -reference_pin [get_ports {iACLK~CLKOUT~1~338}] -max 2.310 [get_ports {ddr4_ARBURST_1[1] ddr4_ARBURST_1[0]}]
set_output_delay -clock iACLK -reference_pin [get_ports {iACLK~CLKOUT~1~338}] -min -0.140 [get_ports {ddr4_ARBURST_1[1] ddr4_ARBURST_1[0]}]
set_output_delay -clock iACLK -reference_pin [get_ports {iACLK~CLKOUT~1~338}] -max 2.310 [get_ports {ddr4_ARID_1[*]}]
set_output_delay -clock iACLK -reference_pin [get_ports {iACLK~CLKOUT~1~338}] -min -0.140 [get_ports {ddr4_ARID_1[*]}]
set_output_delay -clock iACLK -reference_pin [get_ports {iACLK~CLKOUT~1~338}] -max 2.310 [get_ports {ddr4_ARLEN_1[*]}]
set_output_delay -clock iACLK -reference_pin [get_ports {iACLK~CLKOUT~1~338}] -min -0.140 [get_ports {ddr4_ARLEN_1[*]}]
set_output_delay -clock iACLK -reference_pin [get_ports {iACLK~CLKOUT~1~338}] -max 2.310 [get_ports {ddr4_ARSIZE_1[2] ddr4_ARSIZE_1[1] ddr4_ARSIZE_1[0]}]
set_output_delay -clock iACLK -reference_pin [get_ports {iACLK~CLKOUT~1~338}] -min -0.140 [get_ports {ddr4_ARSIZE_1[2] ddr4_ARSIZE_1[1] ddr4_ARSIZE_1[0]}]
set_output_delay -clock iACLK -reference_pin [get_ports {iACLK~CLKOUT~1~338}] -max 2.310 [get_ports {ddr4_ARVALID_1}]
set_output_delay -clock iACLK -reference_pin [get_ports {iACLK~CLKOUT~1~338}] -min -0.140 [get_ports {ddr4_ARVALID_1}]
set_output_delay -clock iACLK -reference_pin [get_ports {iACLK~CLKOUT~1~338}] -max 2.310 [get_ports {ddr4_ARLOCK_1}]
set_output_delay -clock iACLK -reference_pin [get_ports {iACLK~CLKOUT~1~338}] -min -0.140 [get_ports {ddr4_ARLOCK_1}]
set_output_delay -clock iACLK -reference_pin [get_ports {iACLK~CLKOUT~1~338}] -max 2.310 [get_ports {ddr4_ARQOS_1}]
set_output_delay -clock iACLK -reference_pin [get_ports {iACLK~CLKOUT~1~338}] -min -0.140 [get_ports {ddr4_ARQOS_1}]
set_output_delay -clock iACLK -reference_pin [get_ports {iACLK~CLKOUT~1~338}] -max 2.310 [get_ports {ddr4_AWADDR_1[*]}]
set_output_delay -clock iACLK -reference_pin [get_ports {iACLK~CLKOUT~1~338}] -min -0.140 [get_ports {ddr4_AWADDR_1[*]}]
set_output_delay -clock iACLK -reference_pin [get_ports {iACLK~CLKOUT~1~338}] -max 2.310 [get_ports {ddr4_AWAPCMD_1}]
set_output_delay -clock iACLK -reference_pin [get_ports {iACLK~CLKOUT~1~338}] -min -0.350 [get_ports {ddr4_AWAPCMD_1}]
set_output_delay -clock iACLK -reference_pin [get_ports {iACLK~CLKOUT~1~338}] -max 2.310 [get_ports {ddr4_AWALLSTRB_1}]
set_output_delay -clock iACLK -reference_pin [get_ports {iACLK~CLKOUT~1~338}] -min -0.140 [get_ports {ddr4_AWALLSTRB_1}]
set_output_delay -clock iACLK -reference_pin [get_ports {iACLK~CLKOUT~1~338}] -max 2.310 [get_ports {ddr4_AWBURST_1[1] ddr4_AWBURST_1[0]}]
set_output_delay -clock iACLK -reference_pin [get_ports {iACLK~CLKOUT~1~338}] -min -0.140 [get_ports {ddr4_AWBURST_1[1] ddr4_AWBURST_1[0]}]
set_output_delay -clock iACLK -reference_pin [get_ports {iACLK~CLKOUT~1~338}] -max 2.310 [get_ports {ddr4_AWCOBUF_1}]
set_output_delay -clock iACLK -reference_pin [get_ports {iACLK~CLKOUT~1~338}] -min -0.140 [get_ports {ddr4_AWCOBUF_1}]
set_output_delay -clock iACLK -reference_pin [get_ports {iACLK~CLKOUT~1~338}] -max 2.310 [get_ports {ddr4_AWID_1[*]}]
set_output_delay -clock iACLK -reference_pin [get_ports {iACLK~CLKOUT~1~338}] -min -0.140 [get_ports {ddr4_AWID_1[*]}]
set_output_delay -clock iACLK -reference_pin [get_ports {iACLK~CLKOUT~1~338}] -max 2.310 [get_ports {ddr4_AWLEN_1[*]}]
set_output_delay -clock iACLK -reference_pin [get_ports {iACLK~CLKOUT~1~338}] -min -0.140 [get_ports {ddr4_AWLEN_1[*]}]
set_output_delay -clock iACLK -reference_pin [get_ports {iACLK~CLKOUT~1~338}] -max 2.310 [get_ports {ddr4_AWSIZE_1[2] ddr4_AWSIZE_1[1] ddr4_AWSIZE_1[0]}]
set_output_delay -clock iACLK -reference_pin [get_ports {iACLK~CLKOUT~1~338}] -min -0.140 [get_ports {ddr4_AWSIZE_1[2] ddr4_AWSIZE_1[1] ddr4_AWSIZE_1[0]}]
set_output_delay -clock iACLK -reference_pin [get_ports {iACLK~CLKOUT~1~338}] -max 2.310 [get_ports {ddr4_AWVALID_1}]
set_output_delay -clock iACLK -reference_pin [get_ports {iACLK~CLKOUT~1~338}] -min -0.140 [get_ports {ddr4_AWVALID_1}]
set_output_delay -clock iACLK -reference_pin [get_ports {iACLK~CLKOUT~1~338}] -max 2.310 [get_ports {ddr4_AWLOCK_1}]
set_output_delay -clock iACLK -reference_pin [get_ports {iACLK~CLKOUT~1~338}] -min -0.140 [get_ports {ddr4_AWLOCK_1}]
set_output_delay -clock iACLK -reference_pin [get_ports {iACLK~CLKOUT~1~338}] -max 2.310 [get_ports {ddr4_AWCACHE_1[3] ddr4_AWCACHE_1[2] ddr4_AWCACHE_1[1] ddr4_AWCACHE_1[0]}]
set_output_delay -clock iACLK -reference_pin [get_ports {iACLK~CLKOUT~1~338}] -min -0.140 [get_ports {ddr4_AWCACHE_1[3] ddr4_AWCACHE_1[2] ddr4_AWCACHE_1[1] ddr4_AWCACHE_1[0]}]
set_output_delay -clock iACLK -reference_pin [get_ports {iACLK~CLKOUT~1~338}] -max 2.310 [get_ports {ddr4_AWQOS_1}]
set_output_delay -clock iACLK -reference_pin [get_ports {iACLK~CLKOUT~1~338}] -min -0.140 [get_ports {ddr4_AWQOS_1}]
set_output_delay -clock iACLK -reference_pin [get_ports {iACLK~CLKOUT~1~338}] -max 2.310 [get_ports {ddr4_BREADY_1}]
set_output_delay -clock iACLK -reference_pin [get_ports {iACLK~CLKOUT~1~338}] -min -0.140 [get_ports {ddr4_BREADY_1}]
set_output_delay -clock iACLK -reference_pin [get_ports {iACLK~CLKOUT~1~338}] -max 2.310 [get_ports {ddr4_RREADY_1}]
set_output_delay -clock iACLK -reference_pin [get_ports {iACLK~CLKOUT~1~338}] -min -0.140 [get_ports {ddr4_RREADY_1}]
set_output_delay -clock iACLK -reference_pin [get_ports {iACLK~CLKOUT~1~338}] -max 2.310 [get_ports {ddr4_WDATA_1[*]}]
set_output_delay -clock iACLK -reference_pin [get_ports {iACLK~CLKOUT~1~338}] -min -0.140 [get_ports {ddr4_WDATA_1[*]}]
set_output_delay -clock iACLK -reference_pin [get_ports {iACLK~CLKOUT~1~338}] -max 2.310 [get_ports {ddr4_WLAST_1}]
set_output_delay -clock iACLK -reference_pin [get_ports {iACLK~CLKOUT~1~338}] -min -0.140 [get_ports {ddr4_WLAST_1}]
set_output_delay -clock iACLK -reference_pin [get_ports {iACLK~CLKOUT~1~338}] -max 2.310 [get_ports {ddr4_WSTRB_1[*]}]
set_output_delay -clock iACLK -reference_pin [get_ports {iACLK~CLKOUT~1~338}] -min -0.140 [get_ports {ddr4_WSTRB_1[*]}]
set_output_delay -clock iACLK -reference_pin [get_ports {iACLK~CLKOUT~1~338}] -max 2.310 [get_ports {ddr4_WVALID_1}]
set_output_delay -clock iACLK -reference_pin [get_ports {iACLK~CLKOUT~1~338}] -min -0.140 [get_ports {ddr4_WVALID_1}]
set_input_delay -clock iACLK -reference_pin [get_ports {iACLK~CLKOUT~1~338}] -max 2.625 [get_ports {ddr4_ARREADY_1}]
set_input_delay -clock iACLK -reference_pin [get_ports {iACLK~CLKOUT~1~338}] -min 1.750 [get_ports {ddr4_ARREADY_1}]
set_input_delay -clock iACLK -reference_pin [get_ports {iACLK~CLKOUT~1~338}] -max 2.520 [get_ports {ddr4_AWREADY_1}]
set_input_delay -clock iACLK -reference_pin [get_ports {iACLK~CLKOUT~1~338}] -min 1.680 [get_ports {ddr4_AWREADY_1}]
set_input_delay -clock iACLK -reference_pin [get_ports {iACLK~CLKOUT~1~338}] -max 2.520 [get_ports {ddr4_BID_1[*]}]
set_input_delay -clock iACLK -reference_pin [get_ports {iACLK~CLKOUT~1~338}] -min 1.680 [get_ports {ddr4_BID_1[*]}]
set_input_delay -clock iACLK -reference_pin [get_ports {iACLK~CLKOUT~1~338}] -max 2.625 [get_ports {ddr4_BRESP_1[1] ddr4_BRESP_1[0]}]
set_input_delay -clock iACLK -reference_pin [get_ports {iACLK~CLKOUT~1~338}] -min 1.750 [get_ports {ddr4_BRESP_1[1] ddr4_BRESP_1[0]}]
set_input_delay -clock iACLK -reference_pin [get_ports {iACLK~CLKOUT~1~338}] -max 2.625 [get_ports {ddr4_BVALID_1}]
set_input_delay -clock iACLK -reference_pin [get_ports {iACLK~CLKOUT~1~338}] -min 1.750 [get_ports {ddr4_BVALID_1}]
set_input_delay -clock iACLK -reference_pin [get_ports {iACLK~CLKOUT~1~338}] -max 2.625 [get_ports {ddr4_RDATA_1[*]}]
set_input_delay -clock iACLK -reference_pin [get_ports {iACLK~CLKOUT~1~338}] -min 1.750 [get_ports {ddr4_RDATA_1[*]}]
set_input_delay -clock iACLK -reference_pin [get_ports {iACLK~CLKOUT~1~338}] -max 2.625 [get_ports {ddr4_RID_1[*]}]
set_input_delay -clock iACLK -reference_pin [get_ports {iACLK~CLKOUT~1~338}] -min 1.750 [get_ports {ddr4_RID_1[*]}]
set_input_delay -clock iACLK -reference_pin [get_ports {iACLK~CLKOUT~1~338}] -max 2.625 [get_ports {ddr4_RLAST_1}]
set_input_delay -clock iACLK -reference_pin [get_ports {iACLK~CLKOUT~1~338}] -min 1.750 [get_ports {ddr4_RLAST_1}]
set_input_delay -clock iACLK -reference_pin [get_ports {iACLK~CLKOUT~1~338}] -max 2.625 [get_ports {ddr4_RRESP_1[1] ddr4_RRESP_1[0]}]
set_input_delay -clock iACLK -reference_pin [get_ports {iACLK~CLKOUT~1~338}] -min 1.750 [get_ports {ddr4_RRESP_1[1] ddr4_RRESP_1[0]}]
set_input_delay -clock iACLK -reference_pin [get_ports {iACLK~CLKOUT~1~338}] -max 2.625 [get_ports {ddr4_RVALID_1}]
set_input_delay -clock iACLK -reference_pin [get_ports {iACLK~CLKOUT~1~338}] -min 1.750 [get_ports {ddr4_RVALID_1}]
set_input_delay -clock iACLK -reference_pin [get_ports {iACLK~CLKOUT~1~338}] -max 2.625 [get_ports {ddr4_WREADY_1}]
set_input_delay -clock iACLK -reference_pin [get_ports {iACLK~CLKOUT~1~338}] -min 1.750 [get_ports {ddr4_WREADY_1}]

# HSIO GPIO Constraints
#########################
# set_input_delay -clock <CLOCK> [-reference_pin <clkout_pad>] -max <MAX CALCULATION> [get_ports {inPbSwX[0]}]
# set_input_delay -clock <CLOCK> [-reference_pin <clkout_pad>] -min <MIN CALCULATION> [get_ports {inPbSwX[0]}]
# set_input_delay -clock <CLOCK> [-reference_pin <clkout_pad>] -max <MAX CALCULATION> [get_ports {inPbSwX[1]}]
# set_input_delay -clock <CLOCK> [-reference_pin <clkout_pad>] -min <MIN CALCULATION> [get_ports {inPbSwX[1]}]
# set_output_delay -clock <CLOCK> [-reference_pin <clkout_pad>] -max <MAX CALCULATION> [get_ports {oLedX[2]}]
# set_output_delay -clock <CLOCK> [-reference_pin <clkout_pad>] -min <MIN CALCULATION> [get_ports {oLedX[2]}]
# set_output_delay -clock <CLOCK> [-reference_pin <clkout_pad>] -max <MAX CALCULATION> [get_ports {oLedX[3]}]
# set_output_delay -clock <CLOCK> [-reference_pin <clkout_pad>] -min <MIN CALCULATION> [get_ports {oLedX[3]}]
# set_output_delay -clock <CLOCK> [-reference_pin <clkout_pad>] -max <MAX CALCULATION> [get_ports {oLedX[4]}]
# set_output_delay -clock <CLOCK> [-reference_pin <clkout_pad>] -min <MIN CALCULATION> [get_ports {oLedX[4]}]
# set_output_delay -clock <CLOCK> [-reference_pin <clkout_pad>] -max <MAX CALCULATION> [get_ports {oLedX[5]}]
# set_output_delay -clock <CLOCK> [-reference_pin <clkout_pad>] -min <MIN CALCULATION> [get_ports {oLedX[5]}]
# set_output_delay -clock <CLOCK> [-reference_pin <clkout_pad>] -max <MAX CALCULATION> [get_ports {oLedX[6]}]
# set_output_delay -clock <CLOCK> [-reference_pin <clkout_pad>] -min <MIN CALCULATION> [get_ports {oLedX[6]}]
# set_output_delay -clock <CLOCK> [-reference_pin <clkout_pad>] -max <MAX CALCULATION> [get_ports {oLedX[7]}]
# set_output_delay -clock <CLOCK> [-reference_pin <clkout_pad>] -min <MIN CALCULATION> [get_ports {oLedX[7]}]

# Clockout Interface
######################
# ddr4 -clock iACLK -reference_pin [get_ports {iACLK~CLKOUT~1~338}]
# ddr4 -clock iACLK -reference_pin [get_ports {iACLK~CLKOUT~2~150}]
