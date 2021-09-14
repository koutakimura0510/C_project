-- ==============================================================
-- RTL generated by Vitis HLS - High-Level Synthesis from C, C++ and OpenCL v2020.2 (64-bit)
-- Version: 2020.2
-- Copyright (C) Copyright 1986-2020 Xilinx, Inc. All Rights Reserved.
-- 
-- ===========================================================

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity background_loop_dataflow_parent_loop_proc is
port (
    height : IN STD_LOGIC_VECTOR (31 downto 0);
    m_axi_copy_AWVALID : OUT STD_LOGIC;
    m_axi_copy_AWREADY : IN STD_LOGIC;
    m_axi_copy_AWADDR : OUT STD_LOGIC_VECTOR (63 downto 0);
    m_axi_copy_AWID : OUT STD_LOGIC_VECTOR (0 downto 0);
    m_axi_copy_AWLEN : OUT STD_LOGIC_VECTOR (31 downto 0);
    m_axi_copy_AWSIZE : OUT STD_LOGIC_VECTOR (2 downto 0);
    m_axi_copy_AWBURST : OUT STD_LOGIC_VECTOR (1 downto 0);
    m_axi_copy_AWLOCK : OUT STD_LOGIC_VECTOR (1 downto 0);
    m_axi_copy_AWCACHE : OUT STD_LOGIC_VECTOR (3 downto 0);
    m_axi_copy_AWPROT : OUT STD_LOGIC_VECTOR (2 downto 0);
    m_axi_copy_AWQOS : OUT STD_LOGIC_VECTOR (3 downto 0);
    m_axi_copy_AWREGION : OUT STD_LOGIC_VECTOR (3 downto 0);
    m_axi_copy_AWUSER : OUT STD_LOGIC_VECTOR (0 downto 0);
    m_axi_copy_WVALID : OUT STD_LOGIC;
    m_axi_copy_WREADY : IN STD_LOGIC;
    m_axi_copy_WDATA : OUT STD_LOGIC_VECTOR (31 downto 0);
    m_axi_copy_WSTRB : OUT STD_LOGIC_VECTOR (3 downto 0);
    m_axi_copy_WLAST : OUT STD_LOGIC;
    m_axi_copy_WID : OUT STD_LOGIC_VECTOR (0 downto 0);
    m_axi_copy_WUSER : OUT STD_LOGIC_VECTOR (0 downto 0);
    m_axi_copy_ARVALID : OUT STD_LOGIC;
    m_axi_copy_ARREADY : IN STD_LOGIC;
    m_axi_copy_ARADDR : OUT STD_LOGIC_VECTOR (63 downto 0);
    m_axi_copy_ARID : OUT STD_LOGIC_VECTOR (0 downto 0);
    m_axi_copy_ARLEN : OUT STD_LOGIC_VECTOR (31 downto 0);
    m_axi_copy_ARSIZE : OUT STD_LOGIC_VECTOR (2 downto 0);
    m_axi_copy_ARBURST : OUT STD_LOGIC_VECTOR (1 downto 0);
    m_axi_copy_ARLOCK : OUT STD_LOGIC_VECTOR (1 downto 0);
    m_axi_copy_ARCACHE : OUT STD_LOGIC_VECTOR (3 downto 0);
    m_axi_copy_ARPROT : OUT STD_LOGIC_VECTOR (2 downto 0);
    m_axi_copy_ARQOS : OUT STD_LOGIC_VECTOR (3 downto 0);
    m_axi_copy_ARREGION : OUT STD_LOGIC_VECTOR (3 downto 0);
    m_axi_copy_ARUSER : OUT STD_LOGIC_VECTOR (0 downto 0);
    m_axi_copy_RVALID : IN STD_LOGIC;
    m_axi_copy_RREADY : OUT STD_LOGIC;
    m_axi_copy_RDATA : IN STD_LOGIC_VECTOR (31 downto 0);
    m_axi_copy_RLAST : IN STD_LOGIC;
    m_axi_copy_RID : IN STD_LOGIC_VECTOR (0 downto 0);
    m_axi_copy_RUSER : IN STD_LOGIC_VECTOR (0 downto 0);
    m_axi_copy_RRESP : IN STD_LOGIC_VECTOR (1 downto 0);
    m_axi_copy_BVALID : IN STD_LOGIC;
    m_axi_copy_BREADY : OUT STD_LOGIC;
    m_axi_copy_BRESP : IN STD_LOGIC_VECTOR (1 downto 0);
    m_axi_copy_BID : IN STD_LOGIC_VECTOR (0 downto 0);
    m_axi_copy_BUSER : IN STD_LOGIC_VECTOR (0 downto 0);
    frame_size : IN STD_LOGIC_VECTOR (31 downto 0);
    width : IN STD_LOGIC_VECTOR (31 downto 0);
    ddr_copy : IN STD_LOGIC_VECTOR (63 downto 0);
    ycopy_V_address0 : OUT STD_LOGIC_VECTOR (9 downto 0);
    ycopy_V_ce0 : OUT STD_LOGIC;
    ycopy_V_d0 : OUT STD_LOGIC_VECTOR (31 downto 0);
    ycopy_V_q0 : IN STD_LOGIC_VECTOR (31 downto 0);
    ycopy_V_we0 : OUT STD_LOGIC;
    ycopy_V_address1 : OUT STD_LOGIC_VECTOR (9 downto 0);
    ycopy_V_ce1 : OUT STD_LOGIC;
    ycopy_V_d1 : OUT STD_LOGIC_VECTOR (31 downto 0);
    ycopy_V_q1 : IN STD_LOGIC_VECTOR (31 downto 0);
    ycopy_V_we1 : OUT STD_LOGIC;
    ap_clk : IN STD_LOGIC;
    ap_rst : IN STD_LOGIC;
    frame_size_ap_vld : IN STD_LOGIC;
    width_ap_vld : IN STD_LOGIC;
    ddr_copy_ap_vld : IN STD_LOGIC;
    ap_start : IN STD_LOGIC;
    ap_done : OUT STD_LOGIC;
    ap_ready : OUT STD_LOGIC;
    ap_idle : OUT STD_LOGIC;
    ap_continue : IN STD_LOGIC );
end;


architecture behav of background_loop_dataflow_parent_loop_proc is 
    constant ap_const_lv10_0 : STD_LOGIC_VECTOR (9 downto 0) := "0000000000";
    constant ap_const_logic_0 : STD_LOGIC := '0';
    constant ap_const_lv32_0 : STD_LOGIC_VECTOR (31 downto 0) := "00000000000000000000000000000000";
    constant ap_const_logic_1 : STD_LOGIC := '1';
    constant ap_const_boolean_1 : BOOLEAN := true;
    constant ap_const_lv32_1 : STD_LOGIC_VECTOR (31 downto 0) := "00000000000000000000000000000001";
    constant ap_const_lv2_0 : STD_LOGIC_VECTOR (1 downto 0) := "00";
    constant ap_const_lv2_1 : STD_LOGIC_VECTOR (1 downto 0) := "01";
    constant ap_const_lv1_0 : STD_LOGIC_VECTOR (0 downto 0) := "0";
    constant ap_const_lv1_1 : STD_LOGIC_VECTOR (0 downto 0) := "1";
    constant ap_const_lv64_0 : STD_LOGIC_VECTOR (63 downto 0) := "0000000000000000000000000000000000000000000000000000000000000000";
    constant ap_const_lv64_1 : STD_LOGIC_VECTOR (63 downto 0) := "0000000000000000000000000000000000000000000000000000000000000001";
    constant ap_const_lv3_0 : STD_LOGIC_VECTOR (2 downto 0) := "000";
    constant ap_const_lv3_1 : STD_LOGIC_VECTOR (2 downto 0) := "001";
    constant ap_const_lv4_0 : STD_LOGIC_VECTOR (3 downto 0) := "0000";
    constant ap_const_lv4_1 : STD_LOGIC_VECTOR (3 downto 0) := "0001";

attribute shreg_extract : string;
    signal dataflow_in_loop_copy_U0_m_axi_copy_AWVALID : STD_LOGIC;
    signal dataflow_in_loop_copy_U0_m_axi_copy_AWADDR : STD_LOGIC_VECTOR (63 downto 0);
    signal dataflow_in_loop_copy_U0_m_axi_copy_AWID : STD_LOGIC_VECTOR (0 downto 0);
    signal dataflow_in_loop_copy_U0_m_axi_copy_AWLEN : STD_LOGIC_VECTOR (31 downto 0);
    signal dataflow_in_loop_copy_U0_m_axi_copy_AWSIZE : STD_LOGIC_VECTOR (2 downto 0);
    signal dataflow_in_loop_copy_U0_m_axi_copy_AWBURST : STD_LOGIC_VECTOR (1 downto 0);
    signal dataflow_in_loop_copy_U0_m_axi_copy_AWLOCK : STD_LOGIC_VECTOR (1 downto 0);
    signal dataflow_in_loop_copy_U0_m_axi_copy_AWCACHE : STD_LOGIC_VECTOR (3 downto 0);
    signal dataflow_in_loop_copy_U0_m_axi_copy_AWPROT : STD_LOGIC_VECTOR (2 downto 0);
    signal dataflow_in_loop_copy_U0_m_axi_copy_AWQOS : STD_LOGIC_VECTOR (3 downto 0);
    signal dataflow_in_loop_copy_U0_m_axi_copy_AWREGION : STD_LOGIC_VECTOR (3 downto 0);
    signal dataflow_in_loop_copy_U0_m_axi_copy_AWUSER : STD_LOGIC_VECTOR (0 downto 0);
    signal dataflow_in_loop_copy_U0_m_axi_copy_WVALID : STD_LOGIC;
    signal dataflow_in_loop_copy_U0_m_axi_copy_WDATA : STD_LOGIC_VECTOR (31 downto 0);
    signal dataflow_in_loop_copy_U0_m_axi_copy_WSTRB : STD_LOGIC_VECTOR (3 downto 0);
    signal dataflow_in_loop_copy_U0_m_axi_copy_WLAST : STD_LOGIC;
    signal dataflow_in_loop_copy_U0_m_axi_copy_WID : STD_LOGIC_VECTOR (0 downto 0);
    signal dataflow_in_loop_copy_U0_m_axi_copy_WUSER : STD_LOGIC_VECTOR (0 downto 0);
    signal dataflow_in_loop_copy_U0_m_axi_copy_ARVALID : STD_LOGIC;
    signal dataflow_in_loop_copy_U0_m_axi_copy_ARADDR : STD_LOGIC_VECTOR (63 downto 0);
    signal dataflow_in_loop_copy_U0_m_axi_copy_ARID : STD_LOGIC_VECTOR (0 downto 0);
    signal dataflow_in_loop_copy_U0_m_axi_copy_ARLEN : STD_LOGIC_VECTOR (31 downto 0);
    signal dataflow_in_loop_copy_U0_m_axi_copy_ARSIZE : STD_LOGIC_VECTOR (2 downto 0);
    signal dataflow_in_loop_copy_U0_m_axi_copy_ARBURST : STD_LOGIC_VECTOR (1 downto 0);
    signal dataflow_in_loop_copy_U0_m_axi_copy_ARLOCK : STD_LOGIC_VECTOR (1 downto 0);
    signal dataflow_in_loop_copy_U0_m_axi_copy_ARCACHE : STD_LOGIC_VECTOR (3 downto 0);
    signal dataflow_in_loop_copy_U0_m_axi_copy_ARPROT : STD_LOGIC_VECTOR (2 downto 0);
    signal dataflow_in_loop_copy_U0_m_axi_copy_ARQOS : STD_LOGIC_VECTOR (3 downto 0);
    signal dataflow_in_loop_copy_U0_m_axi_copy_ARREGION : STD_LOGIC_VECTOR (3 downto 0);
    signal dataflow_in_loop_copy_U0_m_axi_copy_ARUSER : STD_LOGIC_VECTOR (0 downto 0);
    signal dataflow_in_loop_copy_U0_m_axi_copy_RREADY : STD_LOGIC;
    signal dataflow_in_loop_copy_U0_m_axi_copy_BREADY : STD_LOGIC;
    signal dataflow_in_loop_copy_U0_ycopy_V_address0 : STD_LOGIC_VECTOR (9 downto 0);
    signal dataflow_in_loop_copy_U0_ycopy_V_ce0 : STD_LOGIC;
    signal dataflow_in_loop_copy_U0_ycopy_V_d0 : STD_LOGIC_VECTOR (31 downto 0);
    signal dataflow_in_loop_copy_U0_ycopy_V_we0 : STD_LOGIC;
    signal dataflow_in_loop_copy_U0_ycopy_V_address1 : STD_LOGIC_VECTOR (9 downto 0);
    signal dataflow_in_loop_copy_U0_ycopy_V_ce1 : STD_LOGIC;
    signal dataflow_in_loop_copy_U0_ycopy_V_d1 : STD_LOGIC_VECTOR (31 downto 0);
    signal dataflow_in_loop_copy_U0_ycopy_V_we1 : STD_LOGIC;
    signal dataflow_in_loop_copy_U0_ap_start : STD_LOGIC;
    signal dataflow_in_loop_copy_U0_ap_done : STD_LOGIC;
    signal dataflow_in_loop_copy_U0_ap_ready : STD_LOGIC;
    signal dataflow_in_loop_copy_U0_ap_idle : STD_LOGIC;
    signal dataflow_in_loop_copy_U0_ap_continue : STD_LOGIC;
    signal ap_sync_continue : STD_LOGIC;
    signal ap_sync_done : STD_LOGIC;
    signal ap_sync_ready : STD_LOGIC;
    signal loop_dataflow_input_count : STD_LOGIC_VECTOR (31 downto 0) := "00000000000000000000000000000000";
    signal loop_dataflow_output_count : STD_LOGIC_VECTOR (31 downto 0) := "00000000000000000000000000000000";
    signal bound_minus_1 : STD_LOGIC_VECTOR (31 downto 0);
    signal dataflow_in_loop_copy_U0_start_full_n : STD_LOGIC;
    signal dataflow_in_loop_copy_U0_start_write : STD_LOGIC;
    signal ap_ce_reg : STD_LOGIC;

    component background_loop_dataflow_in_loop_copy IS
    port (
        m_axi_copy_AWVALID : OUT STD_LOGIC;
        m_axi_copy_AWREADY : IN STD_LOGIC;
        m_axi_copy_AWADDR : OUT STD_LOGIC_VECTOR (63 downto 0);
        m_axi_copy_AWID : OUT STD_LOGIC_VECTOR (0 downto 0);
        m_axi_copy_AWLEN : OUT STD_LOGIC_VECTOR (31 downto 0);
        m_axi_copy_AWSIZE : OUT STD_LOGIC_VECTOR (2 downto 0);
        m_axi_copy_AWBURST : OUT STD_LOGIC_VECTOR (1 downto 0);
        m_axi_copy_AWLOCK : OUT STD_LOGIC_VECTOR (1 downto 0);
        m_axi_copy_AWCACHE : OUT STD_LOGIC_VECTOR (3 downto 0);
        m_axi_copy_AWPROT : OUT STD_LOGIC_VECTOR (2 downto 0);
        m_axi_copy_AWQOS : OUT STD_LOGIC_VECTOR (3 downto 0);
        m_axi_copy_AWREGION : OUT STD_LOGIC_VECTOR (3 downto 0);
        m_axi_copy_AWUSER : OUT STD_LOGIC_VECTOR (0 downto 0);
        m_axi_copy_WVALID : OUT STD_LOGIC;
        m_axi_copy_WREADY : IN STD_LOGIC;
        m_axi_copy_WDATA : OUT STD_LOGIC_VECTOR (31 downto 0);
        m_axi_copy_WSTRB : OUT STD_LOGIC_VECTOR (3 downto 0);
        m_axi_copy_WLAST : OUT STD_LOGIC;
        m_axi_copy_WID : OUT STD_LOGIC_VECTOR (0 downto 0);
        m_axi_copy_WUSER : OUT STD_LOGIC_VECTOR (0 downto 0);
        m_axi_copy_ARVALID : OUT STD_LOGIC;
        m_axi_copy_ARREADY : IN STD_LOGIC;
        m_axi_copy_ARADDR : OUT STD_LOGIC_VECTOR (63 downto 0);
        m_axi_copy_ARID : OUT STD_LOGIC_VECTOR (0 downto 0);
        m_axi_copy_ARLEN : OUT STD_LOGIC_VECTOR (31 downto 0);
        m_axi_copy_ARSIZE : OUT STD_LOGIC_VECTOR (2 downto 0);
        m_axi_copy_ARBURST : OUT STD_LOGIC_VECTOR (1 downto 0);
        m_axi_copy_ARLOCK : OUT STD_LOGIC_VECTOR (1 downto 0);
        m_axi_copy_ARCACHE : OUT STD_LOGIC_VECTOR (3 downto 0);
        m_axi_copy_ARPROT : OUT STD_LOGIC_VECTOR (2 downto 0);
        m_axi_copy_ARQOS : OUT STD_LOGIC_VECTOR (3 downto 0);
        m_axi_copy_ARREGION : OUT STD_LOGIC_VECTOR (3 downto 0);
        m_axi_copy_ARUSER : OUT STD_LOGIC_VECTOR (0 downto 0);
        m_axi_copy_RVALID : IN STD_LOGIC;
        m_axi_copy_RREADY : OUT STD_LOGIC;
        m_axi_copy_RDATA : IN STD_LOGIC_VECTOR (31 downto 0);
        m_axi_copy_RLAST : IN STD_LOGIC;
        m_axi_copy_RID : IN STD_LOGIC_VECTOR (0 downto 0);
        m_axi_copy_RUSER : IN STD_LOGIC_VECTOR (0 downto 0);
        m_axi_copy_RRESP : IN STD_LOGIC_VECTOR (1 downto 0);
        m_axi_copy_BVALID : IN STD_LOGIC;
        m_axi_copy_BREADY : OUT STD_LOGIC;
        m_axi_copy_BRESP : IN STD_LOGIC_VECTOR (1 downto 0);
        m_axi_copy_BID : IN STD_LOGIC_VECTOR (0 downto 0);
        m_axi_copy_BUSER : IN STD_LOGIC_VECTOR (0 downto 0);
        trunc_ln1345 : IN STD_LOGIC_VECTOR (31 downto 0);
        frame_size : IN STD_LOGIC_VECTOR (31 downto 0);
        width : IN STD_LOGIC_VECTOR (31 downto 0);
        ddr_copy : IN STD_LOGIC_VECTOR (63 downto 0);
        ycopy_V_address0 : OUT STD_LOGIC_VECTOR (9 downto 0);
        ycopy_V_ce0 : OUT STD_LOGIC;
        ycopy_V_d0 : OUT STD_LOGIC_VECTOR (31 downto 0);
        ycopy_V_q0 : IN STD_LOGIC_VECTOR (31 downto 0);
        ycopy_V_we0 : OUT STD_LOGIC;
        ycopy_V_address1 : OUT STD_LOGIC_VECTOR (9 downto 0);
        ycopy_V_ce1 : OUT STD_LOGIC;
        ycopy_V_d1 : OUT STD_LOGIC_VECTOR (31 downto 0);
        ycopy_V_q1 : IN STD_LOGIC_VECTOR (31 downto 0);
        ycopy_V_we1 : OUT STD_LOGIC;
        ap_clk : IN STD_LOGIC;
        ap_rst : IN STD_LOGIC;
        trunc_ln1345_ap_vld : IN STD_LOGIC;
        frame_size_ap_vld : IN STD_LOGIC;
        width_ap_vld : IN STD_LOGIC;
        ddr_copy_ap_vld : IN STD_LOGIC;
        ap_start : IN STD_LOGIC;
        ap_done : OUT STD_LOGIC;
        ap_ready : OUT STD_LOGIC;
        ap_idle : OUT STD_LOGIC;
        ap_continue : IN STD_LOGIC );
    end component;



begin
    dataflow_in_loop_copy_U0 : component background_loop_dataflow_in_loop_copy
    port map (
        m_axi_copy_AWVALID => dataflow_in_loop_copy_U0_m_axi_copy_AWVALID,
        m_axi_copy_AWREADY => ap_const_logic_0,
        m_axi_copy_AWADDR => dataflow_in_loop_copy_U0_m_axi_copy_AWADDR,
        m_axi_copy_AWID => dataflow_in_loop_copy_U0_m_axi_copy_AWID,
        m_axi_copy_AWLEN => dataflow_in_loop_copy_U0_m_axi_copy_AWLEN,
        m_axi_copy_AWSIZE => dataflow_in_loop_copy_U0_m_axi_copy_AWSIZE,
        m_axi_copy_AWBURST => dataflow_in_loop_copy_U0_m_axi_copy_AWBURST,
        m_axi_copy_AWLOCK => dataflow_in_loop_copy_U0_m_axi_copy_AWLOCK,
        m_axi_copy_AWCACHE => dataflow_in_loop_copy_U0_m_axi_copy_AWCACHE,
        m_axi_copy_AWPROT => dataflow_in_loop_copy_U0_m_axi_copy_AWPROT,
        m_axi_copy_AWQOS => dataflow_in_loop_copy_U0_m_axi_copy_AWQOS,
        m_axi_copy_AWREGION => dataflow_in_loop_copy_U0_m_axi_copy_AWREGION,
        m_axi_copy_AWUSER => dataflow_in_loop_copy_U0_m_axi_copy_AWUSER,
        m_axi_copy_WVALID => dataflow_in_loop_copy_U0_m_axi_copy_WVALID,
        m_axi_copy_WREADY => ap_const_logic_0,
        m_axi_copy_WDATA => dataflow_in_loop_copy_U0_m_axi_copy_WDATA,
        m_axi_copy_WSTRB => dataflow_in_loop_copy_U0_m_axi_copy_WSTRB,
        m_axi_copy_WLAST => dataflow_in_loop_copy_U0_m_axi_copy_WLAST,
        m_axi_copy_WID => dataflow_in_loop_copy_U0_m_axi_copy_WID,
        m_axi_copy_WUSER => dataflow_in_loop_copy_U0_m_axi_copy_WUSER,
        m_axi_copy_ARVALID => dataflow_in_loop_copy_U0_m_axi_copy_ARVALID,
        m_axi_copy_ARREADY => m_axi_copy_ARREADY,
        m_axi_copy_ARADDR => dataflow_in_loop_copy_U0_m_axi_copy_ARADDR,
        m_axi_copy_ARID => dataflow_in_loop_copy_U0_m_axi_copy_ARID,
        m_axi_copy_ARLEN => dataflow_in_loop_copy_U0_m_axi_copy_ARLEN,
        m_axi_copy_ARSIZE => dataflow_in_loop_copy_U0_m_axi_copy_ARSIZE,
        m_axi_copy_ARBURST => dataflow_in_loop_copy_U0_m_axi_copy_ARBURST,
        m_axi_copy_ARLOCK => dataflow_in_loop_copy_U0_m_axi_copy_ARLOCK,
        m_axi_copy_ARCACHE => dataflow_in_loop_copy_U0_m_axi_copy_ARCACHE,
        m_axi_copy_ARPROT => dataflow_in_loop_copy_U0_m_axi_copy_ARPROT,
        m_axi_copy_ARQOS => dataflow_in_loop_copy_U0_m_axi_copy_ARQOS,
        m_axi_copy_ARREGION => dataflow_in_loop_copy_U0_m_axi_copy_ARREGION,
        m_axi_copy_ARUSER => dataflow_in_loop_copy_U0_m_axi_copy_ARUSER,
        m_axi_copy_RVALID => m_axi_copy_RVALID,
        m_axi_copy_RREADY => dataflow_in_loop_copy_U0_m_axi_copy_RREADY,
        m_axi_copy_RDATA => m_axi_copy_RDATA,
        m_axi_copy_RLAST => m_axi_copy_RLAST,
        m_axi_copy_RID => m_axi_copy_RID,
        m_axi_copy_RUSER => m_axi_copy_RUSER,
        m_axi_copy_RRESP => m_axi_copy_RRESP,
        m_axi_copy_BVALID => ap_const_logic_0,
        m_axi_copy_BREADY => dataflow_in_loop_copy_U0_m_axi_copy_BREADY,
        m_axi_copy_BRESP => ap_const_lv2_0,
        m_axi_copy_BID => ap_const_lv1_0,
        m_axi_copy_BUSER => ap_const_lv1_0,
        trunc_ln1345 => loop_dataflow_input_count,
        frame_size => frame_size,
        width => width,
        ddr_copy => ddr_copy,
        ycopy_V_address0 => dataflow_in_loop_copy_U0_ycopy_V_address0,
        ycopy_V_ce0 => dataflow_in_loop_copy_U0_ycopy_V_ce0,
        ycopy_V_d0 => dataflow_in_loop_copy_U0_ycopy_V_d0,
        ycopy_V_q0 => ap_const_lv32_0,
        ycopy_V_we0 => dataflow_in_loop_copy_U0_ycopy_V_we0,
        ycopy_V_address1 => dataflow_in_loop_copy_U0_ycopy_V_address1,
        ycopy_V_ce1 => dataflow_in_loop_copy_U0_ycopy_V_ce1,
        ycopy_V_d1 => dataflow_in_loop_copy_U0_ycopy_V_d1,
        ycopy_V_q1 => ap_const_lv32_0,
        ycopy_V_we1 => dataflow_in_loop_copy_U0_ycopy_V_we1,
        ap_clk => ap_clk,
        ap_rst => ap_rst,
        trunc_ln1345_ap_vld => ap_const_logic_0,
        frame_size_ap_vld => frame_size_ap_vld,
        width_ap_vld => width_ap_vld,
        ddr_copy_ap_vld => ddr_copy_ap_vld,
        ap_start => dataflow_in_loop_copy_U0_ap_start,
        ap_done => dataflow_in_loop_copy_U0_ap_done,
        ap_ready => dataflow_in_loop_copy_U0_ap_ready,
        ap_idle => dataflow_in_loop_copy_U0_ap_idle,
        ap_continue => dataflow_in_loop_copy_U0_ap_continue);





    loop_dataflow_input_count_assign_proc : process(ap_clk)
    begin
        if (ap_clk'event and ap_clk =  '1') then
            if (ap_rst = '1') then
                loop_dataflow_input_count <= ap_const_lv32_0;
            else
                if ((not((loop_dataflow_input_count = bound_minus_1)) and (ap_start = ap_const_logic_1) and (dataflow_in_loop_copy_U0_ap_ready = ap_const_logic_1))) then 
                    loop_dataflow_input_count <= std_logic_vector(unsigned(loop_dataflow_input_count) + unsigned(ap_const_lv32_1));
                elsif (((loop_dataflow_input_count = bound_minus_1) and (ap_start = ap_const_logic_1) and (dataflow_in_loop_copy_U0_ap_ready = ap_const_logic_1))) then 
                    loop_dataflow_input_count <= ap_const_lv32_0;
                end if; 
            end if;
        end if;
    end process;


    loop_dataflow_output_count_assign_proc : process(ap_clk)
    begin
        if (ap_clk'event and ap_clk =  '1') then
            if (ap_rst = '1') then
                loop_dataflow_output_count <= ap_const_lv32_0;
            else
                if ((not((loop_dataflow_output_count = bound_minus_1)) and (dataflow_in_loop_copy_U0_ap_continue = ap_const_logic_1) and (dataflow_in_loop_copy_U0_ap_done = ap_const_logic_1))) then 
                    loop_dataflow_output_count <= std_logic_vector(unsigned(loop_dataflow_output_count) + unsigned(ap_const_lv32_1));
                elsif (((loop_dataflow_output_count = bound_minus_1) and (dataflow_in_loop_copy_U0_ap_continue = ap_const_logic_1) and (dataflow_in_loop_copy_U0_ap_done = ap_const_logic_1))) then 
                    loop_dataflow_output_count <= ap_const_lv32_0;
                end if; 
            end if;
        end if;
    end process;


    ap_done_assign_proc : process(dataflow_in_loop_copy_U0_ap_done, loop_dataflow_output_count, bound_minus_1)
    begin
        if (((loop_dataflow_output_count = bound_minus_1) and (dataflow_in_loop_copy_U0_ap_done = ap_const_logic_1))) then 
            ap_done <= ap_const_logic_1;
        else 
            ap_done <= ap_const_logic_0;
        end if; 
    end process;


    ap_idle_assign_proc : process(dataflow_in_loop_copy_U0_ap_idle, ap_start, loop_dataflow_output_count)
    begin
        if (((loop_dataflow_output_count = ap_const_lv32_0) and (ap_start = ap_const_logic_0) and (dataflow_in_loop_copy_U0_ap_idle = ap_const_logic_1))) then 
            ap_idle <= ap_const_logic_1;
        else 
            ap_idle <= ap_const_logic_0;
        end if; 
    end process;


    ap_ready_assign_proc : process(dataflow_in_loop_copy_U0_ap_ready, ap_start, loop_dataflow_input_count, bound_minus_1)
    begin
        if (((loop_dataflow_input_count = bound_minus_1) and (ap_start = ap_const_logic_1) and (dataflow_in_loop_copy_U0_ap_ready = ap_const_logic_1))) then 
            ap_ready <= ap_const_logic_1;
        else 
            ap_ready <= ap_const_logic_0;
        end if; 
    end process;

    ap_sync_continue <= ap_continue;
    ap_sync_done <= dataflow_in_loop_copy_U0_ap_done;
    ap_sync_ready <= dataflow_in_loop_copy_U0_ap_ready;
    bound_minus_1 <= std_logic_vector(unsigned(height) - unsigned(ap_const_lv32_1));

    dataflow_in_loop_copy_U0_ap_continue_assign_proc : process(ap_continue, loop_dataflow_output_count, bound_minus_1)
    begin
        if ((not((loop_dataflow_output_count = bound_minus_1)) or (ap_continue = ap_const_logic_1))) then 
            dataflow_in_loop_copy_U0_ap_continue <= ap_const_logic_1;
        else 
            dataflow_in_loop_copy_U0_ap_continue <= ap_const_logic_0;
        end if; 
    end process;

    dataflow_in_loop_copy_U0_ap_start <= ap_start;
    dataflow_in_loop_copy_U0_start_full_n <= ap_const_logic_1;
    dataflow_in_loop_copy_U0_start_write <= ap_const_logic_0;
    m_axi_copy_ARADDR <= dataflow_in_loop_copy_U0_m_axi_copy_ARADDR;
    m_axi_copy_ARBURST <= dataflow_in_loop_copy_U0_m_axi_copy_ARBURST;
    m_axi_copy_ARCACHE <= dataflow_in_loop_copy_U0_m_axi_copy_ARCACHE;
    m_axi_copy_ARID <= dataflow_in_loop_copy_U0_m_axi_copy_ARID;
    m_axi_copy_ARLEN <= dataflow_in_loop_copy_U0_m_axi_copy_ARLEN;
    m_axi_copy_ARLOCK <= dataflow_in_loop_copy_U0_m_axi_copy_ARLOCK;
    m_axi_copy_ARPROT <= dataflow_in_loop_copy_U0_m_axi_copy_ARPROT;
    m_axi_copy_ARQOS <= dataflow_in_loop_copy_U0_m_axi_copy_ARQOS;
    m_axi_copy_ARREGION <= dataflow_in_loop_copy_U0_m_axi_copy_ARREGION;
    m_axi_copy_ARSIZE <= dataflow_in_loop_copy_U0_m_axi_copy_ARSIZE;
    m_axi_copy_ARUSER <= dataflow_in_loop_copy_U0_m_axi_copy_ARUSER;
    m_axi_copy_ARVALID <= dataflow_in_loop_copy_U0_m_axi_copy_ARVALID;
    m_axi_copy_AWADDR <= ap_const_lv64_0;
    m_axi_copy_AWBURST <= ap_const_lv2_0;
    m_axi_copy_AWCACHE <= ap_const_lv4_0;
    m_axi_copy_AWID <= ap_const_lv1_0;
    m_axi_copy_AWLEN <= ap_const_lv32_0;
    m_axi_copy_AWLOCK <= ap_const_lv2_0;
    m_axi_copy_AWPROT <= ap_const_lv3_0;
    m_axi_copy_AWQOS <= ap_const_lv4_0;
    m_axi_copy_AWREGION <= ap_const_lv4_0;
    m_axi_copy_AWSIZE <= ap_const_lv3_0;
    m_axi_copy_AWUSER <= ap_const_lv1_0;
    m_axi_copy_AWVALID <= ap_const_logic_0;
    m_axi_copy_BREADY <= ap_const_logic_0;
    m_axi_copy_RREADY <= dataflow_in_loop_copy_U0_m_axi_copy_RREADY;
    m_axi_copy_WDATA <= ap_const_lv32_0;
    m_axi_copy_WID <= ap_const_lv1_0;
    m_axi_copy_WLAST <= ap_const_logic_0;
    m_axi_copy_WSTRB <= ap_const_lv4_0;
    m_axi_copy_WUSER <= ap_const_lv1_0;
    m_axi_copy_WVALID <= ap_const_logic_0;
    ycopy_V_address0 <= dataflow_in_loop_copy_U0_ycopy_V_address0;
    ycopy_V_address1 <= ap_const_lv10_0;
    ycopy_V_ce0 <= dataflow_in_loop_copy_U0_ycopy_V_ce0;
    ycopy_V_ce1 <= ap_const_logic_0;
    ycopy_V_d0 <= dataflow_in_loop_copy_U0_ycopy_V_d0;
    ycopy_V_d1 <= ap_const_lv32_0;
    ycopy_V_we0 <= dataflow_in_loop_copy_U0_ycopy_V_we0;
    ycopy_V_we1 <= ap_const_logic_0;
end behav;
