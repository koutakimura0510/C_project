// ==============================================================
// RTL generated by Vitis HLS - High-Level Synthesis from C, C++ and OpenCL v2020.2 (64-bit)
// Version: 2020.2
// Copyright (C) Copyright 1986-2020 Xilinx, Inc. All Rights Reserved.
// 
// ===========================================================

`timescale 1 ns / 1 ps 

module framebuffer_copy_width_loop_proc5 (
        ap_clk,
        ap_rst,
        ap_start,
        ap_done,
        ap_continue,
        ap_idle,
        ap_ready,
        width,
        y,
        display_xsize,
        copy,
        m_axi_cp_AWVALID,
        m_axi_cp_AWREADY,
        m_axi_cp_AWADDR,
        m_axi_cp_AWID,
        m_axi_cp_AWLEN,
        m_axi_cp_AWSIZE,
        m_axi_cp_AWBURST,
        m_axi_cp_AWLOCK,
        m_axi_cp_AWCACHE,
        m_axi_cp_AWPROT,
        m_axi_cp_AWQOS,
        m_axi_cp_AWREGION,
        m_axi_cp_AWUSER,
        m_axi_cp_WVALID,
        m_axi_cp_WREADY,
        m_axi_cp_WDATA,
        m_axi_cp_WSTRB,
        m_axi_cp_WLAST,
        m_axi_cp_WID,
        m_axi_cp_WUSER,
        m_axi_cp_ARVALID,
        m_axi_cp_ARREADY,
        m_axi_cp_ARADDR,
        m_axi_cp_ARID,
        m_axi_cp_ARLEN,
        m_axi_cp_ARSIZE,
        m_axi_cp_ARBURST,
        m_axi_cp_ARLOCK,
        m_axi_cp_ARCACHE,
        m_axi_cp_ARPROT,
        m_axi_cp_ARQOS,
        m_axi_cp_ARREGION,
        m_axi_cp_ARUSER,
        m_axi_cp_RVALID,
        m_axi_cp_RREADY,
        m_axi_cp_RDATA,
        m_axi_cp_RLAST,
        m_axi_cp_RID,
        m_axi_cp_RUSER,
        m_axi_cp_RRESP,
        m_axi_cp_BVALID,
        m_axi_cp_BREADY,
        m_axi_cp_BRESP,
        m_axi_cp_BID,
        m_axi_cp_BUSER,
        src_V1_address0,
        src_V1_ce0,
        src_V1_we0,
        src_V1_d0,
        update,
        width_out_din,
        width_out_full_n,
        width_out_write,
        y_out_din,
        y_out_full_n,
        y_out_write,
        display_xsize_out_din,
        display_xsize_out_full_n,
        display_xsize_out_write,
        update_out_din,
        update_out_full_n,
        update_out_write
);

parameter    ap_ST_fsm_state1 = 12'd1;
parameter    ap_ST_fsm_state2 = 12'd2;
parameter    ap_ST_fsm_state3 = 12'd4;
parameter    ap_ST_fsm_state4 = 12'd8;
parameter    ap_ST_fsm_state5 = 12'd16;
parameter    ap_ST_fsm_state6 = 12'd32;
parameter    ap_ST_fsm_state7 = 12'd64;
parameter    ap_ST_fsm_state8 = 12'd128;
parameter    ap_ST_fsm_state9 = 12'd256;
parameter    ap_ST_fsm_state10 = 12'd512;
parameter    ap_ST_fsm_pp0_stage0 = 12'd1024;
parameter    ap_ST_fsm_state14 = 12'd2048;

input   ap_clk;
input   ap_rst;
input   ap_start;
output   ap_done;
input   ap_continue;
output   ap_idle;
output   ap_ready;
input  [31:0] width;
input  [31:0] y;
input  [31:0] display_xsize;
input  [63:0] copy;
output   m_axi_cp_AWVALID;
input   m_axi_cp_AWREADY;
output  [63:0] m_axi_cp_AWADDR;
output  [0:0] m_axi_cp_AWID;
output  [31:0] m_axi_cp_AWLEN;
output  [2:0] m_axi_cp_AWSIZE;
output  [1:0] m_axi_cp_AWBURST;
output  [1:0] m_axi_cp_AWLOCK;
output  [3:0] m_axi_cp_AWCACHE;
output  [2:0] m_axi_cp_AWPROT;
output  [3:0] m_axi_cp_AWQOS;
output  [3:0] m_axi_cp_AWREGION;
output  [0:0] m_axi_cp_AWUSER;
output   m_axi_cp_WVALID;
input   m_axi_cp_WREADY;
output  [31:0] m_axi_cp_WDATA;
output  [3:0] m_axi_cp_WSTRB;
output   m_axi_cp_WLAST;
output  [0:0] m_axi_cp_WID;
output  [0:0] m_axi_cp_WUSER;
output   m_axi_cp_ARVALID;
input   m_axi_cp_ARREADY;
output  [63:0] m_axi_cp_ARADDR;
output  [0:0] m_axi_cp_ARID;
output  [31:0] m_axi_cp_ARLEN;
output  [2:0] m_axi_cp_ARSIZE;
output  [1:0] m_axi_cp_ARBURST;
output  [1:0] m_axi_cp_ARLOCK;
output  [3:0] m_axi_cp_ARCACHE;
output  [2:0] m_axi_cp_ARPROT;
output  [3:0] m_axi_cp_ARQOS;
output  [3:0] m_axi_cp_ARREGION;
output  [0:0] m_axi_cp_ARUSER;
input   m_axi_cp_RVALID;
output   m_axi_cp_RREADY;
input  [31:0] m_axi_cp_RDATA;
input   m_axi_cp_RLAST;
input  [0:0] m_axi_cp_RID;
input  [0:0] m_axi_cp_RUSER;
input  [1:0] m_axi_cp_RRESP;
input   m_axi_cp_BVALID;
output   m_axi_cp_BREADY;
input  [1:0] m_axi_cp_BRESP;
input  [0:0] m_axi_cp_BID;
input  [0:0] m_axi_cp_BUSER;
output  [9:0] src_V1_address0;
output   src_V1_ce0;
output   src_V1_we0;
output  [31:0] src_V1_d0;
input  [63:0] update;
output  [31:0] width_out_din;
input   width_out_full_n;
output   width_out_write;
output  [31:0] y_out_din;
input   y_out_full_n;
output   y_out_write;
output  [31:0] display_xsize_out_din;
input   display_xsize_out_full_n;
output   display_xsize_out_write;
output  [63:0] update_out_din;
input   update_out_full_n;
output   update_out_write;

reg ap_done;
reg ap_idle;
reg ap_ready;
reg m_axi_cp_ARVALID;
reg m_axi_cp_RREADY;
reg src_V1_ce0;
reg src_V1_we0;
reg width_out_write;
reg y_out_write;
reg display_xsize_out_write;
reg update_out_write;

reg    ap_done_reg;
(* fsm_encoding = "none" *) reg   [11:0] ap_CS_fsm;
wire    ap_CS_fsm_state1;
reg    cp_blk_n_AR;
wire    ap_CS_fsm_state4;
reg    cp_blk_n_R;
wire    ap_CS_fsm_pp0_stage0;
reg    ap_enable_reg_pp0_iter1;
wire    ap_block_pp0_stage0;
reg   [0:0] icmp_ln878_reg_281;
reg    width_out_blk_n;
reg    y_out_blk_n;
reg    display_xsize_out_blk_n;
reg    update_out_blk_n;
reg   [31:0] x_reg_174;
reg   [31:0] x_reg_174_pp0_iter1_reg;
wire    ap_block_state11_pp0_stage0_iter0;
reg    ap_block_state12_pp0_stage0_iter1;
wire    ap_block_state13_pp0_stage0_iter2;
reg    ap_block_pp0_stage0_11001;
wire   [61:0] grp_fu_194_p2;
reg   [61:0] mul_i_i58_i_i_reg_265;
wire    ap_CS_fsm_state2;
reg   [63:0] cp_addr_reg_270;
wire    ap_CS_fsm_state3;
wire   [31:0] add_ln19_fu_233_p2;
reg   [31:0] add_ln19_reg_276;
reg    ap_enable_reg_pp0_iter0;
wire   [0:0] icmp_ln878_fu_239_p2;
reg   [0:0] icmp_ln878_reg_281_pp0_iter1_reg;
reg   [31:0] cp_addr_read_reg_285;
wire    ap_CS_fsm_state10;
reg    ap_block_pp0_stage0_subdone;
reg    ap_condition_pp0_exit_iter0_state11;
reg    ap_enable_reg_pp0_iter2;
reg   [31:0] ap_phi_mux_x_phi_fu_178_p4;
wire   [63:0] zext_ln19_fu_244_p1;
wire  signed [63:0] sext_ln324_fu_223_p1;
reg    ap_block_state1;
wire   [31:0] grp_fu_194_p0;
wire   [31:0] grp_fu_194_p1;
wire   [63:0] shl_ln324_1_fu_200_p3;
wire   [63:0] add_ln324_fu_207_p2;
wire   [61:0] trunc_ln324_1_fu_213_p4;
reg    grp_fu_194_ce;
wire    ap_CS_fsm_state14;
reg   [11:0] ap_NS_fsm;
reg    ap_idle_pp0;
wire    ap_enable_pp0;
wire   [61:0] grp_fu_194_p00;
wire   [61:0] grp_fu_194_p10;
wire    ap_ce_reg;

// power-on initialization
initial begin
#0 ap_done_reg = 1'b0;
#0 ap_CS_fsm = 12'd1;
#0 ap_enable_reg_pp0_iter1 = 1'b0;
#0 ap_enable_reg_pp0_iter0 = 1'b0;
#0 ap_enable_reg_pp0_iter2 = 1'b0;
end

framebuffer_copy_mul_32ns_32ns_62_2_1 #(
    .ID( 1 ),
    .NUM_STAGE( 2 ),
    .din0_WIDTH( 32 ),
    .din1_WIDTH( 32 ),
    .dout_WIDTH( 62 ))
mul_32ns_32ns_62_2_1_U1(
    .clk(ap_clk),
    .reset(ap_rst),
    .din0(grp_fu_194_p0),
    .din1(grp_fu_194_p1),
    .ce(grp_fu_194_ce),
    .dout(grp_fu_194_p2)
);

always @ (posedge ap_clk) begin
    if (ap_rst == 1'b1) begin
        ap_CS_fsm <= ap_ST_fsm_state1;
    end else begin
        ap_CS_fsm <= ap_NS_fsm;
    end
end

always @ (posedge ap_clk) begin
    if (ap_rst == 1'b1) begin
        ap_done_reg <= 1'b0;
    end else begin
        if ((ap_continue == 1'b1)) begin
            ap_done_reg <= 1'b0;
        end else if ((1'b1 == ap_CS_fsm_state14)) begin
            ap_done_reg <= 1'b1;
        end
    end
end

always @ (posedge ap_clk) begin
    if (ap_rst == 1'b1) begin
        ap_enable_reg_pp0_iter0 <= 1'b0;
    end else begin
        if (((1'b1 == ap_condition_pp0_exit_iter0_state11) & (1'b1 == ap_CS_fsm_pp0_stage0) & (1'b0 == ap_block_pp0_stage0_subdone))) begin
            ap_enable_reg_pp0_iter0 <= 1'b0;
        end else if ((1'b1 == ap_CS_fsm_state10)) begin
            ap_enable_reg_pp0_iter0 <= 1'b1;
        end
    end
end

always @ (posedge ap_clk) begin
    if (ap_rst == 1'b1) begin
        ap_enable_reg_pp0_iter1 <= 1'b0;
    end else begin
        if ((1'b0 == ap_block_pp0_stage0_subdone)) begin
            if ((1'b1 == ap_condition_pp0_exit_iter0_state11)) begin
                ap_enable_reg_pp0_iter1 <= (1'b1 ^ ap_condition_pp0_exit_iter0_state11);
            end else if ((1'b1 == 1'b1)) begin
                ap_enable_reg_pp0_iter1 <= ap_enable_reg_pp0_iter0;
            end
        end
    end
end

always @ (posedge ap_clk) begin
    if (ap_rst == 1'b1) begin
        ap_enable_reg_pp0_iter2 <= 1'b0;
    end else begin
        if ((1'b0 == ap_block_pp0_stage0_subdone)) begin
            ap_enable_reg_pp0_iter2 <= ap_enable_reg_pp0_iter1;
        end else if ((1'b1 == ap_CS_fsm_state10)) begin
            ap_enable_reg_pp0_iter2 <= 1'b0;
        end
    end
end

always @ (posedge ap_clk) begin
    if ((1'b1 == ap_CS_fsm_state10)) begin
        x_reg_174 <= 32'd0;
    end else if (((1'b1 == ap_CS_fsm_pp0_stage0) & (icmp_ln878_reg_281 == 1'd0) & (1'b0 == ap_block_pp0_stage0_11001) & (ap_enable_reg_pp0_iter1 == 1'b1))) begin
        x_reg_174 <= add_ln19_reg_276;
    end
end

always @ (posedge ap_clk) begin
    if (((1'b1 == ap_CS_fsm_pp0_stage0) & (ap_enable_reg_pp0_iter0 == 1'b1) & (1'b0 == ap_block_pp0_stage0_11001))) begin
        add_ln19_reg_276 <= add_ln19_fu_233_p2;
    end
end

always @ (posedge ap_clk) begin
    if (((1'b1 == ap_CS_fsm_pp0_stage0) & (icmp_ln878_reg_281 == 1'd0) & (1'b0 == ap_block_pp0_stage0_11001))) begin
        cp_addr_read_reg_285 <= m_axi_cp_RDATA;
    end
end

always @ (posedge ap_clk) begin
    if ((1'b1 == ap_CS_fsm_state3)) begin
        cp_addr_reg_270 <= sext_ln324_fu_223_p1;
    end
end

always @ (posedge ap_clk) begin
    if (((1'b1 == ap_CS_fsm_pp0_stage0) & (1'b0 == ap_block_pp0_stage0_11001))) begin
        icmp_ln878_reg_281 <= icmp_ln878_fu_239_p2;
        icmp_ln878_reg_281_pp0_iter1_reg <= icmp_ln878_reg_281;
        x_reg_174_pp0_iter1_reg <= x_reg_174;
    end
end

always @ (posedge ap_clk) begin
    if ((1'b1 == ap_CS_fsm_state2)) begin
        mul_i_i58_i_i_reg_265 <= grp_fu_194_p2;
    end
end

always @ (*) begin
    if ((icmp_ln878_fu_239_p2 == 1'd1)) begin
        ap_condition_pp0_exit_iter0_state11 = 1'b1;
    end else begin
        ap_condition_pp0_exit_iter0_state11 = 1'b0;
    end
end

always @ (*) begin
    if ((1'b1 == ap_CS_fsm_state14)) begin
        ap_done = 1'b1;
    end else begin
        ap_done = ap_done_reg;
    end
end

always @ (*) begin
    if (((1'b1 == ap_CS_fsm_state1) & (ap_start == 1'b0))) begin
        ap_idle = 1'b1;
    end else begin
        ap_idle = 1'b0;
    end
end

always @ (*) begin
    if (((ap_enable_reg_pp0_iter2 == 1'b0) & (ap_enable_reg_pp0_iter0 == 1'b0) & (ap_enable_reg_pp0_iter1 == 1'b0))) begin
        ap_idle_pp0 = 1'b1;
    end else begin
        ap_idle_pp0 = 1'b0;
    end
end

always @ (*) begin
    if (((1'b1 == ap_CS_fsm_pp0_stage0) & (icmp_ln878_reg_281 == 1'd0) & (1'b0 == ap_block_pp0_stage0) & (ap_enable_reg_pp0_iter1 == 1'b1))) begin
        ap_phi_mux_x_phi_fu_178_p4 = add_ln19_reg_276;
    end else begin
        ap_phi_mux_x_phi_fu_178_p4 = x_reg_174;
    end
end

always @ (*) begin
    if ((1'b1 == ap_CS_fsm_state14)) begin
        ap_ready = 1'b1;
    end else begin
        ap_ready = 1'b0;
    end
end

always @ (*) begin
    if ((1'b1 == ap_CS_fsm_state4)) begin
        cp_blk_n_AR = m_axi_cp_ARREADY;
    end else begin
        cp_blk_n_AR = 1'b1;
    end
end

always @ (*) begin
    if (((1'b1 == ap_CS_fsm_pp0_stage0) & (icmp_ln878_reg_281 == 1'd0) & (1'b0 == ap_block_pp0_stage0) & (ap_enable_reg_pp0_iter1 == 1'b1))) begin
        cp_blk_n_R = m_axi_cp_RVALID;
    end else begin
        cp_blk_n_R = 1'b1;
    end
end

always @ (*) begin
    if ((~((ap_done_reg == 1'b1) | (ap_start == 1'b0)) & (1'b1 == ap_CS_fsm_state1))) begin
        display_xsize_out_blk_n = display_xsize_out_full_n;
    end else begin
        display_xsize_out_blk_n = 1'b1;
    end
end

always @ (*) begin
    if ((~((ap_done_reg == 1'b1) | (ap_start == 1'b0) | (update_out_full_n == 1'b0) | (display_xsize_out_full_n == 1'b0) | (y_out_full_n == 1'b0) | (width_out_full_n == 1'b0)) & (1'b1 == ap_CS_fsm_state1))) begin
        display_xsize_out_write = 1'b1;
    end else begin
        display_xsize_out_write = 1'b0;
    end
end

always @ (*) begin
    if (((1'b1 == ap_CS_fsm_state2) | (~((ap_done_reg == 1'b1) | (ap_start == 1'b0) | (update_out_full_n == 1'b0) | (display_xsize_out_full_n == 1'b0) | (y_out_full_n == 1'b0) | (width_out_full_n == 1'b0)) & (1'b1 == ap_CS_fsm_state1)))) begin
        grp_fu_194_ce = 1'b1;
    end else begin
        grp_fu_194_ce = 1'b0;
    end
end

always @ (*) begin
    if (((m_axi_cp_ARREADY == 1'b1) & (1'b1 == ap_CS_fsm_state4))) begin
        m_axi_cp_ARVALID = 1'b1;
    end else begin
        m_axi_cp_ARVALID = 1'b0;
    end
end

always @ (*) begin
    if (((1'b1 == ap_CS_fsm_pp0_stage0) & (icmp_ln878_reg_281 == 1'd0) & (1'b0 == ap_block_pp0_stage0_11001) & (ap_enable_reg_pp0_iter1 == 1'b1))) begin
        m_axi_cp_RREADY = 1'b1;
    end else begin
        m_axi_cp_RREADY = 1'b0;
    end
end

always @ (*) begin
    if (((ap_enable_reg_pp0_iter2 == 1'b1) & (1'b0 == ap_block_pp0_stage0_11001))) begin
        src_V1_ce0 = 1'b1;
    end else begin
        src_V1_ce0 = 1'b0;
    end
end

always @ (*) begin
    if (((ap_enable_reg_pp0_iter2 == 1'b1) & (icmp_ln878_reg_281_pp0_iter1_reg == 1'd0) & (1'b0 == ap_block_pp0_stage0_11001))) begin
        src_V1_we0 = 1'b1;
    end else begin
        src_V1_we0 = 1'b0;
    end
end

always @ (*) begin
    if ((~((ap_done_reg == 1'b1) | (ap_start == 1'b0)) & (1'b1 == ap_CS_fsm_state1))) begin
        update_out_blk_n = update_out_full_n;
    end else begin
        update_out_blk_n = 1'b1;
    end
end

always @ (*) begin
    if ((~((ap_done_reg == 1'b1) | (ap_start == 1'b0) | (update_out_full_n == 1'b0) | (display_xsize_out_full_n == 1'b0) | (y_out_full_n == 1'b0) | (width_out_full_n == 1'b0)) & (1'b1 == ap_CS_fsm_state1))) begin
        update_out_write = 1'b1;
    end else begin
        update_out_write = 1'b0;
    end
end

always @ (*) begin
    if ((~((ap_done_reg == 1'b1) | (ap_start == 1'b0)) & (1'b1 == ap_CS_fsm_state1))) begin
        width_out_blk_n = width_out_full_n;
    end else begin
        width_out_blk_n = 1'b1;
    end
end

always @ (*) begin
    if ((~((ap_done_reg == 1'b1) | (ap_start == 1'b0) | (update_out_full_n == 1'b0) | (display_xsize_out_full_n == 1'b0) | (y_out_full_n == 1'b0) | (width_out_full_n == 1'b0)) & (1'b1 == ap_CS_fsm_state1))) begin
        width_out_write = 1'b1;
    end else begin
        width_out_write = 1'b0;
    end
end

always @ (*) begin
    if ((~((ap_done_reg == 1'b1) | (ap_start == 1'b0)) & (1'b1 == ap_CS_fsm_state1))) begin
        y_out_blk_n = y_out_full_n;
    end else begin
        y_out_blk_n = 1'b1;
    end
end

always @ (*) begin
    if ((~((ap_done_reg == 1'b1) | (ap_start == 1'b0) | (update_out_full_n == 1'b0) | (display_xsize_out_full_n == 1'b0) | (y_out_full_n == 1'b0) | (width_out_full_n == 1'b0)) & (1'b1 == ap_CS_fsm_state1))) begin
        y_out_write = 1'b1;
    end else begin
        y_out_write = 1'b0;
    end
end

always @ (*) begin
    case (ap_CS_fsm)
        ap_ST_fsm_state1 : begin
            if ((~((ap_done_reg == 1'b1) | (ap_start == 1'b0) | (update_out_full_n == 1'b0) | (display_xsize_out_full_n == 1'b0) | (y_out_full_n == 1'b0) | (width_out_full_n == 1'b0)) & (1'b1 == ap_CS_fsm_state1))) begin
                ap_NS_fsm = ap_ST_fsm_state2;
            end else begin
                ap_NS_fsm = ap_ST_fsm_state1;
            end
        end
        ap_ST_fsm_state2 : begin
            ap_NS_fsm = ap_ST_fsm_state3;
        end
        ap_ST_fsm_state3 : begin
            ap_NS_fsm = ap_ST_fsm_state4;
        end
        ap_ST_fsm_state4 : begin
            if (((m_axi_cp_ARREADY == 1'b1) & (1'b1 == ap_CS_fsm_state4))) begin
                ap_NS_fsm = ap_ST_fsm_state5;
            end else begin
                ap_NS_fsm = ap_ST_fsm_state4;
            end
        end
        ap_ST_fsm_state5 : begin
            ap_NS_fsm = ap_ST_fsm_state6;
        end
        ap_ST_fsm_state6 : begin
            ap_NS_fsm = ap_ST_fsm_state7;
        end
        ap_ST_fsm_state7 : begin
            ap_NS_fsm = ap_ST_fsm_state8;
        end
        ap_ST_fsm_state8 : begin
            ap_NS_fsm = ap_ST_fsm_state9;
        end
        ap_ST_fsm_state9 : begin
            ap_NS_fsm = ap_ST_fsm_state10;
        end
        ap_ST_fsm_state10 : begin
            ap_NS_fsm = ap_ST_fsm_pp0_stage0;
        end
        ap_ST_fsm_pp0_stage0 : begin
            if ((~((icmp_ln878_fu_239_p2 == 1'd1) & (ap_enable_reg_pp0_iter0 == 1'b1) & (1'b0 == ap_block_pp0_stage0_subdone) & (ap_enable_reg_pp0_iter1 == 1'b0)) & ~((ap_enable_reg_pp0_iter2 == 1'b1) & (1'b0 == ap_block_pp0_stage0_subdone) & (ap_enable_reg_pp0_iter1 == 1'b0)))) begin
                ap_NS_fsm = ap_ST_fsm_pp0_stage0;
            end else if ((((ap_enable_reg_pp0_iter2 == 1'b1) & (1'b0 == ap_block_pp0_stage0_subdone) & (ap_enable_reg_pp0_iter1 == 1'b0)) | ((icmp_ln878_fu_239_p2 == 1'd1) & (ap_enable_reg_pp0_iter0 == 1'b1) & (1'b0 == ap_block_pp0_stage0_subdone) & (ap_enable_reg_pp0_iter1 == 1'b0)))) begin
                ap_NS_fsm = ap_ST_fsm_state14;
            end else begin
                ap_NS_fsm = ap_ST_fsm_pp0_stage0;
            end
        end
        ap_ST_fsm_state14 : begin
            ap_NS_fsm = ap_ST_fsm_state1;
        end
        default : begin
            ap_NS_fsm = 'bx;
        end
    endcase
end

assign add_ln19_fu_233_p2 = (ap_phi_mux_x_phi_fu_178_p4 + 32'd1);

assign add_ln324_fu_207_p2 = (shl_ln324_1_fu_200_p3 + copy);

assign ap_CS_fsm_pp0_stage0 = ap_CS_fsm[32'd10];

assign ap_CS_fsm_state1 = ap_CS_fsm[32'd0];

assign ap_CS_fsm_state10 = ap_CS_fsm[32'd9];

assign ap_CS_fsm_state14 = ap_CS_fsm[32'd11];

assign ap_CS_fsm_state2 = ap_CS_fsm[32'd1];

assign ap_CS_fsm_state3 = ap_CS_fsm[32'd2];

assign ap_CS_fsm_state4 = ap_CS_fsm[32'd3];

assign ap_block_pp0_stage0 = ~(1'b1 == 1'b1);

always @ (*) begin
    ap_block_pp0_stage0_11001 = ((m_axi_cp_RVALID == 1'b0) & (icmp_ln878_reg_281 == 1'd0) & (ap_enable_reg_pp0_iter1 == 1'b1));
end

always @ (*) begin
    ap_block_pp0_stage0_subdone = ((m_axi_cp_RVALID == 1'b0) & (icmp_ln878_reg_281 == 1'd0) & (ap_enable_reg_pp0_iter1 == 1'b1));
end

always @ (*) begin
    ap_block_state1 = ((ap_done_reg == 1'b1) | (ap_start == 1'b0) | (update_out_full_n == 1'b0) | (display_xsize_out_full_n == 1'b0) | (y_out_full_n == 1'b0) | (width_out_full_n == 1'b0));
end

assign ap_block_state11_pp0_stage0_iter0 = ~(1'b1 == 1'b1);

always @ (*) begin
    ap_block_state12_pp0_stage0_iter1 = ((m_axi_cp_RVALID == 1'b0) & (icmp_ln878_reg_281 == 1'd0));
end

assign ap_block_state13_pp0_stage0_iter2 = ~(1'b1 == 1'b1);

assign ap_enable_pp0 = (ap_idle_pp0 ^ 1'b1);

assign display_xsize_out_din = display_xsize;

assign grp_fu_194_p0 = grp_fu_194_p00;

assign grp_fu_194_p00 = y;

assign grp_fu_194_p1 = grp_fu_194_p10;

assign grp_fu_194_p10 = display_xsize;

assign icmp_ln878_fu_239_p2 = ((ap_phi_mux_x_phi_fu_178_p4 == width) ? 1'b1 : 1'b0);

assign m_axi_cp_ARADDR = cp_addr_reg_270;

assign m_axi_cp_ARBURST = 2'd0;

assign m_axi_cp_ARCACHE = 4'd0;

assign m_axi_cp_ARID = 1'd0;

assign m_axi_cp_ARLEN = width;

assign m_axi_cp_ARLOCK = 2'd0;

assign m_axi_cp_ARPROT = 3'd0;

assign m_axi_cp_ARQOS = 4'd0;

assign m_axi_cp_ARREGION = 4'd0;

assign m_axi_cp_ARSIZE = 3'd0;

assign m_axi_cp_ARUSER = 1'd0;

assign m_axi_cp_AWADDR = 64'd0;

assign m_axi_cp_AWBURST = 2'd0;

assign m_axi_cp_AWCACHE = 4'd0;

assign m_axi_cp_AWID = 1'd0;

assign m_axi_cp_AWLEN = 32'd0;

assign m_axi_cp_AWLOCK = 2'd0;

assign m_axi_cp_AWPROT = 3'd0;

assign m_axi_cp_AWQOS = 4'd0;

assign m_axi_cp_AWREGION = 4'd0;

assign m_axi_cp_AWSIZE = 3'd0;

assign m_axi_cp_AWUSER = 1'd0;

assign m_axi_cp_AWVALID = 1'b0;

assign m_axi_cp_BREADY = 1'b0;

assign m_axi_cp_WDATA = 32'd0;

assign m_axi_cp_WID = 1'd0;

assign m_axi_cp_WLAST = 1'b0;

assign m_axi_cp_WSTRB = 4'd0;

assign m_axi_cp_WUSER = 1'd0;

assign m_axi_cp_WVALID = 1'b0;

assign sext_ln324_fu_223_p1 = $signed(trunc_ln324_1_fu_213_p4);

assign shl_ln324_1_fu_200_p3 = {{mul_i_i58_i_i_reg_265}, {2'd0}};

assign src_V1_address0 = zext_ln19_fu_244_p1;

assign src_V1_d0 = cp_addr_read_reg_285;

assign trunc_ln324_1_fu_213_p4 = {{add_ln324_fu_207_p2[63:2]}};

assign update_out_din = update;

assign width_out_din = width;

assign y_out_din = y;

assign zext_ln19_fu_244_p1 = x_reg_174_pp0_iter1_reg;

endmodule //framebuffer_copy_width_loop_proc5
