-- ==============================================================
-- RTL generated by Vitis HLS - High-Level Synthesis from C, C++ and OpenCL v2020.2 (64-bit)
-- Version: 2020.2
-- Copyright (C) Copyright 1986-2020 Xilinx, Inc. All Rights Reserved.
-- 
-- ===========================================================

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity background_loop_dataflow_parent_loop_proc4 is
port (
    height : IN STD_LOGIC_VECTOR (31 downto 0);
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
    m_axi_update_AWVALID : OUT STD_LOGIC;
    m_axi_update_AWREADY : IN STD_LOGIC;
    m_axi_update_AWADDR : OUT STD_LOGIC_VECTOR (63 downto 0);
    m_axi_update_AWID : OUT STD_LOGIC_VECTOR (0 downto 0);
    m_axi_update_AWLEN : OUT STD_LOGIC_VECTOR (31 downto 0);
    m_axi_update_AWSIZE : OUT STD_LOGIC_VECTOR (2 downto 0);
    m_axi_update_AWBURST : OUT STD_LOGIC_VECTOR (1 downto 0);
    m_axi_update_AWLOCK : OUT STD_LOGIC_VECTOR (1 downto 0);
    m_axi_update_AWCACHE : OUT STD_LOGIC_VECTOR (3 downto 0);
    m_axi_update_AWPROT : OUT STD_LOGIC_VECTOR (2 downto 0);
    m_axi_update_AWQOS : OUT STD_LOGIC_VECTOR (3 downto 0);
    m_axi_update_AWREGION : OUT STD_LOGIC_VECTOR (3 downto 0);
    m_axi_update_AWUSER : OUT STD_LOGIC_VECTOR (0 downto 0);
    m_axi_update_WVALID : OUT STD_LOGIC;
    m_axi_update_WREADY : IN STD_LOGIC;
    m_axi_update_WDATA : OUT STD_LOGIC_VECTOR (31 downto 0);
    m_axi_update_WSTRB : OUT STD_LOGIC_VECTOR (3 downto 0);
    m_axi_update_WLAST : OUT STD_LOGIC;
    m_axi_update_WID : OUT STD_LOGIC_VECTOR (0 downto 0);
    m_axi_update_WUSER : OUT STD_LOGIC_VECTOR (0 downto 0);
    m_axi_update_ARVALID : OUT STD_LOGIC;
    m_axi_update_ARREADY : IN STD_LOGIC;
    m_axi_update_ARADDR : OUT STD_LOGIC_VECTOR (63 downto 0);
    m_axi_update_ARID : OUT STD_LOGIC_VECTOR (0 downto 0);
    m_axi_update_ARLEN : OUT STD_LOGIC_VECTOR (31 downto 0);
    m_axi_update_ARSIZE : OUT STD_LOGIC_VECTOR (2 downto 0);
    m_axi_update_ARBURST : OUT STD_LOGIC_VECTOR (1 downto 0);
    m_axi_update_ARLOCK : OUT STD_LOGIC_VECTOR (1 downto 0);
    m_axi_update_ARCACHE : OUT STD_LOGIC_VECTOR (3 downto 0);
    m_axi_update_ARPROT : OUT STD_LOGIC_VECTOR (2 downto 0);
    m_axi_update_ARQOS : OUT STD_LOGIC_VECTOR (3 downto 0);
    m_axi_update_ARREGION : OUT STD_LOGIC_VECTOR (3 downto 0);
    m_axi_update_ARUSER : OUT STD_LOGIC_VECTOR (0 downto 0);
    m_axi_update_RVALID : IN STD_LOGIC;
    m_axi_update_RREADY : OUT STD_LOGIC;
    m_axi_update_RDATA : IN STD_LOGIC_VECTOR (31 downto 0);
    m_axi_update_RLAST : IN STD_LOGIC;
    m_axi_update_RID : IN STD_LOGIC_VECTOR (0 downto 0);
    m_axi_update_RUSER : IN STD_LOGIC_VECTOR (0 downto 0);
    m_axi_update_RRESP : IN STD_LOGIC_VECTOR (1 downto 0);
    m_axi_update_BVALID : IN STD_LOGIC;
    m_axi_update_BREADY : OUT STD_LOGIC;
    m_axi_update_BRESP : IN STD_LOGIC_VECTOR (1 downto 0);
    m_axi_update_BID : IN STD_LOGIC_VECTOR (0 downto 0);
    m_axi_update_BUSER : IN STD_LOGIC_VECTOR (0 downto 0);
    frame_size : IN STD_LOGIC_VECTOR (31 downto 0);
    ddr_update : IN STD_LOGIC_VECTOR (63 downto 0);
    ap_clk : IN STD_LOGIC;
    ap_rst : IN STD_LOGIC;
    frame_size_ap_vld : IN STD_LOGIC;
    ddr_update_ap_vld : IN STD_LOGIC;
    ap_start : IN STD_LOGIC;
    ap_done : OUT STD_LOGIC;
    ap_ready : OUT STD_LOGIC;
    ap_idle : OUT STD_LOGIC;
    ap_continue : IN STD_LOGIC );
end;


architecture behav of background_loop_dataflow_parent_loop_proc4 is 
    constant ap_const_lv10_0 : STD_LOGIC_VECTOR (9 downto 0) := "0000000000";
    constant ap_const_logic_0 : STD_LOGIC := '0';
    constant ap_const_lv32_0 : STD_LOGIC_VECTOR (31 downto 0) := "00000000000000000000000000000000";
    constant ap_const_logic_1 : STD_LOGIC := '1';
    constant ap_const_boolean_1 : BOOLEAN := true;
    constant ap_const_lv32_1 : STD_LOGIC_VECTOR (31 downto 0) := "00000000000000000000000000000001";
    constant ap_const_lv1_0 : STD_LOGIC_VECTOR (0 downto 0) := "0";
    constant ap_const_lv1_1 : STD_LOGIC_VECTOR (0 downto 0) := "1";
    constant ap_const_lv2_0 : STD_LOGIC_VECTOR (1 downto 0) := "00";
    constant ap_const_lv2_1 : STD_LOGIC_VECTOR (1 downto 0) := "01";
    constant ap_const_lv64_0 : STD_LOGIC_VECTOR (63 downto 0) := "0000000000000000000000000000000000000000000000000000000000000000";
    constant ap_const_lv64_1 : STD_LOGIC_VECTOR (63 downto 0) := "0000000000000000000000000000000000000000000000000000000000000001";
    constant ap_const_lv3_0 : STD_LOGIC_VECTOR (2 downto 0) := "000";
    constant ap_const_lv3_1 : STD_LOGIC_VECTOR (2 downto 0) := "001";
    constant ap_const_lv4_0 : STD_LOGIC_VECTOR (3 downto 0) := "0000";
    constant ap_const_lv4_1 : STD_LOGIC_VECTOR (3 downto 0) := "0001";

attribute shreg_extract : string;
    signal dataflow_in_loop_copy2_U0_ycopy_V_address0 : STD_LOGIC_VECTOR (9 downto 0);
    signal dataflow_in_loop_copy2_U0_ycopy_V_ce0 : STD_LOGIC;
    signal dataflow_in_loop_copy2_U0_ycopy_V_d0 : STD_LOGIC_VECTOR (31 downto 0);
    signal dataflow_in_loop_copy2_U0_ycopy_V_we0 : STD_LOGIC;
    signal dataflow_in_loop_copy2_U0_ycopy_V_address1 : STD_LOGIC_VECTOR (9 downto 0);
    signal dataflow_in_loop_copy2_U0_ycopy_V_ce1 : STD_LOGIC;
    signal dataflow_in_loop_copy2_U0_ycopy_V_d1 : STD_LOGIC_VECTOR (31 downto 0);
    signal dataflow_in_loop_copy2_U0_ycopy_V_we1 : STD_LOGIC;
    signal dataflow_in_loop_copy2_U0_m_axi_update_AWVALID : STD_LOGIC;
    signal dataflow_in_loop_copy2_U0_m_axi_update_AWADDR : STD_LOGIC_VECTOR (63 downto 0);
    signal dataflow_in_loop_copy2_U0_m_axi_update_AWID : STD_LOGIC_VECTOR (0 downto 0);
    signal dataflow_in_loop_copy2_U0_m_axi_update_AWLEN : STD_LOGIC_VECTOR (31 downto 0);
    signal dataflow_in_loop_copy2_U0_m_axi_update_AWSIZE : STD_LOGIC_VECTOR (2 downto 0);
    signal dataflow_in_loop_copy2_U0_m_axi_update_AWBURST : STD_LOGIC_VECTOR (1 downto 0);
    signal dataflow_in_loop_copy2_U0_m_axi_update_AWLOCK : STD_LOGIC_VECTOR (1 downto 0);
    signal dataflow_in_loop_copy2_U0_m_axi_update_AWCACHE : STD_LOGIC_VECTOR (3 downto 0);
    signal dataflow_in_loop_copy2_U0_m_axi_update_AWPROT : STD_LOGIC_VECTOR (2 downto 0);
    signal dataflow_in_loop_copy2_U0_m_axi_update_AWQOS : STD_LOGIC_VECTOR (3 downto 0);
    signal dataflow_in_loop_copy2_U0_m_axi_update_AWREGION : STD_LOGIC_VECTOR (3 downto 0);
    signal dataflow_in_loop_copy2_U0_m_axi_update_AWUSER : STD_LOGIC_VECTOR (0 downto 0);
    signal dataflow_in_loop_copy2_U0_m_axi_update_WVALID : STD_LOGIC;
    signal dataflow_in_loop_copy2_U0_m_axi_update_WDATA : STD_LOGIC_VECTOR (31 downto 0);
    signal dataflow_in_loop_copy2_U0_m_axi_update_WSTRB : STD_LOGIC_VECTOR (3 downto 0);
    signal dataflow_in_loop_copy2_U0_m_axi_update_WLAST : STD_LOGIC;
    signal dataflow_in_loop_copy2_U0_m_axi_update_WID : STD_LOGIC_VECTOR (0 downto 0);
    signal dataflow_in_loop_copy2_U0_m_axi_update_WUSER : STD_LOGIC_VECTOR (0 downto 0);
    signal dataflow_in_loop_copy2_U0_m_axi_update_ARVALID : STD_LOGIC;
    signal dataflow_in_loop_copy2_U0_m_axi_update_ARADDR : STD_LOGIC_VECTOR (63 downto 0);
    signal dataflow_in_loop_copy2_U0_m_axi_update_ARID : STD_LOGIC_VECTOR (0 downto 0);
    signal dataflow_in_loop_copy2_U0_m_axi_update_ARLEN : STD_LOGIC_VECTOR (31 downto 0);
    signal dataflow_in_loop_copy2_U0_m_axi_update_ARSIZE : STD_LOGIC_VECTOR (2 downto 0);
    signal dataflow_in_loop_copy2_U0_m_axi_update_ARBURST : STD_LOGIC_VECTOR (1 downto 0);
    signal dataflow_in_loop_copy2_U0_m_axi_update_ARLOCK : STD_LOGIC_VECTOR (1 downto 0);
    signal dataflow_in_loop_copy2_U0_m_axi_update_ARCACHE : STD_LOGIC_VECTOR (3 downto 0);
    signal dataflow_in_loop_copy2_U0_m_axi_update_ARPROT : STD_LOGIC_VECTOR (2 downto 0);
    signal dataflow_in_loop_copy2_U0_m_axi_update_ARQOS : STD_LOGIC_VECTOR (3 downto 0);
    signal dataflow_in_loop_copy2_U0_m_axi_update_ARREGION : STD_LOGIC_VECTOR (3 downto 0);
    signal dataflow_in_loop_copy2_U0_m_axi_update_ARUSER : STD_LOGIC_VECTOR (0 downto 0);
    signal dataflow_in_loop_copy2_U0_m_axi_update_RREADY : STD_LOGIC;
    signal dataflow_in_loop_copy2_U0_m_axi_update_BREADY : STD_LOGIC;
    signal dataflow_in_loop_copy2_U0_ap_start : STD_LOGIC;
    signal dataflow_in_loop_copy2_U0_ap_done : STD_LOGIC;
    signal dataflow_in_loop_copy2_U0_ap_ready : STD_LOGIC;
    signal dataflow_in_loop_copy2_U0_ap_idle : STD_LOGIC;
    signal dataflow_in_loop_copy2_U0_ap_continue : STD_LOGIC;
    signal ap_sync_continue : STD_LOGIC;
    signal ap_sync_done : STD_LOGIC;
    signal ap_sync_ready : STD_LOGIC;
    signal loop_dataflow_input_count : STD_LOGIC_VECTOR (31 downto 0) := "00000000000000000000000000000000";
    signal loop_dataflow_output_count : STD_LOGIC_VECTOR (31 downto 0) := "00000000000000000000000000000000";
    signal bound_minus_1 : STD_LOGIC_VECTOR (31 downto 0);
    signal dataflow_in_loop_copy2_U0_start_full_n : STD_LOGIC;
    signal dataflow_in_loop_copy2_U0_start_write : STD_LOGIC;
    signal ap_ce_reg : STD_LOGIC;

    component background_loop_dataflow_in_loop_copy2 IS
    port (
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
        trunc_ln329 : IN STD_LOGIC_VECTOR (31 downto 0);
        m_axi_update_AWVALID : OUT STD_LOGIC;
        m_axi_update_AWREADY : IN STD_LOGIC;
        m_axi_update_AWADDR : OUT STD_LOGIC_VECTOR (63 downto 0);
        m_axi_update_AWID : OUT STD_LOGIC_VECTOR (0 downto 0);
        m_axi_update_AWLEN : OUT STD_LOGIC_VECTOR (31 downto 0);
        m_axi_update_AWSIZE : OUT STD_LOGIC_VECTOR (2 downto 0);
        m_axi_update_AWBURST : OUT STD_LOGIC_VECTOR (1 downto 0);
        m_axi_update_AWLOCK : OUT STD_LOGIC_VECTOR (1 downto 0);
        m_axi_update_AWCACHE : OUT STD_LOGIC_VECTOR (3 downto 0);
        m_axi_update_AWPROT : OUT STD_LOGIC_VECTOR (2 downto 0);
        m_axi_update_AWQOS : OUT STD_LOGIC_VECTOR (3 downto 0);
        m_axi_update_AWREGION : OUT STD_LOGIC_VECTOR (3 downto 0);
        m_axi_update_AWUSER : OUT STD_LOGIC_VECTOR (0 downto 0);
        m_axi_update_WVALID : OUT STD_LOGIC;
        m_axi_update_WREADY : IN STD_LOGIC;
        m_axi_update_WDATA : OUT STD_LOGIC_VECTOR (31 downto 0);
        m_axi_update_WSTRB : OUT STD_LOGIC_VECTOR (3 downto 0);
        m_axi_update_WLAST : OUT STD_LOGIC;
        m_axi_update_WID : OUT STD_LOGIC_VECTOR (0 downto 0);
        m_axi_update_WUSER : OUT STD_LOGIC_VECTOR (0 downto 0);
        m_axi_update_ARVALID : OUT STD_LOGIC;
        m_axi_update_ARREADY : IN STD_LOGIC;
        m_axi_update_ARADDR : OUT STD_LOGIC_VECTOR (63 downto 0);
        m_axi_update_ARID : OUT STD_LOGIC_VECTOR (0 downto 0);
        m_axi_update_ARLEN : OUT STD_LOGIC_VECTOR (31 downto 0);
        m_axi_update_ARSIZE : OUT STD_LOGIC_VECTOR (2 downto 0);
        m_axi_update_ARBURST : OUT STD_LOGIC_VECTOR (1 downto 0);
        m_axi_update_ARLOCK : OUT STD_LOGIC_VECTOR (1 downto 0);
        m_axi_update_ARCACHE : OUT STD_LOGIC_VECTOR (3 downto 0);
        m_axi_update_ARPROT : OUT STD_LOGIC_VECTOR (2 downto 0);
        m_axi_update_ARQOS : OUT STD_LOGIC_VECTOR (3 downto 0);
        m_axi_update_ARREGION : OUT STD_LOGIC_VECTOR (3 downto 0);
        m_axi_update_ARUSER : OUT STD_LOGIC_VECTOR (0 downto 0);
        m_axi_update_RVALID : IN STD_LOGIC;
        m_axi_update_RREADY : OUT STD_LOGIC;
        m_axi_update_RDATA : IN STD_LOGIC_VECTOR (31 downto 0);
        m_axi_update_RLAST : IN STD_LOGIC;
        m_axi_update_RID : IN STD_LOGIC_VECTOR (0 downto 0);
        m_axi_update_RUSER : IN STD_LOGIC_VECTOR (0 downto 0);
        m_axi_update_RRESP : IN STD_LOGIC_VECTOR (1 downto 0);
        m_axi_update_BVALID : IN STD_LOGIC;
        m_axi_update_BREADY : OUT STD_LOGIC;
        m_axi_update_BRESP : IN STD_LOGIC_VECTOR (1 downto 0);
        m_axi_update_BID : IN STD_LOGIC_VECTOR (0 downto 0);
        m_axi_update_BUSER : IN STD_LOGIC_VECTOR (0 downto 0);
        frame_size : IN STD_LOGIC_VECTOR (31 downto 0);
        ddr_update : IN STD_LOGIC_VECTOR (63 downto 0);
        ap_clk : IN STD_LOGIC;
        ap_rst : IN STD_LOGIC;
        trunc_ln329_ap_vld : IN STD_LOGIC;
        frame_size_ap_vld : IN STD_LOGIC;
        ddr_update_ap_vld : IN STD_LOGIC;
        ap_start : IN STD_LOGIC;
        ap_done : OUT STD_LOGIC;
        ap_ready : OUT STD_LOGIC;
        ap_idle : OUT STD_LOGIC;
        ap_continue : IN STD_LOGIC );
    end component;



begin
    dataflow_in_loop_copy2_U0 : component background_loop_dataflow_in_loop_copy2
    port map (
        ycopy_V_address0 => dataflow_in_loop_copy2_U0_ycopy_V_address0,
        ycopy_V_ce0 => dataflow_in_loop_copy2_U0_ycopy_V_ce0,
        ycopy_V_d0 => dataflow_in_loop_copy2_U0_ycopy_V_d0,
        ycopy_V_q0 => ycopy_V_q0,
        ycopy_V_we0 => dataflow_in_loop_copy2_U0_ycopy_V_we0,
        ycopy_V_address1 => dataflow_in_loop_copy2_U0_ycopy_V_address1,
        ycopy_V_ce1 => dataflow_in_loop_copy2_U0_ycopy_V_ce1,
        ycopy_V_d1 => dataflow_in_loop_copy2_U0_ycopy_V_d1,
        ycopy_V_q1 => ap_const_lv32_0,
        ycopy_V_we1 => dataflow_in_loop_copy2_U0_ycopy_V_we1,
        trunc_ln329 => loop_dataflow_input_count,
        m_axi_update_AWVALID => dataflow_in_loop_copy2_U0_m_axi_update_AWVALID,
        m_axi_update_AWREADY => m_axi_update_AWREADY,
        m_axi_update_AWADDR => dataflow_in_loop_copy2_U0_m_axi_update_AWADDR,
        m_axi_update_AWID => dataflow_in_loop_copy2_U0_m_axi_update_AWID,
        m_axi_update_AWLEN => dataflow_in_loop_copy2_U0_m_axi_update_AWLEN,
        m_axi_update_AWSIZE => dataflow_in_loop_copy2_U0_m_axi_update_AWSIZE,
        m_axi_update_AWBURST => dataflow_in_loop_copy2_U0_m_axi_update_AWBURST,
        m_axi_update_AWLOCK => dataflow_in_loop_copy2_U0_m_axi_update_AWLOCK,
        m_axi_update_AWCACHE => dataflow_in_loop_copy2_U0_m_axi_update_AWCACHE,
        m_axi_update_AWPROT => dataflow_in_loop_copy2_U0_m_axi_update_AWPROT,
        m_axi_update_AWQOS => dataflow_in_loop_copy2_U0_m_axi_update_AWQOS,
        m_axi_update_AWREGION => dataflow_in_loop_copy2_U0_m_axi_update_AWREGION,
        m_axi_update_AWUSER => dataflow_in_loop_copy2_U0_m_axi_update_AWUSER,
        m_axi_update_WVALID => dataflow_in_loop_copy2_U0_m_axi_update_WVALID,
        m_axi_update_WREADY => m_axi_update_WREADY,
        m_axi_update_WDATA => dataflow_in_loop_copy2_U0_m_axi_update_WDATA,
        m_axi_update_WSTRB => dataflow_in_loop_copy2_U0_m_axi_update_WSTRB,
        m_axi_update_WLAST => dataflow_in_loop_copy2_U0_m_axi_update_WLAST,
        m_axi_update_WID => dataflow_in_loop_copy2_U0_m_axi_update_WID,
        m_axi_update_WUSER => dataflow_in_loop_copy2_U0_m_axi_update_WUSER,
        m_axi_update_ARVALID => dataflow_in_loop_copy2_U0_m_axi_update_ARVALID,
        m_axi_update_ARREADY => ap_const_logic_0,
        m_axi_update_ARADDR => dataflow_in_loop_copy2_U0_m_axi_update_ARADDR,
        m_axi_update_ARID => dataflow_in_loop_copy2_U0_m_axi_update_ARID,
        m_axi_update_ARLEN => dataflow_in_loop_copy2_U0_m_axi_update_ARLEN,
        m_axi_update_ARSIZE => dataflow_in_loop_copy2_U0_m_axi_update_ARSIZE,
        m_axi_update_ARBURST => dataflow_in_loop_copy2_U0_m_axi_update_ARBURST,
        m_axi_update_ARLOCK => dataflow_in_loop_copy2_U0_m_axi_update_ARLOCK,
        m_axi_update_ARCACHE => dataflow_in_loop_copy2_U0_m_axi_update_ARCACHE,
        m_axi_update_ARPROT => dataflow_in_loop_copy2_U0_m_axi_update_ARPROT,
        m_axi_update_ARQOS => dataflow_in_loop_copy2_U0_m_axi_update_ARQOS,
        m_axi_update_ARREGION => dataflow_in_loop_copy2_U0_m_axi_update_ARREGION,
        m_axi_update_ARUSER => dataflow_in_loop_copy2_U0_m_axi_update_ARUSER,
        m_axi_update_RVALID => ap_const_logic_0,
        m_axi_update_RREADY => dataflow_in_loop_copy2_U0_m_axi_update_RREADY,
        m_axi_update_RDATA => ap_const_lv32_0,
        m_axi_update_RLAST => ap_const_logic_0,
        m_axi_update_RID => ap_const_lv1_0,
        m_axi_update_RUSER => ap_const_lv1_0,
        m_axi_update_RRESP => ap_const_lv2_0,
        m_axi_update_BVALID => m_axi_update_BVALID,
        m_axi_update_BREADY => dataflow_in_loop_copy2_U0_m_axi_update_BREADY,
        m_axi_update_BRESP => m_axi_update_BRESP,
        m_axi_update_BID => m_axi_update_BID,
        m_axi_update_BUSER => m_axi_update_BUSER,
        frame_size => frame_size,
        ddr_update => ddr_update,
        ap_clk => ap_clk,
        ap_rst => ap_rst,
        trunc_ln329_ap_vld => ap_const_logic_0,
        frame_size_ap_vld => frame_size_ap_vld,
        ddr_update_ap_vld => ddr_update_ap_vld,
        ap_start => dataflow_in_loop_copy2_U0_ap_start,
        ap_done => dataflow_in_loop_copy2_U0_ap_done,
        ap_ready => dataflow_in_loop_copy2_U0_ap_ready,
        ap_idle => dataflow_in_loop_copy2_U0_ap_idle,
        ap_continue => dataflow_in_loop_copy2_U0_ap_continue);





    loop_dataflow_input_count_assign_proc : process(ap_clk)
    begin
        if (ap_clk'event and ap_clk =  '1') then
            if (ap_rst = '1') then
                loop_dataflow_input_count <= ap_const_lv32_0;
            else
                if ((not((loop_dataflow_input_count = bound_minus_1)) and (ap_start = ap_const_logic_1) and (dataflow_in_loop_copy2_U0_ap_ready = ap_const_logic_1))) then 
                    loop_dataflow_input_count <= std_logic_vector(unsigned(loop_dataflow_input_count) + unsigned(ap_const_lv32_1));
                elsif (((loop_dataflow_input_count = bound_minus_1) and (ap_start = ap_const_logic_1) and (dataflow_in_loop_copy2_U0_ap_ready = ap_const_logic_1))) then 
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
                if ((not((loop_dataflow_output_count = bound_minus_1)) and (dataflow_in_loop_copy2_U0_ap_continue = ap_const_logic_1) and (dataflow_in_loop_copy2_U0_ap_done = ap_const_logic_1))) then 
                    loop_dataflow_output_count <= std_logic_vector(unsigned(loop_dataflow_output_count) + unsigned(ap_const_lv32_1));
                elsif (((loop_dataflow_output_count = bound_minus_1) and (dataflow_in_loop_copy2_U0_ap_continue = ap_const_logic_1) and (dataflow_in_loop_copy2_U0_ap_done = ap_const_logic_1))) then 
                    loop_dataflow_output_count <= ap_const_lv32_0;
                end if; 
            end if;
        end if;
    end process;


    ap_done_assign_proc : process(dataflow_in_loop_copy2_U0_ap_done, loop_dataflow_output_count, bound_minus_1)
    begin
        if (((loop_dataflow_output_count = bound_minus_1) and (dataflow_in_loop_copy2_U0_ap_done = ap_const_logic_1))) then 
            ap_done <= ap_const_logic_1;
        else 
            ap_done <= ap_const_logic_0;
        end if; 
    end process;


    ap_idle_assign_proc : process(dataflow_in_loop_copy2_U0_ap_idle, ap_start, loop_dataflow_output_count)
    begin
        if (((loop_dataflow_output_count = ap_const_lv32_0) and (ap_start = ap_const_logic_0) and (dataflow_in_loop_copy2_U0_ap_idle = ap_const_logic_1))) then 
            ap_idle <= ap_const_logic_1;
        else 
            ap_idle <= ap_const_logic_0;
        end if; 
    end process;


    ap_ready_assign_proc : process(dataflow_in_loop_copy2_U0_ap_ready, ap_start, loop_dataflow_input_count, bound_minus_1)
    begin
        if (((loop_dataflow_input_count = bound_minus_1) and (ap_start = ap_const_logic_1) and (dataflow_in_loop_copy2_U0_ap_ready = ap_const_logic_1))) then 
            ap_ready <= ap_const_logic_1;
        else 
            ap_ready <= ap_const_logic_0;
        end if; 
    end process;

    ap_sync_continue <= ap_continue;
    ap_sync_done <= dataflow_in_loop_copy2_U0_ap_done;
    ap_sync_ready <= dataflow_in_loop_copy2_U0_ap_ready;
    bound_minus_1 <= std_logic_vector(unsigned(height) - unsigned(ap_const_lv32_1));

    dataflow_in_loop_copy2_U0_ap_continue_assign_proc : process(ap_continue, loop_dataflow_output_count, bound_minus_1)
    begin
        if ((not((loop_dataflow_output_count = bound_minus_1)) or (ap_continue = ap_const_logic_1))) then 
            dataflow_in_loop_copy2_U0_ap_continue <= ap_const_logic_1;
        else 
            dataflow_in_loop_copy2_U0_ap_continue <= ap_const_logic_0;
        end if; 
    end process;

    dataflow_in_loop_copy2_U0_ap_start <= ap_start;
    dataflow_in_loop_copy2_U0_start_full_n <= ap_const_logic_1;
    dataflow_in_loop_copy2_U0_start_write <= ap_const_logic_0;
    m_axi_update_ARADDR <= ap_const_lv64_0;
    m_axi_update_ARBURST <= ap_const_lv2_0;
    m_axi_update_ARCACHE <= ap_const_lv4_0;
    m_axi_update_ARID <= ap_const_lv1_0;
    m_axi_update_ARLEN <= ap_const_lv32_0;
    m_axi_update_ARLOCK <= ap_const_lv2_0;
    m_axi_update_ARPROT <= ap_const_lv3_0;
    m_axi_update_ARQOS <= ap_const_lv4_0;
    m_axi_update_ARREGION <= ap_const_lv4_0;
    m_axi_update_ARSIZE <= ap_const_lv3_0;
    m_axi_update_ARUSER <= ap_const_lv1_0;
    m_axi_update_ARVALID <= ap_const_logic_0;
    m_axi_update_AWADDR <= dataflow_in_loop_copy2_U0_m_axi_update_AWADDR;
    m_axi_update_AWBURST <= dataflow_in_loop_copy2_U0_m_axi_update_AWBURST;
    m_axi_update_AWCACHE <= dataflow_in_loop_copy2_U0_m_axi_update_AWCACHE;
    m_axi_update_AWID <= dataflow_in_loop_copy2_U0_m_axi_update_AWID;
    m_axi_update_AWLEN <= dataflow_in_loop_copy2_U0_m_axi_update_AWLEN;
    m_axi_update_AWLOCK <= dataflow_in_loop_copy2_U0_m_axi_update_AWLOCK;
    m_axi_update_AWPROT <= dataflow_in_loop_copy2_U0_m_axi_update_AWPROT;
    m_axi_update_AWQOS <= dataflow_in_loop_copy2_U0_m_axi_update_AWQOS;
    m_axi_update_AWREGION <= dataflow_in_loop_copy2_U0_m_axi_update_AWREGION;
    m_axi_update_AWSIZE <= dataflow_in_loop_copy2_U0_m_axi_update_AWSIZE;
    m_axi_update_AWUSER <= dataflow_in_loop_copy2_U0_m_axi_update_AWUSER;
    m_axi_update_AWVALID <= dataflow_in_loop_copy2_U0_m_axi_update_AWVALID;
    m_axi_update_BREADY <= dataflow_in_loop_copy2_U0_m_axi_update_BREADY;
    m_axi_update_RREADY <= ap_const_logic_0;
    m_axi_update_WDATA <= dataflow_in_loop_copy2_U0_m_axi_update_WDATA;
    m_axi_update_WID <= dataflow_in_loop_copy2_U0_m_axi_update_WID;
    m_axi_update_WLAST <= dataflow_in_loop_copy2_U0_m_axi_update_WLAST;
    m_axi_update_WSTRB <= dataflow_in_loop_copy2_U0_m_axi_update_WSTRB;
    m_axi_update_WUSER <= dataflow_in_loop_copy2_U0_m_axi_update_WUSER;
    m_axi_update_WVALID <= dataflow_in_loop_copy2_U0_m_axi_update_WVALID;
    ycopy_V_address0 <= dataflow_in_loop_copy2_U0_ycopy_V_address0;
    ycopy_V_address1 <= ap_const_lv10_0;
    ycopy_V_ce0 <= dataflow_in_loop_copy2_U0_ycopy_V_ce0;
    ycopy_V_ce1 <= ap_const_logic_0;
    ycopy_V_d0 <= ap_const_lv32_0;
    ycopy_V_d1 <= ap_const_lv32_0;
    ycopy_V_we0 <= ap_const_logic_0;
    ycopy_V_we1 <= ap_const_logic_0;
end behav;
