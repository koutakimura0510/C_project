-- ==============================================================
-- RTL generated by Vitis HLS - High-Level Synthesis from C, C++ and OpenCL v2020.2 (64-bit)
-- Version: 2020.2
-- Copyright (C) Copyright 1986-2020 Xilinx, Inc. All Rights Reserved.
-- 
-- ===========================================================

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity led_blink is
generic (
    C_M_AXI_ONOFF_ADDR_WIDTH : INTEGER := 64;
    C_M_AXI_ONOFF_ID_WIDTH : INTEGER := 1;
    C_M_AXI_ONOFF_AWUSER_WIDTH : INTEGER := 1;
    C_M_AXI_ONOFF_DATA_WIDTH : INTEGER := 32;
    C_M_AXI_ONOFF_WUSER_WIDTH : INTEGER := 1;
    C_M_AXI_ONOFF_ARUSER_WIDTH : INTEGER := 1;
    C_M_AXI_ONOFF_RUSER_WIDTH : INTEGER := 1;
    C_M_AXI_ONOFF_BUSER_WIDTH : INTEGER := 1;
    C_S_AXI_CONTROL_ADDR_WIDTH : INTEGER := 5;
    C_S_AXI_CONTROL_DATA_WIDTH : INTEGER := 32;
    C_M_AXI_ONOFF_USER_VALUE : INTEGER := 0;
    C_M_AXI_ONOFF_PROT_VALUE : INTEGER := 0;
    C_M_AXI_ONOFF_CACHE_VALUE : INTEGER := 3 );
port (
    ap_clk : IN STD_LOGIC;
    ap_rst_n : IN STD_LOGIC;
    m_axi_onoff_AWVALID : OUT STD_LOGIC;
    m_axi_onoff_AWREADY : IN STD_LOGIC;
    m_axi_onoff_AWADDR : OUT STD_LOGIC_VECTOR (C_M_AXI_ONOFF_ADDR_WIDTH-1 downto 0);
    m_axi_onoff_AWID : OUT STD_LOGIC_VECTOR (C_M_AXI_ONOFF_ID_WIDTH-1 downto 0);
    m_axi_onoff_AWLEN : OUT STD_LOGIC_VECTOR (7 downto 0);
    m_axi_onoff_AWSIZE : OUT STD_LOGIC_VECTOR (2 downto 0);
    m_axi_onoff_AWBURST : OUT STD_LOGIC_VECTOR (1 downto 0);
    m_axi_onoff_AWLOCK : OUT STD_LOGIC_VECTOR (1 downto 0);
    m_axi_onoff_AWCACHE : OUT STD_LOGIC_VECTOR (3 downto 0);
    m_axi_onoff_AWPROT : OUT STD_LOGIC_VECTOR (2 downto 0);
    m_axi_onoff_AWQOS : OUT STD_LOGIC_VECTOR (3 downto 0);
    m_axi_onoff_AWREGION : OUT STD_LOGIC_VECTOR (3 downto 0);
    m_axi_onoff_AWUSER : OUT STD_LOGIC_VECTOR (C_M_AXI_ONOFF_AWUSER_WIDTH-1 downto 0);
    m_axi_onoff_WVALID : OUT STD_LOGIC;
    m_axi_onoff_WREADY : IN STD_LOGIC;
    m_axi_onoff_WDATA : OUT STD_LOGIC_VECTOR (C_M_AXI_ONOFF_DATA_WIDTH-1 downto 0);
    m_axi_onoff_WSTRB : OUT STD_LOGIC_VECTOR (C_M_AXI_ONOFF_DATA_WIDTH/8-1 downto 0);
    m_axi_onoff_WLAST : OUT STD_LOGIC;
    m_axi_onoff_WID : OUT STD_LOGIC_VECTOR (C_M_AXI_ONOFF_ID_WIDTH-1 downto 0);
    m_axi_onoff_WUSER : OUT STD_LOGIC_VECTOR (C_M_AXI_ONOFF_WUSER_WIDTH-1 downto 0);
    m_axi_onoff_ARVALID : OUT STD_LOGIC;
    m_axi_onoff_ARREADY : IN STD_LOGIC;
    m_axi_onoff_ARADDR : OUT STD_LOGIC_VECTOR (C_M_AXI_ONOFF_ADDR_WIDTH-1 downto 0);
    m_axi_onoff_ARID : OUT STD_LOGIC_VECTOR (C_M_AXI_ONOFF_ID_WIDTH-1 downto 0);
    m_axi_onoff_ARLEN : OUT STD_LOGIC_VECTOR (7 downto 0);
    m_axi_onoff_ARSIZE : OUT STD_LOGIC_VECTOR (2 downto 0);
    m_axi_onoff_ARBURST : OUT STD_LOGIC_VECTOR (1 downto 0);
    m_axi_onoff_ARLOCK : OUT STD_LOGIC_VECTOR (1 downto 0);
    m_axi_onoff_ARCACHE : OUT STD_LOGIC_VECTOR (3 downto 0);
    m_axi_onoff_ARPROT : OUT STD_LOGIC_VECTOR (2 downto 0);
    m_axi_onoff_ARQOS : OUT STD_LOGIC_VECTOR (3 downto 0);
    m_axi_onoff_ARREGION : OUT STD_LOGIC_VECTOR (3 downto 0);
    m_axi_onoff_ARUSER : OUT STD_LOGIC_VECTOR (C_M_AXI_ONOFF_ARUSER_WIDTH-1 downto 0);
    m_axi_onoff_RVALID : IN STD_LOGIC;
    m_axi_onoff_RREADY : OUT STD_LOGIC;
    m_axi_onoff_RDATA : IN STD_LOGIC_VECTOR (C_M_AXI_ONOFF_DATA_WIDTH-1 downto 0);
    m_axi_onoff_RLAST : IN STD_LOGIC;
    m_axi_onoff_RID : IN STD_LOGIC_VECTOR (C_M_AXI_ONOFF_ID_WIDTH-1 downto 0);
    m_axi_onoff_RUSER : IN STD_LOGIC_VECTOR (C_M_AXI_ONOFF_RUSER_WIDTH-1 downto 0);
    m_axi_onoff_RRESP : IN STD_LOGIC_VECTOR (1 downto 0);
    m_axi_onoff_BVALID : IN STD_LOGIC;
    m_axi_onoff_BREADY : OUT STD_LOGIC;
    m_axi_onoff_BRESP : IN STD_LOGIC_VECTOR (1 downto 0);
    m_axi_onoff_BID : IN STD_LOGIC_VECTOR (C_M_AXI_ONOFF_ID_WIDTH-1 downto 0);
    m_axi_onoff_BUSER : IN STD_LOGIC_VECTOR (C_M_AXI_ONOFF_BUSER_WIDTH-1 downto 0);
    led : OUT STD_LOGIC_VECTOR (3 downto 0);
    s_axi_control_AWVALID : IN STD_LOGIC;
    s_axi_control_AWREADY : OUT STD_LOGIC;
    s_axi_control_AWADDR : IN STD_LOGIC_VECTOR (C_S_AXI_CONTROL_ADDR_WIDTH-1 downto 0);
    s_axi_control_WVALID : IN STD_LOGIC;
    s_axi_control_WREADY : OUT STD_LOGIC;
    s_axi_control_WDATA : IN STD_LOGIC_VECTOR (C_S_AXI_CONTROL_DATA_WIDTH-1 downto 0);
    s_axi_control_WSTRB : IN STD_LOGIC_VECTOR (C_S_AXI_CONTROL_DATA_WIDTH/8-1 downto 0);
    s_axi_control_ARVALID : IN STD_LOGIC;
    s_axi_control_ARREADY : OUT STD_LOGIC;
    s_axi_control_ARADDR : IN STD_LOGIC_VECTOR (C_S_AXI_CONTROL_ADDR_WIDTH-1 downto 0);
    s_axi_control_RVALID : OUT STD_LOGIC;
    s_axi_control_RREADY : IN STD_LOGIC;
    s_axi_control_RDATA : OUT STD_LOGIC_VECTOR (C_S_AXI_CONTROL_DATA_WIDTH-1 downto 0);
    s_axi_control_RRESP : OUT STD_LOGIC_VECTOR (1 downto 0);
    s_axi_control_BVALID : OUT STD_LOGIC;
    s_axi_control_BREADY : IN STD_LOGIC;
    s_axi_control_BRESP : OUT STD_LOGIC_VECTOR (1 downto 0) );
end;


architecture behav of led_blink is 
    attribute CORE_GENERATION_INFO : STRING;
    attribute CORE_GENERATION_INFO of behav : architecture is
    "led_blink_led_blink,hls_ip_2020_2,{HLS_INPUT_TYPE=cxx,HLS_INPUT_FLOAT=0,HLS_INPUT_FIXED=0,HLS_INPUT_PART=xc7z020-clg400-1,HLS_INPUT_CLOCK=10.000000,HLS_INPUT_ARCH=others,HLS_SYN_CLOCK=7.300000,HLS_SYN_LAT=8,HLS_SYN_TPT=none,HLS_SYN_MEM=2,HLS_SYN_DSP=0,HLS_SYN_FF=727,HLS_SYN_LUT=939,HLS_VERSION=2020_2}";
    constant ap_const_logic_1 : STD_LOGIC := '1';
    constant ap_const_logic_0 : STD_LOGIC := '0';
    constant ap_ST_fsm_state1 : STD_LOGIC_VECTOR (8 downto 0) := "000000001";
    constant ap_ST_fsm_state2 : STD_LOGIC_VECTOR (8 downto 0) := "000000010";
    constant ap_ST_fsm_state3 : STD_LOGIC_VECTOR (8 downto 0) := "000000100";
    constant ap_ST_fsm_state4 : STD_LOGIC_VECTOR (8 downto 0) := "000001000";
    constant ap_ST_fsm_state5 : STD_LOGIC_VECTOR (8 downto 0) := "000010000";
    constant ap_ST_fsm_state6 : STD_LOGIC_VECTOR (8 downto 0) := "000100000";
    constant ap_ST_fsm_state7 : STD_LOGIC_VECTOR (8 downto 0) := "001000000";
    constant ap_ST_fsm_state8 : STD_LOGIC_VECTOR (8 downto 0) := "010000000";
    constant ap_ST_fsm_state9 : STD_LOGIC_VECTOR (8 downto 0) := "100000000";
    constant ap_const_lv32_1 : STD_LOGIC_VECTOR (31 downto 0) := "00000000000000000000000000000001";
    constant ap_const_lv32_8 : STD_LOGIC_VECTOR (31 downto 0) := "00000000000000000000000000001000";
    constant C_S_AXI_DATA_WIDTH : INTEGER range 63 downto 0 := 20;
    constant C_M_AXI_DATA_WIDTH : INTEGER range 63 downto 0 := 20;
    constant ap_const_lv32_0 : STD_LOGIC_VECTOR (31 downto 0) := "00000000000000000000000000000000";
    constant ap_const_lv1_0 : STD_LOGIC_VECTOR (0 downto 0) := "0";
    constant ap_const_lv3_0 : STD_LOGIC_VECTOR (2 downto 0) := "000";
    constant ap_const_lv2_0 : STD_LOGIC_VECTOR (1 downto 0) := "00";
    constant ap_const_lv4_0 : STD_LOGIC_VECTOR (3 downto 0) := "0000";
    constant ap_const_lv64_0 : STD_LOGIC_VECTOR (63 downto 0) := "0000000000000000000000000000000000000000000000000000000000000000";
    constant ap_const_lv8_0 : STD_LOGIC_VECTOR (7 downto 0) := "00000000";
    constant ap_const_boolean_1 : BOOLEAN := true;

    signal ap_rst_n_inv : STD_LOGIC;
    signal onoff_offset : STD_LOGIC_VECTOR (63 downto 0);
    signal onoff_blk_n_AR : STD_LOGIC;
    signal ap_CS_fsm : STD_LOGIC_VECTOR (8 downto 0) := "000000001";
    attribute fsm_encoding : string;
    attribute fsm_encoding of ap_CS_fsm : signal is "none";
    signal ap_CS_fsm_state2 : STD_LOGIC;
    attribute fsm_encoding of ap_CS_fsm_state2 : signal is "none";
    signal onoff_blk_n_R : STD_LOGIC;
    signal ap_CS_fsm_state9 : STD_LOGIC;
    attribute fsm_encoding of ap_CS_fsm_state9 : signal is "none";
    signal onoff_AWREADY : STD_LOGIC;
    signal onoff_WREADY : STD_LOGIC;
    signal onoff_ARVALID : STD_LOGIC;
    signal onoff_ARREADY : STD_LOGIC;
    signal onoff_RVALID : STD_LOGIC;
    signal onoff_RREADY : STD_LOGIC;
    signal onoff_RDATA : STD_LOGIC_VECTOR (7 downto 0);
    signal onoff_RLAST : STD_LOGIC;
    signal onoff_RID : STD_LOGIC_VECTOR (0 downto 0);
    signal onoff_RUSER : STD_LOGIC_VECTOR (0 downto 0);
    signal onoff_RRESP : STD_LOGIC_VECTOR (1 downto 0);
    signal onoff_BVALID : STD_LOGIC;
    signal onoff_BRESP : STD_LOGIC_VECTOR (1 downto 0);
    signal onoff_BID : STD_LOGIC_VECTOR (0 downto 0);
    signal onoff_BUSER : STD_LOGIC_VECTOR (0 downto 0);
    signal onoff_addr_reg_90 : STD_LOGIC_VECTOR (63 downto 0);
    signal ap_CS_fsm_state1 : STD_LOGIC;
    attribute fsm_encoding of ap_CS_fsm_state1 : signal is "none";
    signal trunc_ln218_fu_81_p1 : STD_LOGIC_VECTOR (0 downto 0);
    signal ap_NS_fsm : STD_LOGIC_VECTOR (8 downto 0);
    signal ap_ce_reg : STD_LOGIC;

    component led_blink_control_s_axi IS
    generic (
        C_S_AXI_ADDR_WIDTH : INTEGER;
        C_S_AXI_DATA_WIDTH : INTEGER );
    port (
        AWVALID : IN STD_LOGIC;
        AWREADY : OUT STD_LOGIC;
        AWADDR : IN STD_LOGIC_VECTOR (C_S_AXI_ADDR_WIDTH-1 downto 0);
        WVALID : IN STD_LOGIC;
        WREADY : OUT STD_LOGIC;
        WDATA : IN STD_LOGIC_VECTOR (C_S_AXI_DATA_WIDTH-1 downto 0);
        WSTRB : IN STD_LOGIC_VECTOR (C_S_AXI_DATA_WIDTH/8-1 downto 0);
        ARVALID : IN STD_LOGIC;
        ARREADY : OUT STD_LOGIC;
        ARADDR : IN STD_LOGIC_VECTOR (C_S_AXI_ADDR_WIDTH-1 downto 0);
        RVALID : OUT STD_LOGIC;
        RREADY : IN STD_LOGIC;
        RDATA : OUT STD_LOGIC_VECTOR (C_S_AXI_DATA_WIDTH-1 downto 0);
        RRESP : OUT STD_LOGIC_VECTOR (1 downto 0);
        BVALID : OUT STD_LOGIC;
        BREADY : IN STD_LOGIC;
        BRESP : OUT STD_LOGIC_VECTOR (1 downto 0);
        ACLK : IN STD_LOGIC;
        ARESET : IN STD_LOGIC;
        ACLK_EN : IN STD_LOGIC;
        onoff_offset : OUT STD_LOGIC_VECTOR (63 downto 0) );
    end component;


    component led_blink_onoff_m_axi IS
    generic (
        CONSERVATIVE : INTEGER;
        USER_DW : INTEGER;
        USER_AW : INTEGER;
        USER_MAXREQS : INTEGER;
        NUM_READ_OUTSTANDING : INTEGER;
        NUM_WRITE_OUTSTANDING : INTEGER;
        MAX_READ_BURST_LENGTH : INTEGER;
        MAX_WRITE_BURST_LENGTH : INTEGER;
        C_M_AXI_ID_WIDTH : INTEGER;
        C_M_AXI_ADDR_WIDTH : INTEGER;
        C_M_AXI_DATA_WIDTH : INTEGER;
        C_M_AXI_AWUSER_WIDTH : INTEGER;
        C_M_AXI_ARUSER_WIDTH : INTEGER;
        C_M_AXI_WUSER_WIDTH : INTEGER;
        C_M_AXI_RUSER_WIDTH : INTEGER;
        C_M_AXI_BUSER_WIDTH : INTEGER;
        C_USER_VALUE : INTEGER;
        C_PROT_VALUE : INTEGER;
        C_CACHE_VALUE : INTEGER );
    port (
        AWVALID : OUT STD_LOGIC;
        AWREADY : IN STD_LOGIC;
        AWADDR : OUT STD_LOGIC_VECTOR (C_M_AXI_ADDR_WIDTH-1 downto 0);
        AWID : OUT STD_LOGIC_VECTOR (C_M_AXI_ID_WIDTH-1 downto 0);
        AWLEN : OUT STD_LOGIC_VECTOR (7 downto 0);
        AWSIZE : OUT STD_LOGIC_VECTOR (2 downto 0);
        AWBURST : OUT STD_LOGIC_VECTOR (1 downto 0);
        AWLOCK : OUT STD_LOGIC_VECTOR (1 downto 0);
        AWCACHE : OUT STD_LOGIC_VECTOR (3 downto 0);
        AWPROT : OUT STD_LOGIC_VECTOR (2 downto 0);
        AWQOS : OUT STD_LOGIC_VECTOR (3 downto 0);
        AWREGION : OUT STD_LOGIC_VECTOR (3 downto 0);
        AWUSER : OUT STD_LOGIC_VECTOR (C_M_AXI_AWUSER_WIDTH-1 downto 0);
        WVALID : OUT STD_LOGIC;
        WREADY : IN STD_LOGIC;
        WDATA : OUT STD_LOGIC_VECTOR (C_M_AXI_DATA_WIDTH-1 downto 0);
        WSTRB : OUT STD_LOGIC_VECTOR (C_M_AXI_DATA_WIDTH/8-1 downto 0);
        WLAST : OUT STD_LOGIC;
        WID : OUT STD_LOGIC_VECTOR (C_M_AXI_ID_WIDTH-1 downto 0);
        WUSER : OUT STD_LOGIC_VECTOR (C_M_AXI_WUSER_WIDTH-1 downto 0);
        ARVALID : OUT STD_LOGIC;
        ARREADY : IN STD_LOGIC;
        ARADDR : OUT STD_LOGIC_VECTOR (C_M_AXI_ADDR_WIDTH-1 downto 0);
        ARID : OUT STD_LOGIC_VECTOR (C_M_AXI_ID_WIDTH-1 downto 0);
        ARLEN : OUT STD_LOGIC_VECTOR (7 downto 0);
        ARSIZE : OUT STD_LOGIC_VECTOR (2 downto 0);
        ARBURST : OUT STD_LOGIC_VECTOR (1 downto 0);
        ARLOCK : OUT STD_LOGIC_VECTOR (1 downto 0);
        ARCACHE : OUT STD_LOGIC_VECTOR (3 downto 0);
        ARPROT : OUT STD_LOGIC_VECTOR (2 downto 0);
        ARQOS : OUT STD_LOGIC_VECTOR (3 downto 0);
        ARREGION : OUT STD_LOGIC_VECTOR (3 downto 0);
        ARUSER : OUT STD_LOGIC_VECTOR (C_M_AXI_ARUSER_WIDTH-1 downto 0);
        RVALID : IN STD_LOGIC;
        RREADY : OUT STD_LOGIC;
        RDATA : IN STD_LOGIC_VECTOR (C_M_AXI_DATA_WIDTH-1 downto 0);
        RLAST : IN STD_LOGIC;
        RID : IN STD_LOGIC_VECTOR (C_M_AXI_ID_WIDTH-1 downto 0);
        RUSER : IN STD_LOGIC_VECTOR (C_M_AXI_RUSER_WIDTH-1 downto 0);
        RRESP : IN STD_LOGIC_VECTOR (1 downto 0);
        BVALID : IN STD_LOGIC;
        BREADY : OUT STD_LOGIC;
        BRESP : IN STD_LOGIC_VECTOR (1 downto 0);
        BID : IN STD_LOGIC_VECTOR (C_M_AXI_ID_WIDTH-1 downto 0);
        BUSER : IN STD_LOGIC_VECTOR (C_M_AXI_BUSER_WIDTH-1 downto 0);
        ACLK : IN STD_LOGIC;
        ARESET : IN STD_LOGIC;
        ACLK_EN : IN STD_LOGIC;
        I_ARVALID : IN STD_LOGIC;
        I_ARREADY : OUT STD_LOGIC;
        I_ARADDR : IN STD_LOGIC_VECTOR (63 downto 0);
        I_ARID : IN STD_LOGIC_VECTOR (0 downto 0);
        I_ARLEN : IN STD_LOGIC_VECTOR (31 downto 0);
        I_ARSIZE : IN STD_LOGIC_VECTOR (2 downto 0);
        I_ARLOCK : IN STD_LOGIC_VECTOR (1 downto 0);
        I_ARCACHE : IN STD_LOGIC_VECTOR (3 downto 0);
        I_ARQOS : IN STD_LOGIC_VECTOR (3 downto 0);
        I_ARPROT : IN STD_LOGIC_VECTOR (2 downto 0);
        I_ARUSER : IN STD_LOGIC_VECTOR (0 downto 0);
        I_ARBURST : IN STD_LOGIC_VECTOR (1 downto 0);
        I_ARREGION : IN STD_LOGIC_VECTOR (3 downto 0);
        I_RVALID : OUT STD_LOGIC;
        I_RREADY : IN STD_LOGIC;
        I_RDATA : OUT STD_LOGIC_VECTOR (7 downto 0);
        I_RID : OUT STD_LOGIC_VECTOR (0 downto 0);
        I_RUSER : OUT STD_LOGIC_VECTOR (0 downto 0);
        I_RRESP : OUT STD_LOGIC_VECTOR (1 downto 0);
        I_RLAST : OUT STD_LOGIC;
        I_AWVALID : IN STD_LOGIC;
        I_AWREADY : OUT STD_LOGIC;
        I_AWADDR : IN STD_LOGIC_VECTOR (63 downto 0);
        I_AWID : IN STD_LOGIC_VECTOR (0 downto 0);
        I_AWLEN : IN STD_LOGIC_VECTOR (31 downto 0);
        I_AWSIZE : IN STD_LOGIC_VECTOR (2 downto 0);
        I_AWLOCK : IN STD_LOGIC_VECTOR (1 downto 0);
        I_AWCACHE : IN STD_LOGIC_VECTOR (3 downto 0);
        I_AWQOS : IN STD_LOGIC_VECTOR (3 downto 0);
        I_AWPROT : IN STD_LOGIC_VECTOR (2 downto 0);
        I_AWUSER : IN STD_LOGIC_VECTOR (0 downto 0);
        I_AWBURST : IN STD_LOGIC_VECTOR (1 downto 0);
        I_AWREGION : IN STD_LOGIC_VECTOR (3 downto 0);
        I_WVALID : IN STD_LOGIC;
        I_WREADY : OUT STD_LOGIC;
        I_WDATA : IN STD_LOGIC_VECTOR (7 downto 0);
        I_WID : IN STD_LOGIC_VECTOR (0 downto 0);
        I_WUSER : IN STD_LOGIC_VECTOR (0 downto 0);
        I_WLAST : IN STD_LOGIC;
        I_WSTRB : IN STD_LOGIC_VECTOR (0 downto 0);
        I_BVALID : OUT STD_LOGIC;
        I_BREADY : IN STD_LOGIC;
        I_BRESP : OUT STD_LOGIC_VECTOR (1 downto 0);
        I_BID : OUT STD_LOGIC_VECTOR (0 downto 0);
        I_BUSER : OUT STD_LOGIC_VECTOR (0 downto 0) );
    end component;



begin
    control_s_axi_U : component led_blink_control_s_axi
    generic map (
        C_S_AXI_ADDR_WIDTH => C_S_AXI_CONTROL_ADDR_WIDTH,
        C_S_AXI_DATA_WIDTH => C_S_AXI_CONTROL_DATA_WIDTH)
    port map (
        AWVALID => s_axi_control_AWVALID,
        AWREADY => s_axi_control_AWREADY,
        AWADDR => s_axi_control_AWADDR,
        WVALID => s_axi_control_WVALID,
        WREADY => s_axi_control_WREADY,
        WDATA => s_axi_control_WDATA,
        WSTRB => s_axi_control_WSTRB,
        ARVALID => s_axi_control_ARVALID,
        ARREADY => s_axi_control_ARREADY,
        ARADDR => s_axi_control_ARADDR,
        RVALID => s_axi_control_RVALID,
        RREADY => s_axi_control_RREADY,
        RDATA => s_axi_control_RDATA,
        RRESP => s_axi_control_RRESP,
        BVALID => s_axi_control_BVALID,
        BREADY => s_axi_control_BREADY,
        BRESP => s_axi_control_BRESP,
        ACLK => ap_clk,
        ARESET => ap_rst_n_inv,
        ACLK_EN => ap_const_logic_1,
        onoff_offset => onoff_offset);

    onoff_m_axi_U : component led_blink_onoff_m_axi
    generic map (
        CONSERVATIVE => 0,
        USER_DW => 8,
        USER_AW => 64,
        USER_MAXREQS => 5,
        NUM_READ_OUTSTANDING => 16,
        NUM_WRITE_OUTSTANDING => 16,
        MAX_READ_BURST_LENGTH => 16,
        MAX_WRITE_BURST_LENGTH => 16,
        C_M_AXI_ID_WIDTH => C_M_AXI_ONOFF_ID_WIDTH,
        C_M_AXI_ADDR_WIDTH => C_M_AXI_ONOFF_ADDR_WIDTH,
        C_M_AXI_DATA_WIDTH => C_M_AXI_ONOFF_DATA_WIDTH,
        C_M_AXI_AWUSER_WIDTH => C_M_AXI_ONOFF_AWUSER_WIDTH,
        C_M_AXI_ARUSER_WIDTH => C_M_AXI_ONOFF_ARUSER_WIDTH,
        C_M_AXI_WUSER_WIDTH => C_M_AXI_ONOFF_WUSER_WIDTH,
        C_M_AXI_RUSER_WIDTH => C_M_AXI_ONOFF_RUSER_WIDTH,
        C_M_AXI_BUSER_WIDTH => C_M_AXI_ONOFF_BUSER_WIDTH,
        C_USER_VALUE => C_M_AXI_ONOFF_USER_VALUE,
        C_PROT_VALUE => C_M_AXI_ONOFF_PROT_VALUE,
        C_CACHE_VALUE => C_M_AXI_ONOFF_CACHE_VALUE)
    port map (
        AWVALID => m_axi_onoff_AWVALID,
        AWREADY => m_axi_onoff_AWREADY,
        AWADDR => m_axi_onoff_AWADDR,
        AWID => m_axi_onoff_AWID,
        AWLEN => m_axi_onoff_AWLEN,
        AWSIZE => m_axi_onoff_AWSIZE,
        AWBURST => m_axi_onoff_AWBURST,
        AWLOCK => m_axi_onoff_AWLOCK,
        AWCACHE => m_axi_onoff_AWCACHE,
        AWPROT => m_axi_onoff_AWPROT,
        AWQOS => m_axi_onoff_AWQOS,
        AWREGION => m_axi_onoff_AWREGION,
        AWUSER => m_axi_onoff_AWUSER,
        WVALID => m_axi_onoff_WVALID,
        WREADY => m_axi_onoff_WREADY,
        WDATA => m_axi_onoff_WDATA,
        WSTRB => m_axi_onoff_WSTRB,
        WLAST => m_axi_onoff_WLAST,
        WID => m_axi_onoff_WID,
        WUSER => m_axi_onoff_WUSER,
        ARVALID => m_axi_onoff_ARVALID,
        ARREADY => m_axi_onoff_ARREADY,
        ARADDR => m_axi_onoff_ARADDR,
        ARID => m_axi_onoff_ARID,
        ARLEN => m_axi_onoff_ARLEN,
        ARSIZE => m_axi_onoff_ARSIZE,
        ARBURST => m_axi_onoff_ARBURST,
        ARLOCK => m_axi_onoff_ARLOCK,
        ARCACHE => m_axi_onoff_ARCACHE,
        ARPROT => m_axi_onoff_ARPROT,
        ARQOS => m_axi_onoff_ARQOS,
        ARREGION => m_axi_onoff_ARREGION,
        ARUSER => m_axi_onoff_ARUSER,
        RVALID => m_axi_onoff_RVALID,
        RREADY => m_axi_onoff_RREADY,
        RDATA => m_axi_onoff_RDATA,
        RLAST => m_axi_onoff_RLAST,
        RID => m_axi_onoff_RID,
        RUSER => m_axi_onoff_RUSER,
        RRESP => m_axi_onoff_RRESP,
        BVALID => m_axi_onoff_BVALID,
        BREADY => m_axi_onoff_BREADY,
        BRESP => m_axi_onoff_BRESP,
        BID => m_axi_onoff_BID,
        BUSER => m_axi_onoff_BUSER,
        ACLK => ap_clk,
        ARESET => ap_rst_n_inv,
        ACLK_EN => ap_const_logic_1,
        I_ARVALID => onoff_ARVALID,
        I_ARREADY => onoff_ARREADY,
        I_ARADDR => onoff_addr_reg_90,
        I_ARID => ap_const_lv1_0,
        I_ARLEN => ap_const_lv32_1,
        I_ARSIZE => ap_const_lv3_0,
        I_ARLOCK => ap_const_lv2_0,
        I_ARCACHE => ap_const_lv4_0,
        I_ARQOS => ap_const_lv4_0,
        I_ARPROT => ap_const_lv3_0,
        I_ARUSER => ap_const_lv1_0,
        I_ARBURST => ap_const_lv2_0,
        I_ARREGION => ap_const_lv4_0,
        I_RVALID => onoff_RVALID,
        I_RREADY => onoff_RREADY,
        I_RDATA => onoff_RDATA,
        I_RID => onoff_RID,
        I_RUSER => onoff_RUSER,
        I_RRESP => onoff_RRESP,
        I_RLAST => onoff_RLAST,
        I_AWVALID => ap_const_logic_0,
        I_AWREADY => onoff_AWREADY,
        I_AWADDR => ap_const_lv64_0,
        I_AWID => ap_const_lv1_0,
        I_AWLEN => ap_const_lv32_0,
        I_AWSIZE => ap_const_lv3_0,
        I_AWLOCK => ap_const_lv2_0,
        I_AWCACHE => ap_const_lv4_0,
        I_AWQOS => ap_const_lv4_0,
        I_AWPROT => ap_const_lv3_0,
        I_AWUSER => ap_const_lv1_0,
        I_AWBURST => ap_const_lv2_0,
        I_AWREGION => ap_const_lv4_0,
        I_WVALID => ap_const_logic_0,
        I_WREADY => onoff_WREADY,
        I_WDATA => ap_const_lv8_0,
        I_WID => ap_const_lv1_0,
        I_WUSER => ap_const_lv1_0,
        I_WLAST => ap_const_logic_0,
        I_WSTRB => ap_const_lv1_0,
        I_BVALID => onoff_BVALID,
        I_BREADY => ap_const_logic_0,
        I_BRESP => onoff_BRESP,
        I_BID => onoff_BID,
        I_BUSER => onoff_BUSER);





    ap_CS_fsm_assign_proc : process(ap_clk)
    begin
        if (ap_clk'event and ap_clk =  '1') then
            if (ap_rst_n_inv = '1') then
                ap_CS_fsm <= ap_ST_fsm_state1;
            else
                ap_CS_fsm <= ap_NS_fsm;
            end if;
        end if;
    end process;

    process (ap_clk)
    begin
        if (ap_clk'event and ap_clk = '1') then
            if ((ap_const_logic_1 = ap_CS_fsm_state1)) then
                onoff_addr_reg_90 <= onoff_offset;
            end if;
        end if;
    end process;

    ap_NS_fsm_assign_proc : process (ap_CS_fsm, ap_CS_fsm_state2, ap_CS_fsm_state9, onoff_ARREADY, onoff_RVALID)
    begin
        case ap_CS_fsm is
            when ap_ST_fsm_state1 => 
                ap_NS_fsm <= ap_ST_fsm_state2;
            when ap_ST_fsm_state2 => 
                if (((ap_const_logic_1 = ap_CS_fsm_state2) and (onoff_ARREADY = ap_const_logic_1))) then
                    ap_NS_fsm <= ap_ST_fsm_state3;
                else
                    ap_NS_fsm <= ap_ST_fsm_state2;
                end if;
            when ap_ST_fsm_state3 => 
                ap_NS_fsm <= ap_ST_fsm_state4;
            when ap_ST_fsm_state4 => 
                ap_NS_fsm <= ap_ST_fsm_state5;
            when ap_ST_fsm_state5 => 
                ap_NS_fsm <= ap_ST_fsm_state6;
            when ap_ST_fsm_state6 => 
                ap_NS_fsm <= ap_ST_fsm_state7;
            when ap_ST_fsm_state7 => 
                ap_NS_fsm <= ap_ST_fsm_state8;
            when ap_ST_fsm_state8 => 
                ap_NS_fsm <= ap_ST_fsm_state9;
            when ap_ST_fsm_state9 => 
                if (((ap_const_logic_1 = ap_CS_fsm_state9) and (onoff_RVALID = ap_const_logic_1))) then
                    ap_NS_fsm <= ap_ST_fsm_state1;
                else
                    ap_NS_fsm <= ap_ST_fsm_state9;
                end if;
            when others =>  
                ap_NS_fsm <= "XXXXXXXXX";
        end case;
    end process;
    ap_CS_fsm_state1 <= ap_CS_fsm(0);
    ap_CS_fsm_state2 <= ap_CS_fsm(1);
    ap_CS_fsm_state9 <= ap_CS_fsm(8);

    ap_rst_n_inv_assign_proc : process(ap_rst_n)
    begin
                ap_rst_n_inv <= not(ap_rst_n);
    end process;

    led <= std_logic_vector(IEEE.numeric_std.resize(unsigned(trunc_ln218_fu_81_p1),4));

    onoff_ARVALID_assign_proc : process(ap_CS_fsm_state2, onoff_ARREADY)
    begin
        if (((ap_const_logic_1 = ap_CS_fsm_state2) and (onoff_ARREADY = ap_const_logic_1))) then 
            onoff_ARVALID <= ap_const_logic_1;
        else 
            onoff_ARVALID <= ap_const_logic_0;
        end if; 
    end process;


    onoff_RREADY_assign_proc : process(ap_CS_fsm_state9, onoff_RVALID)
    begin
        if (((ap_const_logic_1 = ap_CS_fsm_state9) and (onoff_RVALID = ap_const_logic_1))) then 
            onoff_RREADY <= ap_const_logic_1;
        else 
            onoff_RREADY <= ap_const_logic_0;
        end if; 
    end process;


    onoff_blk_n_AR_assign_proc : process(m_axi_onoff_ARREADY, ap_CS_fsm_state2)
    begin
        if ((ap_const_logic_1 = ap_CS_fsm_state2)) then 
            onoff_blk_n_AR <= m_axi_onoff_ARREADY;
        else 
            onoff_blk_n_AR <= ap_const_logic_1;
        end if; 
    end process;


    onoff_blk_n_R_assign_proc : process(m_axi_onoff_RVALID, ap_CS_fsm_state9)
    begin
        if ((ap_const_logic_1 = ap_CS_fsm_state9)) then 
            onoff_blk_n_R <= m_axi_onoff_RVALID;
        else 
            onoff_blk_n_R <= ap_const_logic_1;
        end if; 
    end process;

    trunc_ln218_fu_81_p1 <= onoff_RDATA(1 - 1 downto 0);
end behav;