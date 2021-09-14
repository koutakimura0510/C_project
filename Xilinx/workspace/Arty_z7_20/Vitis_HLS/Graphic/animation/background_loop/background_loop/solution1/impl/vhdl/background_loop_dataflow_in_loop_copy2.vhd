-- ==============================================================
-- RTL generated by Vitis HLS - High-Level Synthesis from C, C++ and OpenCL v2020.2 (64-bit)
-- Version: 2020.2
-- Copyright (C) Copyright 1986-2020 Xilinx, Inc. All Rights Reserved.
-- 
-- ===========================================================

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity background_loop_dataflow_in_loop_copy2 is
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
end;


architecture behav of background_loop_dataflow_in_loop_copy2 is 
    constant ap_const_lv10_0 : STD_LOGIC_VECTOR (9 downto 0) := "0000000000";
    constant ap_const_logic_0 : STD_LOGIC := '0';
    constant ap_const_lv32_0 : STD_LOGIC_VECTOR (31 downto 0) := "00000000000000000000000000000000";
    constant ap_const_logic_1 : STD_LOGIC := '1';
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
    signal Block_entry_proc_proc7_U0_ap_start : STD_LOGIC;
    signal Block_entry_proc_proc7_U0_ap_done : STD_LOGIC;
    signal Block_entry_proc_proc7_U0_ap_continue : STD_LOGIC;
    signal Block_entry_proc_proc7_U0_ap_idle : STD_LOGIC;
    signal Block_entry_proc_proc7_U0_ap_ready : STD_LOGIC;
    signal Block_entry_proc_proc7_U0_ycopy_V_address0 : STD_LOGIC_VECTOR (9 downto 0);
    signal Block_entry_proc_proc7_U0_ycopy_V_ce0 : STD_LOGIC;
    signal Block_entry_proc_proc7_U0_m_axi_update_AWVALID : STD_LOGIC;
    signal Block_entry_proc_proc7_U0_m_axi_update_AWADDR : STD_LOGIC_VECTOR (63 downto 0);
    signal Block_entry_proc_proc7_U0_m_axi_update_AWID : STD_LOGIC_VECTOR (0 downto 0);
    signal Block_entry_proc_proc7_U0_m_axi_update_AWLEN : STD_LOGIC_VECTOR (31 downto 0);
    signal Block_entry_proc_proc7_U0_m_axi_update_AWSIZE : STD_LOGIC_VECTOR (2 downto 0);
    signal Block_entry_proc_proc7_U0_m_axi_update_AWBURST : STD_LOGIC_VECTOR (1 downto 0);
    signal Block_entry_proc_proc7_U0_m_axi_update_AWLOCK : STD_LOGIC_VECTOR (1 downto 0);
    signal Block_entry_proc_proc7_U0_m_axi_update_AWCACHE : STD_LOGIC_VECTOR (3 downto 0);
    signal Block_entry_proc_proc7_U0_m_axi_update_AWPROT : STD_LOGIC_VECTOR (2 downto 0);
    signal Block_entry_proc_proc7_U0_m_axi_update_AWQOS : STD_LOGIC_VECTOR (3 downto 0);
    signal Block_entry_proc_proc7_U0_m_axi_update_AWREGION : STD_LOGIC_VECTOR (3 downto 0);
    signal Block_entry_proc_proc7_U0_m_axi_update_AWUSER : STD_LOGIC_VECTOR (0 downto 0);
    signal Block_entry_proc_proc7_U0_m_axi_update_WVALID : STD_LOGIC;
    signal Block_entry_proc_proc7_U0_m_axi_update_WDATA : STD_LOGIC_VECTOR (31 downto 0);
    signal Block_entry_proc_proc7_U0_m_axi_update_WSTRB : STD_LOGIC_VECTOR (3 downto 0);
    signal Block_entry_proc_proc7_U0_m_axi_update_WLAST : STD_LOGIC;
    signal Block_entry_proc_proc7_U0_m_axi_update_WID : STD_LOGIC_VECTOR (0 downto 0);
    signal Block_entry_proc_proc7_U0_m_axi_update_WUSER : STD_LOGIC_VECTOR (0 downto 0);
    signal Block_entry_proc_proc7_U0_m_axi_update_ARVALID : STD_LOGIC;
    signal Block_entry_proc_proc7_U0_m_axi_update_ARADDR : STD_LOGIC_VECTOR (63 downto 0);
    signal Block_entry_proc_proc7_U0_m_axi_update_ARID : STD_LOGIC_VECTOR (0 downto 0);
    signal Block_entry_proc_proc7_U0_m_axi_update_ARLEN : STD_LOGIC_VECTOR (31 downto 0);
    signal Block_entry_proc_proc7_U0_m_axi_update_ARSIZE : STD_LOGIC_VECTOR (2 downto 0);
    signal Block_entry_proc_proc7_U0_m_axi_update_ARBURST : STD_LOGIC_VECTOR (1 downto 0);
    signal Block_entry_proc_proc7_U0_m_axi_update_ARLOCK : STD_LOGIC_VECTOR (1 downto 0);
    signal Block_entry_proc_proc7_U0_m_axi_update_ARCACHE : STD_LOGIC_VECTOR (3 downto 0);
    signal Block_entry_proc_proc7_U0_m_axi_update_ARPROT : STD_LOGIC_VECTOR (2 downto 0);
    signal Block_entry_proc_proc7_U0_m_axi_update_ARQOS : STD_LOGIC_VECTOR (3 downto 0);
    signal Block_entry_proc_proc7_U0_m_axi_update_ARREGION : STD_LOGIC_VECTOR (3 downto 0);
    signal Block_entry_proc_proc7_U0_m_axi_update_ARUSER : STD_LOGIC_VECTOR (0 downto 0);
    signal Block_entry_proc_proc7_U0_m_axi_update_RREADY : STD_LOGIC;
    signal Block_entry_proc_proc7_U0_m_axi_update_BREADY : STD_LOGIC;
    signal ap_sync_continue : STD_LOGIC;
    signal ap_sync_done : STD_LOGIC;
    signal ap_sync_ready : STD_LOGIC;
    signal Block_entry_proc_proc7_U0_start_full_n : STD_LOGIC;
    signal Block_entry_proc_proc7_U0_start_write : STD_LOGIC;

    component background_loop_Block_entry_proc_proc7 IS
    port (
        ap_clk : IN STD_LOGIC;
        ap_rst : IN STD_LOGIC;
        ap_start : IN STD_LOGIC;
        ap_done : OUT STD_LOGIC;
        ap_continue : IN STD_LOGIC;
        ap_idle : OUT STD_LOGIC;
        ap_ready : OUT STD_LOGIC;
        ycopy_V_address0 : OUT STD_LOGIC_VECTOR (9 downto 0);
        ycopy_V_ce0 : OUT STD_LOGIC;
        ycopy_V_q0 : IN STD_LOGIC_VECTOR (31 downto 0);
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
        ddr_update : IN STD_LOGIC_VECTOR (63 downto 0) );
    end component;



begin
    Block_entry_proc_proc7_U0 : component background_loop_Block_entry_proc_proc7
    port map (
        ap_clk => ap_clk,
        ap_rst => ap_rst,
        ap_start => Block_entry_proc_proc7_U0_ap_start,
        ap_done => Block_entry_proc_proc7_U0_ap_done,
        ap_continue => Block_entry_proc_proc7_U0_ap_continue,
        ap_idle => Block_entry_proc_proc7_U0_ap_idle,
        ap_ready => Block_entry_proc_proc7_U0_ap_ready,
        ycopy_V_address0 => Block_entry_proc_proc7_U0_ycopy_V_address0,
        ycopy_V_ce0 => Block_entry_proc_proc7_U0_ycopy_V_ce0,
        ycopy_V_q0 => ycopy_V_q0,
        trunc_ln329 => trunc_ln329,
        m_axi_update_AWVALID => Block_entry_proc_proc7_U0_m_axi_update_AWVALID,
        m_axi_update_AWREADY => m_axi_update_AWREADY,
        m_axi_update_AWADDR => Block_entry_proc_proc7_U0_m_axi_update_AWADDR,
        m_axi_update_AWID => Block_entry_proc_proc7_U0_m_axi_update_AWID,
        m_axi_update_AWLEN => Block_entry_proc_proc7_U0_m_axi_update_AWLEN,
        m_axi_update_AWSIZE => Block_entry_proc_proc7_U0_m_axi_update_AWSIZE,
        m_axi_update_AWBURST => Block_entry_proc_proc7_U0_m_axi_update_AWBURST,
        m_axi_update_AWLOCK => Block_entry_proc_proc7_U0_m_axi_update_AWLOCK,
        m_axi_update_AWCACHE => Block_entry_proc_proc7_U0_m_axi_update_AWCACHE,
        m_axi_update_AWPROT => Block_entry_proc_proc7_U0_m_axi_update_AWPROT,
        m_axi_update_AWQOS => Block_entry_proc_proc7_U0_m_axi_update_AWQOS,
        m_axi_update_AWREGION => Block_entry_proc_proc7_U0_m_axi_update_AWREGION,
        m_axi_update_AWUSER => Block_entry_proc_proc7_U0_m_axi_update_AWUSER,
        m_axi_update_WVALID => Block_entry_proc_proc7_U0_m_axi_update_WVALID,
        m_axi_update_WREADY => m_axi_update_WREADY,
        m_axi_update_WDATA => Block_entry_proc_proc7_U0_m_axi_update_WDATA,
        m_axi_update_WSTRB => Block_entry_proc_proc7_U0_m_axi_update_WSTRB,
        m_axi_update_WLAST => Block_entry_proc_proc7_U0_m_axi_update_WLAST,
        m_axi_update_WID => Block_entry_proc_proc7_U0_m_axi_update_WID,
        m_axi_update_WUSER => Block_entry_proc_proc7_U0_m_axi_update_WUSER,
        m_axi_update_ARVALID => Block_entry_proc_proc7_U0_m_axi_update_ARVALID,
        m_axi_update_ARREADY => ap_const_logic_0,
        m_axi_update_ARADDR => Block_entry_proc_proc7_U0_m_axi_update_ARADDR,
        m_axi_update_ARID => Block_entry_proc_proc7_U0_m_axi_update_ARID,
        m_axi_update_ARLEN => Block_entry_proc_proc7_U0_m_axi_update_ARLEN,
        m_axi_update_ARSIZE => Block_entry_proc_proc7_U0_m_axi_update_ARSIZE,
        m_axi_update_ARBURST => Block_entry_proc_proc7_U0_m_axi_update_ARBURST,
        m_axi_update_ARLOCK => Block_entry_proc_proc7_U0_m_axi_update_ARLOCK,
        m_axi_update_ARCACHE => Block_entry_proc_proc7_U0_m_axi_update_ARCACHE,
        m_axi_update_ARPROT => Block_entry_proc_proc7_U0_m_axi_update_ARPROT,
        m_axi_update_ARQOS => Block_entry_proc_proc7_U0_m_axi_update_ARQOS,
        m_axi_update_ARREGION => Block_entry_proc_proc7_U0_m_axi_update_ARREGION,
        m_axi_update_ARUSER => Block_entry_proc_proc7_U0_m_axi_update_ARUSER,
        m_axi_update_RVALID => ap_const_logic_0,
        m_axi_update_RREADY => Block_entry_proc_proc7_U0_m_axi_update_RREADY,
        m_axi_update_RDATA => ap_const_lv32_0,
        m_axi_update_RLAST => ap_const_logic_0,
        m_axi_update_RID => ap_const_lv1_0,
        m_axi_update_RUSER => ap_const_lv1_0,
        m_axi_update_RRESP => ap_const_lv2_0,
        m_axi_update_BVALID => m_axi_update_BVALID,
        m_axi_update_BREADY => Block_entry_proc_proc7_U0_m_axi_update_BREADY,
        m_axi_update_BRESP => m_axi_update_BRESP,
        m_axi_update_BID => m_axi_update_BID,
        m_axi_update_BUSER => m_axi_update_BUSER,
        frame_size => frame_size,
        ddr_update => ddr_update);




    Block_entry_proc_proc7_U0_ap_continue <= ap_continue;
    Block_entry_proc_proc7_U0_ap_start <= ap_start;
    Block_entry_proc_proc7_U0_start_full_n <= ap_const_logic_1;
    Block_entry_proc_proc7_U0_start_write <= ap_const_logic_0;
    ap_done <= Block_entry_proc_proc7_U0_ap_done;
    ap_idle <= Block_entry_proc_proc7_U0_ap_idle;
    ap_ready <= Block_entry_proc_proc7_U0_ap_ready;
    ap_sync_continue <= ap_continue;
    ap_sync_done <= Block_entry_proc_proc7_U0_ap_done;
    ap_sync_ready <= Block_entry_proc_proc7_U0_ap_ready;
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
    m_axi_update_AWADDR <= Block_entry_proc_proc7_U0_m_axi_update_AWADDR;
    m_axi_update_AWBURST <= Block_entry_proc_proc7_U0_m_axi_update_AWBURST;
    m_axi_update_AWCACHE <= Block_entry_proc_proc7_U0_m_axi_update_AWCACHE;
    m_axi_update_AWID <= Block_entry_proc_proc7_U0_m_axi_update_AWID;
    m_axi_update_AWLEN <= Block_entry_proc_proc7_U0_m_axi_update_AWLEN;
    m_axi_update_AWLOCK <= Block_entry_proc_proc7_U0_m_axi_update_AWLOCK;
    m_axi_update_AWPROT <= Block_entry_proc_proc7_U0_m_axi_update_AWPROT;
    m_axi_update_AWQOS <= Block_entry_proc_proc7_U0_m_axi_update_AWQOS;
    m_axi_update_AWREGION <= Block_entry_proc_proc7_U0_m_axi_update_AWREGION;
    m_axi_update_AWSIZE <= Block_entry_proc_proc7_U0_m_axi_update_AWSIZE;
    m_axi_update_AWUSER <= Block_entry_proc_proc7_U0_m_axi_update_AWUSER;
    m_axi_update_AWVALID <= Block_entry_proc_proc7_U0_m_axi_update_AWVALID;
    m_axi_update_BREADY <= Block_entry_proc_proc7_U0_m_axi_update_BREADY;
    m_axi_update_RREADY <= ap_const_logic_0;
    m_axi_update_WDATA <= Block_entry_proc_proc7_U0_m_axi_update_WDATA;
    m_axi_update_WID <= Block_entry_proc_proc7_U0_m_axi_update_WID;
    m_axi_update_WLAST <= Block_entry_proc_proc7_U0_m_axi_update_WLAST;
    m_axi_update_WSTRB <= Block_entry_proc_proc7_U0_m_axi_update_WSTRB;
    m_axi_update_WUSER <= Block_entry_proc_proc7_U0_m_axi_update_WUSER;
    m_axi_update_WVALID <= Block_entry_proc_proc7_U0_m_axi_update_WVALID;
    ycopy_V_address0 <= Block_entry_proc_proc7_U0_ycopy_V_address0;
    ycopy_V_address1 <= ap_const_lv10_0;
    ycopy_V_ce0 <= Block_entry_proc_proc7_U0_ycopy_V_ce0;
    ycopy_V_ce1 <= ap_const_logic_0;
    ycopy_V_d0 <= ap_const_lv32_0;
    ycopy_V_d1 <= ap_const_lv32_0;
    ycopy_V_we0 <= ap_const_logic_0;
    ycopy_V_we1 <= ap_const_logic_0;
end behav;
