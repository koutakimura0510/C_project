-- ==============================================================
-- RTL generated by Vitis HLS - High-Level Synthesis from C, C++ and OpenCL v2020.2 (64-bit)
-- Version: 2020.2
-- Copyright (C) Copyright 1986-2020 Xilinx, Inc. All Rights Reserved.
-- 
-- ===========================================================

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity mapchip_dstin_loop_proc is
port (
    ap_clk : IN STD_LOGIC;
    ap_rst : IN STD_LOGIC;
    ap_start : IN STD_LOGIC;
    ap_done : OUT STD_LOGIC;
    ap_continue : IN STD_LOGIC;
    ap_idle : OUT STD_LOGIC;
    ap_ready : OUT STD_LOGIC;
    mapchip_draw_xsize_dout : IN STD_LOGIC_VECTOR (31 downto 0);
    mapchip_draw_xsize_empty_n : IN STD_LOGIC;
    mapchip_draw_xsize_read : OUT STD_LOGIC;
    y_dout : IN STD_LOGIC_VECTOR (31 downto 0);
    y_empty_n : IN STD_LOGIC;
    y_read : OUT STD_LOGIC;
    frame_size_dout : IN STD_LOGIC_VECTOR (31 downto 0);
    frame_size_empty_n : IN STD_LOGIC;
    frame_size_read : OUT STD_LOGIC;
    dstin_dout : IN STD_LOGIC_VECTOR (63 downto 0);
    dstin_empty_n : IN STD_LOGIC;
    dstin_read : OUT STD_LOGIC;
    m_axi_dst_AWVALID : OUT STD_LOGIC;
    m_axi_dst_AWREADY : IN STD_LOGIC;
    m_axi_dst_AWADDR : OUT STD_LOGIC_VECTOR (63 downto 0);
    m_axi_dst_AWID : OUT STD_LOGIC_VECTOR (0 downto 0);
    m_axi_dst_AWLEN : OUT STD_LOGIC_VECTOR (31 downto 0);
    m_axi_dst_AWSIZE : OUT STD_LOGIC_VECTOR (2 downto 0);
    m_axi_dst_AWBURST : OUT STD_LOGIC_VECTOR (1 downto 0);
    m_axi_dst_AWLOCK : OUT STD_LOGIC_VECTOR (1 downto 0);
    m_axi_dst_AWCACHE : OUT STD_LOGIC_VECTOR (3 downto 0);
    m_axi_dst_AWPROT : OUT STD_LOGIC_VECTOR (2 downto 0);
    m_axi_dst_AWQOS : OUT STD_LOGIC_VECTOR (3 downto 0);
    m_axi_dst_AWREGION : OUT STD_LOGIC_VECTOR (3 downto 0);
    m_axi_dst_AWUSER : OUT STD_LOGIC_VECTOR (0 downto 0);
    m_axi_dst_WVALID : OUT STD_LOGIC;
    m_axi_dst_WREADY : IN STD_LOGIC;
    m_axi_dst_WDATA : OUT STD_LOGIC_VECTOR (31 downto 0);
    m_axi_dst_WSTRB : OUT STD_LOGIC_VECTOR (3 downto 0);
    m_axi_dst_WLAST : OUT STD_LOGIC;
    m_axi_dst_WID : OUT STD_LOGIC_VECTOR (0 downto 0);
    m_axi_dst_WUSER : OUT STD_LOGIC_VECTOR (0 downto 0);
    m_axi_dst_ARVALID : OUT STD_LOGIC;
    m_axi_dst_ARREADY : IN STD_LOGIC;
    m_axi_dst_ARADDR : OUT STD_LOGIC_VECTOR (63 downto 0);
    m_axi_dst_ARID : OUT STD_LOGIC_VECTOR (0 downto 0);
    m_axi_dst_ARLEN : OUT STD_LOGIC_VECTOR (31 downto 0);
    m_axi_dst_ARSIZE : OUT STD_LOGIC_VECTOR (2 downto 0);
    m_axi_dst_ARBURST : OUT STD_LOGIC_VECTOR (1 downto 0);
    m_axi_dst_ARLOCK : OUT STD_LOGIC_VECTOR (1 downto 0);
    m_axi_dst_ARCACHE : OUT STD_LOGIC_VECTOR (3 downto 0);
    m_axi_dst_ARPROT : OUT STD_LOGIC_VECTOR (2 downto 0);
    m_axi_dst_ARQOS : OUT STD_LOGIC_VECTOR (3 downto 0);
    m_axi_dst_ARREGION : OUT STD_LOGIC_VECTOR (3 downto 0);
    m_axi_dst_ARUSER : OUT STD_LOGIC_VECTOR (0 downto 0);
    m_axi_dst_RVALID : IN STD_LOGIC;
    m_axi_dst_RREADY : OUT STD_LOGIC;
    m_axi_dst_RDATA : IN STD_LOGIC_VECTOR (31 downto 0);
    m_axi_dst_RLAST : IN STD_LOGIC;
    m_axi_dst_RID : IN STD_LOGIC_VECTOR (0 downto 0);
    m_axi_dst_RUSER : IN STD_LOGIC_VECTOR (0 downto 0);
    m_axi_dst_RRESP : IN STD_LOGIC_VECTOR (1 downto 0);
    m_axi_dst_BVALID : IN STD_LOGIC;
    m_axi_dst_BREADY : OUT STD_LOGIC;
    m_axi_dst_BRESP : IN STD_LOGIC_VECTOR (1 downto 0);
    m_axi_dst_BID : IN STD_LOGIC_VECTOR (0 downto 0);
    m_axi_dst_BUSER : IN STD_LOGIC_VECTOR (0 downto 0);
    dst_V2_address0 : OUT STD_LOGIC_VECTOR (9 downto 0);
    dst_V2_ce0 : OUT STD_LOGIC;
    dst_V2_we0 : OUT STD_LOGIC;
    dst_V2_d0 : OUT STD_LOGIC_VECTOR (31 downto 0) );
end;


architecture behav of mapchip_dstin_loop_proc is 
    constant ap_const_logic_1 : STD_LOGIC := '1';
    constant ap_const_logic_0 : STD_LOGIC := '0';
    constant ap_ST_fsm_state1 : STD_LOGIC_VECTOR (12 downto 0) := "0000000000001";
    constant ap_ST_fsm_state2 : STD_LOGIC_VECTOR (12 downto 0) := "0000000000010";
    constant ap_ST_fsm_state3 : STD_LOGIC_VECTOR (12 downto 0) := "0000000000100";
    constant ap_ST_fsm_state4 : STD_LOGIC_VECTOR (12 downto 0) := "0000000001000";
    constant ap_ST_fsm_state5 : STD_LOGIC_VECTOR (12 downto 0) := "0000000010000";
    constant ap_ST_fsm_state6 : STD_LOGIC_VECTOR (12 downto 0) := "0000000100000";
    constant ap_ST_fsm_state7 : STD_LOGIC_VECTOR (12 downto 0) := "0000001000000";
    constant ap_ST_fsm_state8 : STD_LOGIC_VECTOR (12 downto 0) := "0000010000000";
    constant ap_ST_fsm_state9 : STD_LOGIC_VECTOR (12 downto 0) := "0000100000000";
    constant ap_ST_fsm_state10 : STD_LOGIC_VECTOR (12 downto 0) := "0001000000000";
    constant ap_ST_fsm_state11 : STD_LOGIC_VECTOR (12 downto 0) := "0010000000000";
    constant ap_ST_fsm_pp0_stage0 : STD_LOGIC_VECTOR (12 downto 0) := "0100000000000";
    constant ap_ST_fsm_state15 : STD_LOGIC_VECTOR (12 downto 0) := "1000000000000";
    constant ap_const_lv32_0 : STD_LOGIC_VECTOR (31 downto 0) := "00000000000000000000000000000000";
    constant ap_const_boolean_1 : BOOLEAN := true;
    constant ap_const_lv64_0 : STD_LOGIC_VECTOR (63 downto 0) := "0000000000000000000000000000000000000000000000000000000000000000";
    constant ap_const_lv1_0 : STD_LOGIC_VECTOR (0 downto 0) := "0";
    constant ap_const_lv3_0 : STD_LOGIC_VECTOR (2 downto 0) := "000";
    constant ap_const_lv2_0 : STD_LOGIC_VECTOR (1 downto 0) := "00";
    constant ap_const_lv4_0 : STD_LOGIC_VECTOR (3 downto 0) := "0000";
    constant ap_const_lv32_4 : STD_LOGIC_VECTOR (31 downto 0) := "00000000000000000000000000000100";
    constant ap_const_lv32_B : STD_LOGIC_VECTOR (31 downto 0) := "00000000000000000000000000001011";
    constant ap_const_boolean_0 : BOOLEAN := false;
    constant ap_const_lv32_1 : STD_LOGIC_VECTOR (31 downto 0) := "00000000000000000000000000000001";
    constant ap_const_lv32_2 : STD_LOGIC_VECTOR (31 downto 0) := "00000000000000000000000000000010";
    constant ap_const_lv32_3 : STD_LOGIC_VECTOR (31 downto 0) := "00000000000000000000000000000011";
    constant ap_const_lv32_A : STD_LOGIC_VECTOR (31 downto 0) := "00000000000000000000000000001010";
    constant ap_const_lv1_1 : STD_LOGIC_VECTOR (0 downto 0) := "1";
    constant ap_const_lv32_3F : STD_LOGIC_VECTOR (31 downto 0) := "00000000000000000000000000111111";
    constant ap_const_lv32_C : STD_LOGIC_VECTOR (31 downto 0) := "00000000000000000000000000001100";

attribute shreg_extract : string;
    signal ap_done_reg : STD_LOGIC := '0';
    signal ap_CS_fsm : STD_LOGIC_VECTOR (12 downto 0) := "0000000000001";
    attribute fsm_encoding : string;
    attribute fsm_encoding of ap_CS_fsm : signal is "none";
    signal ap_CS_fsm_state1 : STD_LOGIC;
    attribute fsm_encoding of ap_CS_fsm_state1 : signal is "none";
    signal mapchip_draw_xsize_blk_n : STD_LOGIC;
    signal y_blk_n : STD_LOGIC;
    signal frame_size_blk_n : STD_LOGIC;
    signal dstin_blk_n : STD_LOGIC;
    signal dst_blk_n_AR : STD_LOGIC;
    signal ap_CS_fsm_state5 : STD_LOGIC;
    attribute fsm_encoding of ap_CS_fsm_state5 : signal is "none";
    signal dst_blk_n_R : STD_LOGIC;
    signal ap_CS_fsm_pp0_stage0 : STD_LOGIC;
    attribute fsm_encoding of ap_CS_fsm_pp0_stage0 : signal is "none";
    signal ap_enable_reg_pp0_iter1 : STD_LOGIC := '0';
    signal ap_block_pp0_stage0 : BOOLEAN;
    signal icmp_ln878_reg_241 : STD_LOGIC_VECTOR (0 downto 0);
    signal x_reg_122 : STD_LOGIC_VECTOR (31 downto 0);
    signal x_reg_122_pp0_iter1_reg : STD_LOGIC_VECTOR (31 downto 0);
    signal ap_block_state12_pp0_stage0_iter0 : BOOLEAN;
    signal ap_block_state13_pp0_stage0_iter1 : BOOLEAN;
    signal ap_block_state14_pp0_stage0_iter2 : BOOLEAN;
    signal ap_block_pp0_stage0_11001 : BOOLEAN;
    signal mapchip_draw_xsize_read_reg_194 : STD_LOGIC_VECTOR (31 downto 0);
    signal y_read_reg_200 : STD_LOGIC_VECTOR (31 downto 0);
    signal frame_size_read_reg_205 : STD_LOGIC_VECTOR (31 downto 0);
    signal dstin_read_reg_210 : STD_LOGIC_VECTOR (63 downto 0);
    signal ap_CS_fsm_state2 : STD_LOGIC;
    attribute fsm_encoding of ap_CS_fsm_state2 : signal is "none";
    signal grp_fu_140_p2 : STD_LOGIC_VECTOR (61 downto 0);
    signal mul_i_i70_i_reg_225 : STD_LOGIC_VECTOR (61 downto 0);
    signal ap_CS_fsm_state3 : STD_LOGIC;
    attribute fsm_encoding of ap_CS_fsm_state3 : signal is "none";
    signal dst_addr_reg_230 : STD_LOGIC_VECTOR (63 downto 0);
    signal ap_CS_fsm_state4 : STD_LOGIC;
    attribute fsm_encoding of ap_CS_fsm_state4 : signal is "none";
    signal add_ln78_fu_178_p2 : STD_LOGIC_VECTOR (31 downto 0);
    signal add_ln78_reg_236 : STD_LOGIC_VECTOR (31 downto 0);
    signal ap_enable_reg_pp0_iter0 : STD_LOGIC := '0';
    signal icmp_ln878_fu_184_p2 : STD_LOGIC_VECTOR (0 downto 0);
    signal icmp_ln878_reg_241_pp0_iter1_reg : STD_LOGIC_VECTOR (0 downto 0);
    signal dst_addr_read_reg_245 : STD_LOGIC_VECTOR (31 downto 0);
    signal ap_CS_fsm_state11 : STD_LOGIC;
    attribute fsm_encoding of ap_CS_fsm_state11 : signal is "none";
    signal ap_block_pp0_stage0_subdone : BOOLEAN;
    signal ap_condition_pp0_exit_iter0_state12 : STD_LOGIC;
    signal ap_enable_reg_pp0_iter2 : STD_LOGIC := '0';
    signal ap_phi_mux_x_phi_fu_126_p4 : STD_LOGIC_VECTOR (31 downto 0);
    signal zext_ln78_fu_189_p1 : STD_LOGIC_VECTOR (63 downto 0);
    signal sext_ln324_fu_168_p1 : STD_LOGIC_VECTOR (63 downto 0);
    signal ap_block_state1 : BOOLEAN;
    signal grp_fu_140_p0 : STD_LOGIC_VECTOR (31 downto 0);
    signal grp_fu_140_p1 : STD_LOGIC_VECTOR (31 downto 0);
    signal shl_ln324_2_fu_146_p3 : STD_LOGIC_VECTOR (63 downto 0);
    signal add_ln324_fu_153_p2 : STD_LOGIC_VECTOR (63 downto 0);
    signal trunc_ln324_3_fu_158_p4 : STD_LOGIC_VECTOR (61 downto 0);
    signal ap_CS_fsm_state15 : STD_LOGIC;
    attribute fsm_encoding of ap_CS_fsm_state15 : signal is "none";
    signal ap_NS_fsm : STD_LOGIC_VECTOR (12 downto 0);
    signal ap_idle_pp0 : STD_LOGIC;
    signal ap_enable_pp0 : STD_LOGIC;
    signal grp_fu_140_p00 : STD_LOGIC_VECTOR (61 downto 0);
    signal grp_fu_140_p10 : STD_LOGIC_VECTOR (61 downto 0);
    signal ap_ce_reg : STD_LOGIC;

    component mapchip_mul_32ns_32ns_62_2_1 IS
    generic (
        ID : INTEGER;
        NUM_STAGE : INTEGER;
        din0_WIDTH : INTEGER;
        din1_WIDTH : INTEGER;
        dout_WIDTH : INTEGER );
    port (
        clk : IN STD_LOGIC;
        reset : IN STD_LOGIC;
        din0 : IN STD_LOGIC_VECTOR (31 downto 0);
        din1 : IN STD_LOGIC_VECTOR (31 downto 0);
        ce : IN STD_LOGIC;
        dout : OUT STD_LOGIC_VECTOR (61 downto 0) );
    end component;



begin
    mul_32ns_32ns_62_2_1_U47 : component mapchip_mul_32ns_32ns_62_2_1
    generic map (
        ID => 1,
        NUM_STAGE => 2,
        din0_WIDTH => 32,
        din1_WIDTH => 32,
        dout_WIDTH => 62)
    port map (
        clk => ap_clk,
        reset => ap_rst,
        din0 => grp_fu_140_p0,
        din1 => grp_fu_140_p1,
        ce => ap_const_logic_1,
        dout => grp_fu_140_p2);





    ap_CS_fsm_assign_proc : process(ap_clk)
    begin
        if (ap_clk'event and ap_clk =  '1') then
            if (ap_rst = '1') then
                ap_CS_fsm <= ap_ST_fsm_state1;
            else
                ap_CS_fsm <= ap_NS_fsm;
            end if;
        end if;
    end process;


    ap_done_reg_assign_proc : process(ap_clk)
    begin
        if (ap_clk'event and ap_clk =  '1') then
            if (ap_rst = '1') then
                ap_done_reg <= ap_const_logic_0;
            else
                if ((ap_continue = ap_const_logic_1)) then 
                    ap_done_reg <= ap_const_logic_0;
                elsif ((ap_const_logic_1 = ap_CS_fsm_state15)) then 
                    ap_done_reg <= ap_const_logic_1;
                end if; 
            end if;
        end if;
    end process;


    ap_enable_reg_pp0_iter0_assign_proc : process(ap_clk)
    begin
        if (ap_clk'event and ap_clk =  '1') then
            if (ap_rst = '1') then
                ap_enable_reg_pp0_iter0 <= ap_const_logic_0;
            else
                if (((ap_const_logic_1 = ap_condition_pp0_exit_iter0_state12) and (ap_const_logic_1 = ap_CS_fsm_pp0_stage0) and (ap_const_boolean_0 = ap_block_pp0_stage0_subdone))) then 
                    ap_enable_reg_pp0_iter0 <= ap_const_logic_0;
                elsif ((ap_const_logic_1 = ap_CS_fsm_state11)) then 
                    ap_enable_reg_pp0_iter0 <= ap_const_logic_1;
                end if; 
            end if;
        end if;
    end process;


    ap_enable_reg_pp0_iter1_assign_proc : process(ap_clk)
    begin
        if (ap_clk'event and ap_clk =  '1') then
            if (ap_rst = '1') then
                ap_enable_reg_pp0_iter1 <= ap_const_logic_0;
            else
                if ((ap_const_boolean_0 = ap_block_pp0_stage0_subdone)) then
                    if ((ap_const_logic_1 = ap_condition_pp0_exit_iter0_state12)) then 
                        ap_enable_reg_pp0_iter1 <= (ap_const_logic_1 xor ap_condition_pp0_exit_iter0_state12);
                    elsif ((ap_const_boolean_1 = ap_const_boolean_1)) then 
                        ap_enable_reg_pp0_iter1 <= ap_enable_reg_pp0_iter0;
                    end if;
                end if; 
            end if;
        end if;
    end process;


    ap_enable_reg_pp0_iter2_assign_proc : process(ap_clk)
    begin
        if (ap_clk'event and ap_clk =  '1') then
            if (ap_rst = '1') then
                ap_enable_reg_pp0_iter2 <= ap_const_logic_0;
            else
                if ((ap_const_boolean_0 = ap_block_pp0_stage0_subdone)) then 
                    ap_enable_reg_pp0_iter2 <= ap_enable_reg_pp0_iter1;
                elsif ((ap_const_logic_1 = ap_CS_fsm_state11)) then 
                    ap_enable_reg_pp0_iter2 <= ap_const_logic_0;
                end if; 
            end if;
        end if;
    end process;


    x_reg_122_assign_proc : process (ap_clk)
    begin
        if (ap_clk'event and ap_clk = '1') then
            if ((ap_const_logic_1 = ap_CS_fsm_state11)) then 
                x_reg_122 <= ap_const_lv32_0;
            elsif (((ap_const_logic_1 = ap_CS_fsm_pp0_stage0) and (icmp_ln878_reg_241 = ap_const_lv1_0) and (ap_const_boolean_0 = ap_block_pp0_stage0_11001) and (ap_enable_reg_pp0_iter1 = ap_const_logic_1))) then 
                x_reg_122 <= add_ln78_reg_236;
            end if; 
        end if;
    end process;
    process (ap_clk)
    begin
        if (ap_clk'event and ap_clk = '1') then
            if (((ap_const_logic_1 = ap_CS_fsm_pp0_stage0) and (ap_enable_reg_pp0_iter0 = ap_const_logic_1) and (ap_const_boolean_0 = ap_block_pp0_stage0_11001))) then
                add_ln78_reg_236 <= add_ln78_fu_178_p2;
            end if;
        end if;
    end process;
    process (ap_clk)
    begin
        if (ap_clk'event and ap_clk = '1') then
            if (((ap_const_logic_1 = ap_CS_fsm_pp0_stage0) and (icmp_ln878_reg_241 = ap_const_lv1_0) and (ap_const_boolean_0 = ap_block_pp0_stage0_11001))) then
                dst_addr_read_reg_245 <= m_axi_dst_RDATA;
            end if;
        end if;
    end process;
    process (ap_clk)
    begin
        if (ap_clk'event and ap_clk = '1') then
            if ((ap_const_logic_1 = ap_CS_fsm_state4)) then
                dst_addr_reg_230 <= sext_ln324_fu_168_p1;
            end if;
        end if;
    end process;
    process (ap_clk)
    begin
        if (ap_clk'event and ap_clk = '1') then
            if ((ap_const_logic_1 = ap_CS_fsm_state1)) then
                dstin_read_reg_210 <= dstin_dout;
                frame_size_read_reg_205 <= frame_size_dout;
                mapchip_draw_xsize_read_reg_194 <= mapchip_draw_xsize_dout;
                y_read_reg_200 <= y_dout;
            end if;
        end if;
    end process;
    process (ap_clk)
    begin
        if (ap_clk'event and ap_clk = '1') then
            if (((ap_const_logic_1 = ap_CS_fsm_pp0_stage0) and (ap_const_boolean_0 = ap_block_pp0_stage0_11001))) then
                icmp_ln878_reg_241 <= icmp_ln878_fu_184_p2;
                icmp_ln878_reg_241_pp0_iter1_reg <= icmp_ln878_reg_241;
                x_reg_122_pp0_iter1_reg <= x_reg_122;
            end if;
        end if;
    end process;
    process (ap_clk)
    begin
        if (ap_clk'event and ap_clk = '1') then
            if ((ap_const_logic_1 = ap_CS_fsm_state3)) then
                mul_i_i70_i_reg_225 <= grp_fu_140_p2;
            end if;
        end if;
    end process;

    ap_NS_fsm_assign_proc : process (ap_start, ap_done_reg, ap_CS_fsm, ap_CS_fsm_state1, mapchip_draw_xsize_empty_n, y_empty_n, frame_size_empty_n, dstin_empty_n, m_axi_dst_ARREADY, ap_CS_fsm_state5, ap_enable_reg_pp0_iter1, ap_enable_reg_pp0_iter0, icmp_ln878_fu_184_p2, ap_block_pp0_stage0_subdone, ap_enable_reg_pp0_iter2)
    begin
        case ap_CS_fsm is
            when ap_ST_fsm_state1 => 
                if ((not(((dstin_empty_n = ap_const_logic_0) or (frame_size_empty_n = ap_const_logic_0) or (y_empty_n = ap_const_logic_0) or (mapchip_draw_xsize_empty_n = ap_const_logic_0) or (ap_done_reg = ap_const_logic_1) or (ap_start = ap_const_logic_0))) and (ap_const_logic_1 = ap_CS_fsm_state1))) then
                    ap_NS_fsm <= ap_ST_fsm_state2;
                else
                    ap_NS_fsm <= ap_ST_fsm_state1;
                end if;
            when ap_ST_fsm_state2 => 
                ap_NS_fsm <= ap_ST_fsm_state3;
            when ap_ST_fsm_state3 => 
                ap_NS_fsm <= ap_ST_fsm_state4;
            when ap_ST_fsm_state4 => 
                ap_NS_fsm <= ap_ST_fsm_state5;
            when ap_ST_fsm_state5 => 
                if (((m_axi_dst_ARREADY = ap_const_logic_1) and (ap_const_logic_1 = ap_CS_fsm_state5))) then
                    ap_NS_fsm <= ap_ST_fsm_state6;
                else
                    ap_NS_fsm <= ap_ST_fsm_state5;
                end if;
            when ap_ST_fsm_state6 => 
                ap_NS_fsm <= ap_ST_fsm_state7;
            when ap_ST_fsm_state7 => 
                ap_NS_fsm <= ap_ST_fsm_state8;
            when ap_ST_fsm_state8 => 
                ap_NS_fsm <= ap_ST_fsm_state9;
            when ap_ST_fsm_state9 => 
                ap_NS_fsm <= ap_ST_fsm_state10;
            when ap_ST_fsm_state10 => 
                ap_NS_fsm <= ap_ST_fsm_state11;
            when ap_ST_fsm_state11 => 
                ap_NS_fsm <= ap_ST_fsm_pp0_stage0;
            when ap_ST_fsm_pp0_stage0 => 
                if ((not(((icmp_ln878_fu_184_p2 = ap_const_lv1_1) and (ap_enable_reg_pp0_iter0 = ap_const_logic_1) and (ap_const_boolean_0 = ap_block_pp0_stage0_subdone) and (ap_enable_reg_pp0_iter1 = ap_const_logic_0))) and not(((ap_enable_reg_pp0_iter2 = ap_const_logic_1) and (ap_const_boolean_0 = ap_block_pp0_stage0_subdone) and (ap_enable_reg_pp0_iter1 = ap_const_logic_0))))) then
                    ap_NS_fsm <= ap_ST_fsm_pp0_stage0;
                elsif ((((ap_enable_reg_pp0_iter2 = ap_const_logic_1) and (ap_const_boolean_0 = ap_block_pp0_stage0_subdone) and (ap_enable_reg_pp0_iter1 = ap_const_logic_0)) or ((icmp_ln878_fu_184_p2 = ap_const_lv1_1) and (ap_enable_reg_pp0_iter0 = ap_const_logic_1) and (ap_const_boolean_0 = ap_block_pp0_stage0_subdone) and (ap_enable_reg_pp0_iter1 = ap_const_logic_0)))) then
                    ap_NS_fsm <= ap_ST_fsm_state15;
                else
                    ap_NS_fsm <= ap_ST_fsm_pp0_stage0;
                end if;
            when ap_ST_fsm_state15 => 
                ap_NS_fsm <= ap_ST_fsm_state1;
            when others =>  
                ap_NS_fsm <= "XXXXXXXXXXXXX";
        end case;
    end process;
    add_ln324_fu_153_p2 <= std_logic_vector(unsigned(dstin_read_reg_210) + unsigned(shl_ln324_2_fu_146_p3));
    add_ln78_fu_178_p2 <= std_logic_vector(unsigned(ap_phi_mux_x_phi_fu_126_p4) + unsigned(ap_const_lv32_1));
    ap_CS_fsm_pp0_stage0 <= ap_CS_fsm(11);
    ap_CS_fsm_state1 <= ap_CS_fsm(0);
    ap_CS_fsm_state11 <= ap_CS_fsm(10);
    ap_CS_fsm_state15 <= ap_CS_fsm(12);
    ap_CS_fsm_state2 <= ap_CS_fsm(1);
    ap_CS_fsm_state3 <= ap_CS_fsm(2);
    ap_CS_fsm_state4 <= ap_CS_fsm(3);
    ap_CS_fsm_state5 <= ap_CS_fsm(4);
        ap_block_pp0_stage0 <= not((ap_const_boolean_1 = ap_const_boolean_1));

    ap_block_pp0_stage0_11001_assign_proc : process(m_axi_dst_RVALID, ap_enable_reg_pp0_iter1, icmp_ln878_reg_241)
    begin
                ap_block_pp0_stage0_11001 <= ((m_axi_dst_RVALID = ap_const_logic_0) and (icmp_ln878_reg_241 = ap_const_lv1_0) and (ap_enable_reg_pp0_iter1 = ap_const_logic_1));
    end process;


    ap_block_pp0_stage0_subdone_assign_proc : process(m_axi_dst_RVALID, ap_enable_reg_pp0_iter1, icmp_ln878_reg_241)
    begin
                ap_block_pp0_stage0_subdone <= ((m_axi_dst_RVALID = ap_const_logic_0) and (icmp_ln878_reg_241 = ap_const_lv1_0) and (ap_enable_reg_pp0_iter1 = ap_const_logic_1));
    end process;


    ap_block_state1_assign_proc : process(ap_start, ap_done_reg, mapchip_draw_xsize_empty_n, y_empty_n, frame_size_empty_n, dstin_empty_n)
    begin
                ap_block_state1 <= ((dstin_empty_n = ap_const_logic_0) or (frame_size_empty_n = ap_const_logic_0) or (y_empty_n = ap_const_logic_0) or (mapchip_draw_xsize_empty_n = ap_const_logic_0) or (ap_done_reg = ap_const_logic_1) or (ap_start = ap_const_logic_0));
    end process;

        ap_block_state12_pp0_stage0_iter0 <= not((ap_const_boolean_1 = ap_const_boolean_1));

    ap_block_state13_pp0_stage0_iter1_assign_proc : process(m_axi_dst_RVALID, icmp_ln878_reg_241)
    begin
                ap_block_state13_pp0_stage0_iter1 <= ((m_axi_dst_RVALID = ap_const_logic_0) and (icmp_ln878_reg_241 = ap_const_lv1_0));
    end process;

        ap_block_state14_pp0_stage0_iter2 <= not((ap_const_boolean_1 = ap_const_boolean_1));

    ap_condition_pp0_exit_iter0_state12_assign_proc : process(icmp_ln878_fu_184_p2)
    begin
        if ((icmp_ln878_fu_184_p2 = ap_const_lv1_1)) then 
            ap_condition_pp0_exit_iter0_state12 <= ap_const_logic_1;
        else 
            ap_condition_pp0_exit_iter0_state12 <= ap_const_logic_0;
        end if; 
    end process;


    ap_done_assign_proc : process(ap_done_reg, ap_CS_fsm_state15)
    begin
        if ((ap_const_logic_1 = ap_CS_fsm_state15)) then 
            ap_done <= ap_const_logic_1;
        else 
            ap_done <= ap_done_reg;
        end if; 
    end process;

    ap_enable_pp0 <= (ap_idle_pp0 xor ap_const_logic_1);

    ap_idle_assign_proc : process(ap_start, ap_CS_fsm_state1)
    begin
        if (((ap_const_logic_1 = ap_CS_fsm_state1) and (ap_start = ap_const_logic_0))) then 
            ap_idle <= ap_const_logic_1;
        else 
            ap_idle <= ap_const_logic_0;
        end if; 
    end process;


    ap_idle_pp0_assign_proc : process(ap_enable_reg_pp0_iter1, ap_enable_reg_pp0_iter0, ap_enable_reg_pp0_iter2)
    begin
        if (((ap_enable_reg_pp0_iter2 = ap_const_logic_0) and (ap_enable_reg_pp0_iter0 = ap_const_logic_0) and (ap_enable_reg_pp0_iter1 = ap_const_logic_0))) then 
            ap_idle_pp0 <= ap_const_logic_1;
        else 
            ap_idle_pp0 <= ap_const_logic_0;
        end if; 
    end process;


    ap_phi_mux_x_phi_fu_126_p4_assign_proc : process(ap_CS_fsm_pp0_stage0, ap_enable_reg_pp0_iter1, ap_block_pp0_stage0, icmp_ln878_reg_241, x_reg_122, add_ln78_reg_236)
    begin
        if (((ap_const_logic_1 = ap_CS_fsm_pp0_stage0) and (icmp_ln878_reg_241 = ap_const_lv1_0) and (ap_const_boolean_0 = ap_block_pp0_stage0) and (ap_enable_reg_pp0_iter1 = ap_const_logic_1))) then 
            ap_phi_mux_x_phi_fu_126_p4 <= add_ln78_reg_236;
        else 
            ap_phi_mux_x_phi_fu_126_p4 <= x_reg_122;
        end if; 
    end process;


    ap_ready_assign_proc : process(ap_CS_fsm_state15)
    begin
        if ((ap_const_logic_1 = ap_CS_fsm_state15)) then 
            ap_ready <= ap_const_logic_1;
        else 
            ap_ready <= ap_const_logic_0;
        end if; 
    end process;

    dst_V2_address0 <= zext_ln78_fu_189_p1(10 - 1 downto 0);

    dst_V2_ce0_assign_proc : process(ap_block_pp0_stage0_11001, ap_enable_reg_pp0_iter2)
    begin
        if (((ap_enable_reg_pp0_iter2 = ap_const_logic_1) and (ap_const_boolean_0 = ap_block_pp0_stage0_11001))) then 
            dst_V2_ce0 <= ap_const_logic_1;
        else 
            dst_V2_ce0 <= ap_const_logic_0;
        end if; 
    end process;

    dst_V2_d0 <= dst_addr_read_reg_245;

    dst_V2_we0_assign_proc : process(ap_block_pp0_stage0_11001, icmp_ln878_reg_241_pp0_iter1_reg, ap_enable_reg_pp0_iter2)
    begin
        if (((ap_enable_reg_pp0_iter2 = ap_const_logic_1) and (icmp_ln878_reg_241_pp0_iter1_reg = ap_const_lv1_0) and (ap_const_boolean_0 = ap_block_pp0_stage0_11001))) then 
            dst_V2_we0 <= ap_const_logic_1;
        else 
            dst_V2_we0 <= ap_const_logic_0;
        end if; 
    end process;


    dst_blk_n_AR_assign_proc : process(m_axi_dst_ARREADY, ap_CS_fsm_state5)
    begin
        if ((ap_const_logic_1 = ap_CS_fsm_state5)) then 
            dst_blk_n_AR <= m_axi_dst_ARREADY;
        else 
            dst_blk_n_AR <= ap_const_logic_1;
        end if; 
    end process;


    dst_blk_n_R_assign_proc : process(m_axi_dst_RVALID, ap_CS_fsm_pp0_stage0, ap_enable_reg_pp0_iter1, ap_block_pp0_stage0, icmp_ln878_reg_241)
    begin
        if (((ap_const_logic_1 = ap_CS_fsm_pp0_stage0) and (icmp_ln878_reg_241 = ap_const_lv1_0) and (ap_const_boolean_0 = ap_block_pp0_stage0) and (ap_enable_reg_pp0_iter1 = ap_const_logic_1))) then 
            dst_blk_n_R <= m_axi_dst_RVALID;
        else 
            dst_blk_n_R <= ap_const_logic_1;
        end if; 
    end process;


    dstin_blk_n_assign_proc : process(ap_start, ap_done_reg, ap_CS_fsm_state1, dstin_empty_n)
    begin
        if ((not(((ap_done_reg = ap_const_logic_1) or (ap_start = ap_const_logic_0))) and (ap_const_logic_1 = ap_CS_fsm_state1))) then 
            dstin_blk_n <= dstin_empty_n;
        else 
            dstin_blk_n <= ap_const_logic_1;
        end if; 
    end process;


    dstin_read_assign_proc : process(ap_start, ap_done_reg, ap_CS_fsm_state1, mapchip_draw_xsize_empty_n, y_empty_n, frame_size_empty_n, dstin_empty_n)
    begin
        if ((not(((dstin_empty_n = ap_const_logic_0) or (frame_size_empty_n = ap_const_logic_0) or (y_empty_n = ap_const_logic_0) or (mapchip_draw_xsize_empty_n = ap_const_logic_0) or (ap_done_reg = ap_const_logic_1) or (ap_start = ap_const_logic_0))) and (ap_const_logic_1 = ap_CS_fsm_state1))) then 
            dstin_read <= ap_const_logic_1;
        else 
            dstin_read <= ap_const_logic_0;
        end if; 
    end process;


    frame_size_blk_n_assign_proc : process(ap_start, ap_done_reg, ap_CS_fsm_state1, frame_size_empty_n)
    begin
        if ((not(((ap_done_reg = ap_const_logic_1) or (ap_start = ap_const_logic_0))) and (ap_const_logic_1 = ap_CS_fsm_state1))) then 
            frame_size_blk_n <= frame_size_empty_n;
        else 
            frame_size_blk_n <= ap_const_logic_1;
        end if; 
    end process;


    frame_size_read_assign_proc : process(ap_start, ap_done_reg, ap_CS_fsm_state1, mapchip_draw_xsize_empty_n, y_empty_n, frame_size_empty_n, dstin_empty_n)
    begin
        if ((not(((dstin_empty_n = ap_const_logic_0) or (frame_size_empty_n = ap_const_logic_0) or (y_empty_n = ap_const_logic_0) or (mapchip_draw_xsize_empty_n = ap_const_logic_0) or (ap_done_reg = ap_const_logic_1) or (ap_start = ap_const_logic_0))) and (ap_const_logic_1 = ap_CS_fsm_state1))) then 
            frame_size_read <= ap_const_logic_1;
        else 
            frame_size_read <= ap_const_logic_0;
        end if; 
    end process;

    grp_fu_140_p0 <= grp_fu_140_p00(32 - 1 downto 0);
    grp_fu_140_p00 <= std_logic_vector(IEEE.numeric_std.resize(unsigned(y_read_reg_200),62));
    grp_fu_140_p1 <= grp_fu_140_p10(32 - 1 downto 0);
    grp_fu_140_p10 <= std_logic_vector(IEEE.numeric_std.resize(unsigned(frame_size_read_reg_205),62));
    icmp_ln878_fu_184_p2 <= "1" when (ap_phi_mux_x_phi_fu_126_p4 = mapchip_draw_xsize_read_reg_194) else "0";
    m_axi_dst_ARADDR <= dst_addr_reg_230;
    m_axi_dst_ARBURST <= ap_const_lv2_0;
    m_axi_dst_ARCACHE <= ap_const_lv4_0;
    m_axi_dst_ARID <= ap_const_lv1_0;
    m_axi_dst_ARLEN <= mapchip_draw_xsize_read_reg_194;
    m_axi_dst_ARLOCK <= ap_const_lv2_0;
    m_axi_dst_ARPROT <= ap_const_lv3_0;
    m_axi_dst_ARQOS <= ap_const_lv4_0;
    m_axi_dst_ARREGION <= ap_const_lv4_0;
    m_axi_dst_ARSIZE <= ap_const_lv3_0;
    m_axi_dst_ARUSER <= ap_const_lv1_0;

    m_axi_dst_ARVALID_assign_proc : process(m_axi_dst_ARREADY, ap_CS_fsm_state5)
    begin
        if (((m_axi_dst_ARREADY = ap_const_logic_1) and (ap_const_logic_1 = ap_CS_fsm_state5))) then 
            m_axi_dst_ARVALID <= ap_const_logic_1;
        else 
            m_axi_dst_ARVALID <= ap_const_logic_0;
        end if; 
    end process;

    m_axi_dst_AWADDR <= ap_const_lv64_0;
    m_axi_dst_AWBURST <= ap_const_lv2_0;
    m_axi_dst_AWCACHE <= ap_const_lv4_0;
    m_axi_dst_AWID <= ap_const_lv1_0;
    m_axi_dst_AWLEN <= ap_const_lv32_0;
    m_axi_dst_AWLOCK <= ap_const_lv2_0;
    m_axi_dst_AWPROT <= ap_const_lv3_0;
    m_axi_dst_AWQOS <= ap_const_lv4_0;
    m_axi_dst_AWREGION <= ap_const_lv4_0;
    m_axi_dst_AWSIZE <= ap_const_lv3_0;
    m_axi_dst_AWUSER <= ap_const_lv1_0;
    m_axi_dst_AWVALID <= ap_const_logic_0;
    m_axi_dst_BREADY <= ap_const_logic_0;

    m_axi_dst_RREADY_assign_proc : process(ap_CS_fsm_pp0_stage0, ap_enable_reg_pp0_iter1, icmp_ln878_reg_241, ap_block_pp0_stage0_11001)
    begin
        if (((ap_const_logic_1 = ap_CS_fsm_pp0_stage0) and (icmp_ln878_reg_241 = ap_const_lv1_0) and (ap_const_boolean_0 = ap_block_pp0_stage0_11001) and (ap_enable_reg_pp0_iter1 = ap_const_logic_1))) then 
            m_axi_dst_RREADY <= ap_const_logic_1;
        else 
            m_axi_dst_RREADY <= ap_const_logic_0;
        end if; 
    end process;

    m_axi_dst_WDATA <= ap_const_lv32_0;
    m_axi_dst_WID <= ap_const_lv1_0;
    m_axi_dst_WLAST <= ap_const_logic_0;
    m_axi_dst_WSTRB <= ap_const_lv4_0;
    m_axi_dst_WUSER <= ap_const_lv1_0;
    m_axi_dst_WVALID <= ap_const_logic_0;

    mapchip_draw_xsize_blk_n_assign_proc : process(ap_start, ap_done_reg, ap_CS_fsm_state1, mapchip_draw_xsize_empty_n)
    begin
        if ((not(((ap_done_reg = ap_const_logic_1) or (ap_start = ap_const_logic_0))) and (ap_const_logic_1 = ap_CS_fsm_state1))) then 
            mapchip_draw_xsize_blk_n <= mapchip_draw_xsize_empty_n;
        else 
            mapchip_draw_xsize_blk_n <= ap_const_logic_1;
        end if; 
    end process;


    mapchip_draw_xsize_read_assign_proc : process(ap_start, ap_done_reg, ap_CS_fsm_state1, mapchip_draw_xsize_empty_n, y_empty_n, frame_size_empty_n, dstin_empty_n)
    begin
        if ((not(((dstin_empty_n = ap_const_logic_0) or (frame_size_empty_n = ap_const_logic_0) or (y_empty_n = ap_const_logic_0) or (mapchip_draw_xsize_empty_n = ap_const_logic_0) or (ap_done_reg = ap_const_logic_1) or (ap_start = ap_const_logic_0))) and (ap_const_logic_1 = ap_CS_fsm_state1))) then 
            mapchip_draw_xsize_read <= ap_const_logic_1;
        else 
            mapchip_draw_xsize_read <= ap_const_logic_0;
        end if; 
    end process;

        sext_ln324_fu_168_p1 <= std_logic_vector(IEEE.numeric_std.resize(signed(trunc_ln324_3_fu_158_p4),64));

    shl_ln324_2_fu_146_p3 <= (mul_i_i70_i_reg_225 & ap_const_lv2_0);
    trunc_ln324_3_fu_158_p4 <= add_ln324_fu_153_p2(63 downto 2);

    y_blk_n_assign_proc : process(ap_start, ap_done_reg, ap_CS_fsm_state1, y_empty_n)
    begin
        if ((not(((ap_done_reg = ap_const_logic_1) or (ap_start = ap_const_logic_0))) and (ap_const_logic_1 = ap_CS_fsm_state1))) then 
            y_blk_n <= y_empty_n;
        else 
            y_blk_n <= ap_const_logic_1;
        end if; 
    end process;


    y_read_assign_proc : process(ap_start, ap_done_reg, ap_CS_fsm_state1, mapchip_draw_xsize_empty_n, y_empty_n, frame_size_empty_n, dstin_empty_n)
    begin
        if ((not(((dstin_empty_n = ap_const_logic_0) or (frame_size_empty_n = ap_const_logic_0) or (y_empty_n = ap_const_logic_0) or (mapchip_draw_xsize_empty_n = ap_const_logic_0) or (ap_done_reg = ap_const_logic_1) or (ap_start = ap_const_logic_0))) and (ap_const_logic_1 = ap_CS_fsm_state1))) then 
            y_read <= ap_const_logic_1;
        else 
            y_read <= ap_const_logic_0;
        end if; 
    end process;

    zext_ln78_fu_189_p1 <= std_logic_vector(IEEE.numeric_std.resize(unsigned(x_reg_122_pp0_iter1_reg),64));
end behav;
