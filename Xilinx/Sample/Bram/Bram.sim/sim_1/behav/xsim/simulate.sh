#!/bin/bash -f
# ****************************************************************************
# Vivado (TM) v2022.2 (64-bit)
#
# Filename    : simulate.sh
# Simulator   : Xilinx Vivado Simulator
# Description : Script for simulating the design by launching the simulator
#
# Generated by Vivado on Sun Nov 27 13:45:34 JST 2022
# SW Build 3671981 on Fri Oct 14 04:59:54 MDT 2022
#
# IP Build 3669848 on Fri Oct 14 08:30:02 MDT 2022
#
# usage: simulate.sh
#
# ****************************************************************************
set -Eeuo pipefail
# simulate design
echo "xsim BramTop_sim_behav -key {Behavioral:sim_1:Functional:BramTop_sim} -tclbatch BramTop_sim.tcl -view /home/kimura/workspace/ProjectFolder/Xilinx/Sample/Bram/BramTop_sim_behav.wcfg -log simulate.log"
xsim BramTop_sim_behav -key {Behavioral:sim_1:Functional:BramTop_sim} -tclbatch BramTop_sim.tcl -view /home/kimura/workspace/ProjectFolder/Xilinx/Sample/Bram/BramTop_sim_behav.wcfg -log simulate.log

