// ==============================================================
// RTL generated by Vitis HLS - High-Level Synthesis from C, C++ and OpenCL v2020.2 (64-bit)
// Version: 2020.2
// Copyright (C) Copyright 1986-2020 Xilinx, Inc. All Rights Reserved.
// 
// ===========================================================

`timescale 1 ns / 1 ps 

module mapchip_dataflow_in_loop_height_loop (
        ap_clk,
        ap_rst,
        y,
        srcin,
        m_axi_src_AWVALID,
        m_axi_src_AWREADY,
        m_axi_src_AWADDR,
        m_axi_src_AWID,
        m_axi_src_AWLEN,
        m_axi_src_AWSIZE,
        m_axi_src_AWBURST,
        m_axi_src_AWLOCK,
        m_axi_src_AWCACHE,
        m_axi_src_AWPROT,
        m_axi_src_AWQOS,
        m_axi_src_AWREGION,
        m_axi_src_AWUSER,
        m_axi_src_WVALID,
        m_axi_src_WREADY,
        m_axi_src_WDATA,
        m_axi_src_WSTRB,
        m_axi_src_WLAST,
        m_axi_src_WID,
        m_axi_src_WUSER,
        m_axi_src_ARVALID,
        m_axi_src_ARREADY,
        m_axi_src_ARADDR,
        m_axi_src_ARID,
        m_axi_src_ARLEN,
        m_axi_src_ARSIZE,
        m_axi_src_ARBURST,
        m_axi_src_ARLOCK,
        m_axi_src_ARCACHE,
        m_axi_src_ARPROT,
        m_axi_src_ARQOS,
        m_axi_src_ARREGION,
        m_axi_src_ARUSER,
        m_axi_src_RVALID,
        m_axi_src_RREADY,
        m_axi_src_RDATA,
        m_axi_src_RLAST,
        m_axi_src_RID,
        m_axi_src_RUSER,
        m_axi_src_RRESP,
        m_axi_src_BVALID,
        m_axi_src_BREADY,
        m_axi_src_BRESP,
        m_axi_src_BID,
        m_axi_src_BUSER,
        alpha,
        dstout,
        m_axi_dst_AWVALID,
        m_axi_dst_AWREADY,
        m_axi_dst_AWADDR,
        m_axi_dst_AWID,
        m_axi_dst_AWLEN,
        m_axi_dst_AWSIZE,
        m_axi_dst_AWBURST,
        m_axi_dst_AWLOCK,
        m_axi_dst_AWCACHE,
        m_axi_dst_AWPROT,
        m_axi_dst_AWQOS,
        m_axi_dst_AWREGION,
        m_axi_dst_AWUSER,
        m_axi_dst_WVALID,
        m_axi_dst_WREADY,
        m_axi_dst_WDATA,
        m_axi_dst_WSTRB,
        m_axi_dst_WLAST,
        m_axi_dst_WID,
        m_axi_dst_WUSER,
        m_axi_dst_ARVALID,
        m_axi_dst_ARREADY,
        m_axi_dst_ARADDR,
        m_axi_dst_ARID,
        m_axi_dst_ARLEN,
        m_axi_dst_ARSIZE,
        m_axi_dst_ARBURST,
        m_axi_dst_ARLOCK,
        m_axi_dst_ARCACHE,
        m_axi_dst_ARPROT,
        m_axi_dst_ARQOS,
        m_axi_dst_ARREGION,
        m_axi_dst_ARUSER,
        m_axi_dst_RVALID,
        m_axi_dst_RREADY,
        m_axi_dst_RDATA,
        m_axi_dst_RLAST,
        m_axi_dst_RID,
        m_axi_dst_RUSER,
        m_axi_dst_RRESP,
        m_axi_dst_BVALID,
        m_axi_dst_BREADY,
        m_axi_dst_BRESP,
        m_axi_dst_BID,
        m_axi_dst_BUSER,
        y_ap_vld,
        srcin_ap_vld,
        alpha_ap_vld,
        dstout_ap_vld,
        ap_start,
        ap_done,
        ap_ready,
        ap_idle,
        ap_continue
);


input   ap_clk;
input   ap_rst;
input  [6:0] y;
input  [63:0] srcin;
output   m_axi_src_AWVALID;
input   m_axi_src_AWREADY;
output  [63:0] m_axi_src_AWADDR;
output  [0:0] m_axi_src_AWID;
output  [31:0] m_axi_src_AWLEN;
output  [2:0] m_axi_src_AWSIZE;
output  [1:0] m_axi_src_AWBURST;
output  [1:0] m_axi_src_AWLOCK;
output  [3:0] m_axi_src_AWCACHE;
output  [2:0] m_axi_src_AWPROT;
output  [3:0] m_axi_src_AWQOS;
output  [3:0] m_axi_src_AWREGION;
output  [0:0] m_axi_src_AWUSER;
output   m_axi_src_WVALID;
input   m_axi_src_WREADY;
output  [31:0] m_axi_src_WDATA;
output  [3:0] m_axi_src_WSTRB;
output   m_axi_src_WLAST;
output  [0:0] m_axi_src_WID;
output  [0:0] m_axi_src_WUSER;
output   m_axi_src_ARVALID;
input   m_axi_src_ARREADY;
output  [63:0] m_axi_src_ARADDR;
output  [0:0] m_axi_src_ARID;
output  [31:0] m_axi_src_ARLEN;
output  [2:0] m_axi_src_ARSIZE;
output  [1:0] m_axi_src_ARBURST;
output  [1:0] m_axi_src_ARLOCK;
output  [3:0] m_axi_src_ARCACHE;
output  [2:0] m_axi_src_ARPROT;
output  [3:0] m_axi_src_ARQOS;
output  [3:0] m_axi_src_ARREGION;
output  [0:0] m_axi_src_ARUSER;
input   m_axi_src_RVALID;
output   m_axi_src_RREADY;
input  [31:0] m_axi_src_RDATA;
input   m_axi_src_RLAST;
input  [0:0] m_axi_src_RID;
input  [0:0] m_axi_src_RUSER;
input  [1:0] m_axi_src_RRESP;
input   m_axi_src_BVALID;
output   m_axi_src_BREADY;
input  [1:0] m_axi_src_BRESP;
input  [0:0] m_axi_src_BID;
input  [0:0] m_axi_src_BUSER;
input  [7:0] alpha;
input  [63:0] dstout;
output   m_axi_dst_AWVALID;
input   m_axi_dst_AWREADY;
output  [63:0] m_axi_dst_AWADDR;
output  [0:0] m_axi_dst_AWID;
output  [31:0] m_axi_dst_AWLEN;
output  [2:0] m_axi_dst_AWSIZE;
output  [1:0] m_axi_dst_AWBURST;
output  [1:0] m_axi_dst_AWLOCK;
output  [3:0] m_axi_dst_AWCACHE;
output  [2:0] m_axi_dst_AWPROT;
output  [3:0] m_axi_dst_AWQOS;
output  [3:0] m_axi_dst_AWREGION;
output  [0:0] m_axi_dst_AWUSER;
output   m_axi_dst_WVALID;
input   m_axi_dst_WREADY;
output  [31:0] m_axi_dst_WDATA;
output  [3:0] m_axi_dst_WSTRB;
output   m_axi_dst_WLAST;
output  [0:0] m_axi_dst_WID;
output  [0:0] m_axi_dst_WUSER;
output   m_axi_dst_ARVALID;
input   m_axi_dst_ARREADY;
output  [63:0] m_axi_dst_ARADDR;
output  [0:0] m_axi_dst_ARID;
output  [31:0] m_axi_dst_ARLEN;
output  [2:0] m_axi_dst_ARSIZE;
output  [1:0] m_axi_dst_ARBURST;
output  [1:0] m_axi_dst_ARLOCK;
output  [3:0] m_axi_dst_ARCACHE;
output  [2:0] m_axi_dst_ARPROT;
output  [3:0] m_axi_dst_ARQOS;
output  [3:0] m_axi_dst_ARREGION;
output  [0:0] m_axi_dst_ARUSER;
input   m_axi_dst_RVALID;
output   m_axi_dst_RREADY;
input  [31:0] m_axi_dst_RDATA;
input   m_axi_dst_RLAST;
input  [0:0] m_axi_dst_RID;
input  [0:0] m_axi_dst_RUSER;
input  [1:0] m_axi_dst_RRESP;
input   m_axi_dst_BVALID;
output   m_axi_dst_BREADY;
input  [1:0] m_axi_dst_BRESP;
input  [0:0] m_axi_dst_BID;
input  [0:0] m_axi_dst_BUSER;
input   y_ap_vld;
input   srcin_ap_vld;
input   alpha_ap_vld;
input   dstout_ap_vld;
input   ap_start;
output   ap_done;
output   ap_ready;
output   ap_idle;
input   ap_continue;

wire   [23:0] src_V_i_q0;
wire   [23:0] src_V_t_q0;
wire    src_loop_proc5_U0_ap_start;
wire    src_loop_proc5_U0_ap_done;
wire    src_loop_proc5_U0_ap_continue;
wire    src_loop_proc5_U0_ap_idle;
wire    src_loop_proc5_U0_ap_ready;
wire    src_loop_proc5_U0_m_axi_src_AWVALID;
wire   [63:0] src_loop_proc5_U0_m_axi_src_AWADDR;
wire   [0:0] src_loop_proc5_U0_m_axi_src_AWID;
wire   [31:0] src_loop_proc5_U0_m_axi_src_AWLEN;
wire   [2:0] src_loop_proc5_U0_m_axi_src_AWSIZE;
wire   [1:0] src_loop_proc5_U0_m_axi_src_AWBURST;
wire   [1:0] src_loop_proc5_U0_m_axi_src_AWLOCK;
wire   [3:0] src_loop_proc5_U0_m_axi_src_AWCACHE;
wire   [2:0] src_loop_proc5_U0_m_axi_src_AWPROT;
wire   [3:0] src_loop_proc5_U0_m_axi_src_AWQOS;
wire   [3:0] src_loop_proc5_U0_m_axi_src_AWREGION;
wire   [0:0] src_loop_proc5_U0_m_axi_src_AWUSER;
wire    src_loop_proc5_U0_m_axi_src_WVALID;
wire   [31:0] src_loop_proc5_U0_m_axi_src_WDATA;
wire   [3:0] src_loop_proc5_U0_m_axi_src_WSTRB;
wire    src_loop_proc5_U0_m_axi_src_WLAST;
wire   [0:0] src_loop_proc5_U0_m_axi_src_WID;
wire   [0:0] src_loop_proc5_U0_m_axi_src_WUSER;
wire    src_loop_proc5_U0_m_axi_src_ARVALID;
wire   [63:0] src_loop_proc5_U0_m_axi_src_ARADDR;
wire   [0:0] src_loop_proc5_U0_m_axi_src_ARID;
wire   [31:0] src_loop_proc5_U0_m_axi_src_ARLEN;
wire   [2:0] src_loop_proc5_U0_m_axi_src_ARSIZE;
wire   [1:0] src_loop_proc5_U0_m_axi_src_ARBURST;
wire   [1:0] src_loop_proc5_U0_m_axi_src_ARLOCK;
wire   [3:0] src_loop_proc5_U0_m_axi_src_ARCACHE;
wire   [2:0] src_loop_proc5_U0_m_axi_src_ARPROT;
wire   [3:0] src_loop_proc5_U0_m_axi_src_ARQOS;
wire   [3:0] src_loop_proc5_U0_m_axi_src_ARREGION;
wire   [0:0] src_loop_proc5_U0_m_axi_src_ARUSER;
wire    src_loop_proc5_U0_m_axi_src_RREADY;
wire    src_loop_proc5_U0_m_axi_src_BREADY;
wire   [5:0] src_loop_proc5_U0_src_V_address0;
wire    src_loop_proc5_U0_src_V_ce0;
wire    src_loop_proc5_U0_src_V_we0;
wire   [23:0] src_loop_proc5_U0_src_V_d0;
wire   [5:0] src_loop_proc5_U0_y_c_din;
wire    src_loop_proc5_U0_y_c_write;
wire   [7:0] src_loop_proc5_U0_alpha_c_din;
wire    src_loop_proc5_U0_alpha_c_write;
wire   [63:0] src_loop_proc5_U0_dstout_c_din;
wire    src_loop_proc5_U0_dstout_c_write;
wire    ap_channel_done_src_V;
wire    src_loop_proc5_U0_src_V_full_n;
wire    dstout_loop_proc_U0_ap_start;
wire    dstout_loop_proc_U0_ap_done;
wire    dstout_loop_proc_U0_ap_continue;
wire    dstout_loop_proc_U0_ap_idle;
wire    dstout_loop_proc_U0_ap_ready;
wire   [5:0] dstout_loop_proc_U0_src_V1_address0;
wire    dstout_loop_proc_U0_src_V1_ce0;
wire    dstout_loop_proc_U0_alpha_read;
wire    dstout_loop_proc_U0_y_read;
wire    dstout_loop_proc_U0_dstout_read;
wire    dstout_loop_proc_U0_m_axi_dst_AWVALID;
wire   [63:0] dstout_loop_proc_U0_m_axi_dst_AWADDR;
wire   [0:0] dstout_loop_proc_U0_m_axi_dst_AWID;
wire   [31:0] dstout_loop_proc_U0_m_axi_dst_AWLEN;
wire   [2:0] dstout_loop_proc_U0_m_axi_dst_AWSIZE;
wire   [1:0] dstout_loop_proc_U0_m_axi_dst_AWBURST;
wire   [1:0] dstout_loop_proc_U0_m_axi_dst_AWLOCK;
wire   [3:0] dstout_loop_proc_U0_m_axi_dst_AWCACHE;
wire   [2:0] dstout_loop_proc_U0_m_axi_dst_AWPROT;
wire   [3:0] dstout_loop_proc_U0_m_axi_dst_AWQOS;
wire   [3:0] dstout_loop_proc_U0_m_axi_dst_AWREGION;
wire   [0:0] dstout_loop_proc_U0_m_axi_dst_AWUSER;
wire    dstout_loop_proc_U0_m_axi_dst_WVALID;
wire   [31:0] dstout_loop_proc_U0_m_axi_dst_WDATA;
wire   [3:0] dstout_loop_proc_U0_m_axi_dst_WSTRB;
wire    dstout_loop_proc_U0_m_axi_dst_WLAST;
wire   [0:0] dstout_loop_proc_U0_m_axi_dst_WID;
wire   [0:0] dstout_loop_proc_U0_m_axi_dst_WUSER;
wire    dstout_loop_proc_U0_m_axi_dst_ARVALID;
wire   [63:0] dstout_loop_proc_U0_m_axi_dst_ARADDR;
wire   [0:0] dstout_loop_proc_U0_m_axi_dst_ARID;
wire   [31:0] dstout_loop_proc_U0_m_axi_dst_ARLEN;
wire   [2:0] dstout_loop_proc_U0_m_axi_dst_ARSIZE;
wire   [1:0] dstout_loop_proc_U0_m_axi_dst_ARBURST;
wire   [1:0] dstout_loop_proc_U0_m_axi_dst_ARLOCK;
wire   [3:0] dstout_loop_proc_U0_m_axi_dst_ARCACHE;
wire   [2:0] dstout_loop_proc_U0_m_axi_dst_ARPROT;
wire   [3:0] dstout_loop_proc_U0_m_axi_dst_ARQOS;
wire   [3:0] dstout_loop_proc_U0_m_axi_dst_ARREGION;
wire   [0:0] dstout_loop_proc_U0_m_axi_dst_ARUSER;
wire    dstout_loop_proc_U0_m_axi_dst_RREADY;
wire    dstout_loop_proc_U0_m_axi_dst_BREADY;
wire    ap_sync_continue;
wire    src_V_i_full_n;
wire    src_V_t_empty_n;
wire    y_c_full_n;
wire   [5:0] y_c_dout;
wire    y_c_empty_n;
wire    alpha_c_full_n;
wire   [7:0] alpha_c_dout;
wire    alpha_c_empty_n;
wire    dstout_c_full_n;
wire   [63:0] dstout_c_dout;
wire    dstout_c_empty_n;
wire    ap_sync_done;
wire    ap_sync_ready;
wire    src_loop_proc5_U0_start_full_n;
wire    src_loop_proc5_U0_start_write;
wire    dstout_loop_proc_U0_start_full_n;
wire    dstout_loop_proc_U0_start_write;

mapchip_dataflow_in_loop_height_loop_src_V #(
    .DataWidth( 24 ),
    .AddressRange( 64 ),
    .AddressWidth( 6 ))
src_V_U(
    .clk(ap_clk),
    .reset(ap_rst),
    .i_address0(src_loop_proc5_U0_src_V_address0),
    .i_ce0(src_loop_proc5_U0_src_V_ce0),
    .i_we0(src_loop_proc5_U0_src_V_we0),
    .i_d0(src_loop_proc5_U0_src_V_d0),
    .i_q0(src_V_i_q0),
    .t_address0(dstout_loop_proc_U0_src_V1_address0),
    .t_ce0(dstout_loop_proc_U0_src_V1_ce0),
    .t_we0(1'b0),
    .t_d0(24'd0),
    .t_q0(src_V_t_q0),
    .i_ce(1'b1),
    .t_ce(1'b1),
    .i_full_n(src_V_i_full_n),
    .i_write(src_loop_proc5_U0_ap_done),
    .t_empty_n(src_V_t_empty_n),
    .t_read(dstout_loop_proc_U0_ap_ready)
);

mapchip_src_loop_proc5 src_loop_proc5_U0(
    .ap_clk(ap_clk),
    .ap_rst(ap_rst),
    .ap_start(src_loop_proc5_U0_ap_start),
    .ap_done(src_loop_proc5_U0_ap_done),
    .ap_continue(src_loop_proc5_U0_ap_continue),
    .ap_idle(src_loop_proc5_U0_ap_idle),
    .ap_ready(src_loop_proc5_U0_ap_ready),
    .y(y),
    .srcin(srcin),
    .m_axi_src_AWVALID(src_loop_proc5_U0_m_axi_src_AWVALID),
    .m_axi_src_AWREADY(1'b0),
    .m_axi_src_AWADDR(src_loop_proc5_U0_m_axi_src_AWADDR),
    .m_axi_src_AWID(src_loop_proc5_U0_m_axi_src_AWID),
    .m_axi_src_AWLEN(src_loop_proc5_U0_m_axi_src_AWLEN),
    .m_axi_src_AWSIZE(src_loop_proc5_U0_m_axi_src_AWSIZE),
    .m_axi_src_AWBURST(src_loop_proc5_U0_m_axi_src_AWBURST),
    .m_axi_src_AWLOCK(src_loop_proc5_U0_m_axi_src_AWLOCK),
    .m_axi_src_AWCACHE(src_loop_proc5_U0_m_axi_src_AWCACHE),
    .m_axi_src_AWPROT(src_loop_proc5_U0_m_axi_src_AWPROT),
    .m_axi_src_AWQOS(src_loop_proc5_U0_m_axi_src_AWQOS),
    .m_axi_src_AWREGION(src_loop_proc5_U0_m_axi_src_AWREGION),
    .m_axi_src_AWUSER(src_loop_proc5_U0_m_axi_src_AWUSER),
    .m_axi_src_WVALID(src_loop_proc5_U0_m_axi_src_WVALID),
    .m_axi_src_WREADY(1'b0),
    .m_axi_src_WDATA(src_loop_proc5_U0_m_axi_src_WDATA),
    .m_axi_src_WSTRB(src_loop_proc5_U0_m_axi_src_WSTRB),
    .m_axi_src_WLAST(src_loop_proc5_U0_m_axi_src_WLAST),
    .m_axi_src_WID(src_loop_proc5_U0_m_axi_src_WID),
    .m_axi_src_WUSER(src_loop_proc5_U0_m_axi_src_WUSER),
    .m_axi_src_ARVALID(src_loop_proc5_U0_m_axi_src_ARVALID),
    .m_axi_src_ARREADY(m_axi_src_ARREADY),
    .m_axi_src_ARADDR(src_loop_proc5_U0_m_axi_src_ARADDR),
    .m_axi_src_ARID(src_loop_proc5_U0_m_axi_src_ARID),
    .m_axi_src_ARLEN(src_loop_proc5_U0_m_axi_src_ARLEN),
    .m_axi_src_ARSIZE(src_loop_proc5_U0_m_axi_src_ARSIZE),
    .m_axi_src_ARBURST(src_loop_proc5_U0_m_axi_src_ARBURST),
    .m_axi_src_ARLOCK(src_loop_proc5_U0_m_axi_src_ARLOCK),
    .m_axi_src_ARCACHE(src_loop_proc5_U0_m_axi_src_ARCACHE),
    .m_axi_src_ARPROT(src_loop_proc5_U0_m_axi_src_ARPROT),
    .m_axi_src_ARQOS(src_loop_proc5_U0_m_axi_src_ARQOS),
    .m_axi_src_ARREGION(src_loop_proc5_U0_m_axi_src_ARREGION),
    .m_axi_src_ARUSER(src_loop_proc5_U0_m_axi_src_ARUSER),
    .m_axi_src_RVALID(m_axi_src_RVALID),
    .m_axi_src_RREADY(src_loop_proc5_U0_m_axi_src_RREADY),
    .m_axi_src_RDATA(m_axi_src_RDATA),
    .m_axi_src_RLAST(m_axi_src_RLAST),
    .m_axi_src_RID(m_axi_src_RID),
    .m_axi_src_RUSER(m_axi_src_RUSER),
    .m_axi_src_RRESP(m_axi_src_RRESP),
    .m_axi_src_BVALID(1'b0),
    .m_axi_src_BREADY(src_loop_proc5_U0_m_axi_src_BREADY),
    .m_axi_src_BRESP(2'd0),
    .m_axi_src_BID(1'd0),
    .m_axi_src_BUSER(1'd0),
    .src_V_address0(src_loop_proc5_U0_src_V_address0),
    .src_V_ce0(src_loop_proc5_U0_src_V_ce0),
    .src_V_we0(src_loop_proc5_U0_src_V_we0),
    .src_V_d0(src_loop_proc5_U0_src_V_d0),
    .alpha(alpha),
    .dstout(dstout),
    .y_c_din(src_loop_proc5_U0_y_c_din),
    .y_c_full_n(y_c_full_n),
    .y_c_write(src_loop_proc5_U0_y_c_write),
    .alpha_c_din(src_loop_proc5_U0_alpha_c_din),
    .alpha_c_full_n(alpha_c_full_n),
    .alpha_c_write(src_loop_proc5_U0_alpha_c_write),
    .dstout_c_din(src_loop_proc5_U0_dstout_c_din),
    .dstout_c_full_n(dstout_c_full_n),
    .dstout_c_write(src_loop_proc5_U0_dstout_c_write)
);

mapchip_dstout_loop_proc dstout_loop_proc_U0(
    .ap_clk(ap_clk),
    .ap_rst(ap_rst),
    .ap_start(dstout_loop_proc_U0_ap_start),
    .ap_done(dstout_loop_proc_U0_ap_done),
    .ap_continue(dstout_loop_proc_U0_ap_continue),
    .ap_idle(dstout_loop_proc_U0_ap_idle),
    .ap_ready(dstout_loop_proc_U0_ap_ready),
    .src_V1_address0(dstout_loop_proc_U0_src_V1_address0),
    .src_V1_ce0(dstout_loop_proc_U0_src_V1_ce0),
    .src_V1_q0(src_V_t_q0),
    .alpha_dout(alpha_c_dout),
    .alpha_empty_n(alpha_c_empty_n),
    .alpha_read(dstout_loop_proc_U0_alpha_read),
    .y_dout(y_c_dout),
    .y_empty_n(y_c_empty_n),
    .y_read(dstout_loop_proc_U0_y_read),
    .dstout_dout(dstout_c_dout),
    .dstout_empty_n(dstout_c_empty_n),
    .dstout_read(dstout_loop_proc_U0_dstout_read),
    .m_axi_dst_AWVALID(dstout_loop_proc_U0_m_axi_dst_AWVALID),
    .m_axi_dst_AWREADY(m_axi_dst_AWREADY),
    .m_axi_dst_AWADDR(dstout_loop_proc_U0_m_axi_dst_AWADDR),
    .m_axi_dst_AWID(dstout_loop_proc_U0_m_axi_dst_AWID),
    .m_axi_dst_AWLEN(dstout_loop_proc_U0_m_axi_dst_AWLEN),
    .m_axi_dst_AWSIZE(dstout_loop_proc_U0_m_axi_dst_AWSIZE),
    .m_axi_dst_AWBURST(dstout_loop_proc_U0_m_axi_dst_AWBURST),
    .m_axi_dst_AWLOCK(dstout_loop_proc_U0_m_axi_dst_AWLOCK),
    .m_axi_dst_AWCACHE(dstout_loop_proc_U0_m_axi_dst_AWCACHE),
    .m_axi_dst_AWPROT(dstout_loop_proc_U0_m_axi_dst_AWPROT),
    .m_axi_dst_AWQOS(dstout_loop_proc_U0_m_axi_dst_AWQOS),
    .m_axi_dst_AWREGION(dstout_loop_proc_U0_m_axi_dst_AWREGION),
    .m_axi_dst_AWUSER(dstout_loop_proc_U0_m_axi_dst_AWUSER),
    .m_axi_dst_WVALID(dstout_loop_proc_U0_m_axi_dst_WVALID),
    .m_axi_dst_WREADY(m_axi_dst_WREADY),
    .m_axi_dst_WDATA(dstout_loop_proc_U0_m_axi_dst_WDATA),
    .m_axi_dst_WSTRB(dstout_loop_proc_U0_m_axi_dst_WSTRB),
    .m_axi_dst_WLAST(dstout_loop_proc_U0_m_axi_dst_WLAST),
    .m_axi_dst_WID(dstout_loop_proc_U0_m_axi_dst_WID),
    .m_axi_dst_WUSER(dstout_loop_proc_U0_m_axi_dst_WUSER),
    .m_axi_dst_ARVALID(dstout_loop_proc_U0_m_axi_dst_ARVALID),
    .m_axi_dst_ARREADY(1'b0),
    .m_axi_dst_ARADDR(dstout_loop_proc_U0_m_axi_dst_ARADDR),
    .m_axi_dst_ARID(dstout_loop_proc_U0_m_axi_dst_ARID),
    .m_axi_dst_ARLEN(dstout_loop_proc_U0_m_axi_dst_ARLEN),
    .m_axi_dst_ARSIZE(dstout_loop_proc_U0_m_axi_dst_ARSIZE),
    .m_axi_dst_ARBURST(dstout_loop_proc_U0_m_axi_dst_ARBURST),
    .m_axi_dst_ARLOCK(dstout_loop_proc_U0_m_axi_dst_ARLOCK),
    .m_axi_dst_ARCACHE(dstout_loop_proc_U0_m_axi_dst_ARCACHE),
    .m_axi_dst_ARPROT(dstout_loop_proc_U0_m_axi_dst_ARPROT),
    .m_axi_dst_ARQOS(dstout_loop_proc_U0_m_axi_dst_ARQOS),
    .m_axi_dst_ARREGION(dstout_loop_proc_U0_m_axi_dst_ARREGION),
    .m_axi_dst_ARUSER(dstout_loop_proc_U0_m_axi_dst_ARUSER),
    .m_axi_dst_RVALID(1'b0),
    .m_axi_dst_RREADY(dstout_loop_proc_U0_m_axi_dst_RREADY),
    .m_axi_dst_RDATA(32'd0),
    .m_axi_dst_RLAST(1'b0),
    .m_axi_dst_RID(1'd0),
    .m_axi_dst_RUSER(1'd0),
    .m_axi_dst_RRESP(2'd0),
    .m_axi_dst_BVALID(m_axi_dst_BVALID),
    .m_axi_dst_BREADY(dstout_loop_proc_U0_m_axi_dst_BREADY),
    .m_axi_dst_BRESP(m_axi_dst_BRESP),
    .m_axi_dst_BID(m_axi_dst_BID),
    .m_axi_dst_BUSER(m_axi_dst_BUSER)
);

mapchip_fifo_w6_d2_S y_c_U(
    .clk(ap_clk),
    .reset(ap_rst),
    .if_read_ce(1'b1),
    .if_write_ce(1'b1),
    .if_din(src_loop_proc5_U0_y_c_din),
    .if_full_n(y_c_full_n),
    .if_write(src_loop_proc5_U0_y_c_write),
    .if_dout(y_c_dout),
    .if_empty_n(y_c_empty_n),
    .if_read(dstout_loop_proc_U0_y_read)
);

mapchip_fifo_w8_d2_S alpha_c_U(
    .clk(ap_clk),
    .reset(ap_rst),
    .if_read_ce(1'b1),
    .if_write_ce(1'b1),
    .if_din(src_loop_proc5_U0_alpha_c_din),
    .if_full_n(alpha_c_full_n),
    .if_write(src_loop_proc5_U0_alpha_c_write),
    .if_dout(alpha_c_dout),
    .if_empty_n(alpha_c_empty_n),
    .if_read(dstout_loop_proc_U0_alpha_read)
);

mapchip_fifo_w64_d2_S dstout_c_U(
    .clk(ap_clk),
    .reset(ap_rst),
    .if_read_ce(1'b1),
    .if_write_ce(1'b1),
    .if_din(src_loop_proc5_U0_dstout_c_din),
    .if_full_n(dstout_c_full_n),
    .if_write(src_loop_proc5_U0_dstout_c_write),
    .if_dout(dstout_c_dout),
    .if_empty_n(dstout_c_empty_n),
    .if_read(dstout_loop_proc_U0_dstout_read)
);

assign ap_channel_done_src_V = src_loop_proc5_U0_ap_done;

assign ap_done = dstout_loop_proc_U0_ap_done;

assign ap_idle = (src_loop_proc5_U0_ap_idle & (src_V_t_empty_n ^ 1'b1) & dstout_loop_proc_U0_ap_idle);

assign ap_ready = src_loop_proc5_U0_ap_ready;

assign ap_sync_continue = ap_continue;

assign ap_sync_done = dstout_loop_proc_U0_ap_done;

assign ap_sync_ready = src_loop_proc5_U0_ap_ready;

assign dstout_loop_proc_U0_ap_continue = ap_continue;

assign dstout_loop_proc_U0_ap_start = src_V_t_empty_n;

assign dstout_loop_proc_U0_start_full_n = 1'b1;

assign dstout_loop_proc_U0_start_write = 1'b0;

assign m_axi_dst_ARADDR = 64'd0;

assign m_axi_dst_ARBURST = 2'd0;

assign m_axi_dst_ARCACHE = 4'd0;

assign m_axi_dst_ARID = 1'd0;

assign m_axi_dst_ARLEN = 32'd0;

assign m_axi_dst_ARLOCK = 2'd0;

assign m_axi_dst_ARPROT = 3'd0;

assign m_axi_dst_ARQOS = 4'd0;

assign m_axi_dst_ARREGION = 4'd0;

assign m_axi_dst_ARSIZE = 3'd0;

assign m_axi_dst_ARUSER = 1'd0;

assign m_axi_dst_ARVALID = 1'b0;

assign m_axi_dst_AWADDR = dstout_loop_proc_U0_m_axi_dst_AWADDR;

assign m_axi_dst_AWBURST = dstout_loop_proc_U0_m_axi_dst_AWBURST;

assign m_axi_dst_AWCACHE = dstout_loop_proc_U0_m_axi_dst_AWCACHE;

assign m_axi_dst_AWID = dstout_loop_proc_U0_m_axi_dst_AWID;

assign m_axi_dst_AWLEN = dstout_loop_proc_U0_m_axi_dst_AWLEN;

assign m_axi_dst_AWLOCK = dstout_loop_proc_U0_m_axi_dst_AWLOCK;

assign m_axi_dst_AWPROT = dstout_loop_proc_U0_m_axi_dst_AWPROT;

assign m_axi_dst_AWQOS = dstout_loop_proc_U0_m_axi_dst_AWQOS;

assign m_axi_dst_AWREGION = dstout_loop_proc_U0_m_axi_dst_AWREGION;

assign m_axi_dst_AWSIZE = dstout_loop_proc_U0_m_axi_dst_AWSIZE;

assign m_axi_dst_AWUSER = dstout_loop_proc_U0_m_axi_dst_AWUSER;

assign m_axi_dst_AWVALID = dstout_loop_proc_U0_m_axi_dst_AWVALID;

assign m_axi_dst_BREADY = dstout_loop_proc_U0_m_axi_dst_BREADY;

assign m_axi_dst_RREADY = 1'b0;

assign m_axi_dst_WDATA = dstout_loop_proc_U0_m_axi_dst_WDATA;

assign m_axi_dst_WID = dstout_loop_proc_U0_m_axi_dst_WID;

assign m_axi_dst_WLAST = dstout_loop_proc_U0_m_axi_dst_WLAST;

assign m_axi_dst_WSTRB = dstout_loop_proc_U0_m_axi_dst_WSTRB;

assign m_axi_dst_WUSER = dstout_loop_proc_U0_m_axi_dst_WUSER;

assign m_axi_dst_WVALID = dstout_loop_proc_U0_m_axi_dst_WVALID;

assign m_axi_src_ARADDR = src_loop_proc5_U0_m_axi_src_ARADDR;

assign m_axi_src_ARBURST = src_loop_proc5_U0_m_axi_src_ARBURST;

assign m_axi_src_ARCACHE = src_loop_proc5_U0_m_axi_src_ARCACHE;

assign m_axi_src_ARID = src_loop_proc5_U0_m_axi_src_ARID;

assign m_axi_src_ARLEN = src_loop_proc5_U0_m_axi_src_ARLEN;

assign m_axi_src_ARLOCK = src_loop_proc5_U0_m_axi_src_ARLOCK;

assign m_axi_src_ARPROT = src_loop_proc5_U0_m_axi_src_ARPROT;

assign m_axi_src_ARQOS = src_loop_proc5_U0_m_axi_src_ARQOS;

assign m_axi_src_ARREGION = src_loop_proc5_U0_m_axi_src_ARREGION;

assign m_axi_src_ARSIZE = src_loop_proc5_U0_m_axi_src_ARSIZE;

assign m_axi_src_ARUSER = src_loop_proc5_U0_m_axi_src_ARUSER;

assign m_axi_src_ARVALID = src_loop_proc5_U0_m_axi_src_ARVALID;

assign m_axi_src_AWADDR = 64'd0;

assign m_axi_src_AWBURST = 2'd0;

assign m_axi_src_AWCACHE = 4'd0;

assign m_axi_src_AWID = 1'd0;

assign m_axi_src_AWLEN = 32'd0;

assign m_axi_src_AWLOCK = 2'd0;

assign m_axi_src_AWPROT = 3'd0;

assign m_axi_src_AWQOS = 4'd0;

assign m_axi_src_AWREGION = 4'd0;

assign m_axi_src_AWSIZE = 3'd0;

assign m_axi_src_AWUSER = 1'd0;

assign m_axi_src_AWVALID = 1'b0;

assign m_axi_src_BREADY = 1'b0;

assign m_axi_src_RREADY = src_loop_proc5_U0_m_axi_src_RREADY;

assign m_axi_src_WDATA = 32'd0;

assign m_axi_src_WID = 1'd0;

assign m_axi_src_WLAST = 1'b0;

assign m_axi_src_WSTRB = 4'd0;

assign m_axi_src_WUSER = 1'd0;

assign m_axi_src_WVALID = 1'b0;

assign src_loop_proc5_U0_ap_continue = src_V_i_full_n;

assign src_loop_proc5_U0_ap_start = ap_start;

assign src_loop_proc5_U0_src_V_full_n = src_V_i_full_n;

assign src_loop_proc5_U0_start_full_n = 1'b1;

assign src_loop_proc5_U0_start_write = 1'b0;

endmodule //mapchip_dataflow_in_loop_height_loop
