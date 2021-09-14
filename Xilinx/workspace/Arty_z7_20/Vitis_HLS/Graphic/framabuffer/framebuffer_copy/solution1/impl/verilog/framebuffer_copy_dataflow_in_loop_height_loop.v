// ==============================================================
// RTL generated by Vitis HLS - High-Level Synthesis from C, C++ and OpenCL v2020.2 (64-bit)
// Version: 2020.2
// Copyright (C) Copyright 1986-2020 Xilinx, Inc. All Rights Reserved.
// 
// ===========================================================

`timescale 1 ns / 1 ps 

module framebuffer_copy_dataflow_in_loop_height_loop (
        ap_clk,
        ap_rst,
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
        update,
        m_axi_up_AWVALID,
        m_axi_up_AWREADY,
        m_axi_up_AWADDR,
        m_axi_up_AWID,
        m_axi_up_AWLEN,
        m_axi_up_AWSIZE,
        m_axi_up_AWBURST,
        m_axi_up_AWLOCK,
        m_axi_up_AWCACHE,
        m_axi_up_AWPROT,
        m_axi_up_AWQOS,
        m_axi_up_AWREGION,
        m_axi_up_AWUSER,
        m_axi_up_WVALID,
        m_axi_up_WREADY,
        m_axi_up_WDATA,
        m_axi_up_WSTRB,
        m_axi_up_WLAST,
        m_axi_up_WID,
        m_axi_up_WUSER,
        m_axi_up_ARVALID,
        m_axi_up_ARREADY,
        m_axi_up_ARADDR,
        m_axi_up_ARID,
        m_axi_up_ARLEN,
        m_axi_up_ARSIZE,
        m_axi_up_ARBURST,
        m_axi_up_ARLOCK,
        m_axi_up_ARCACHE,
        m_axi_up_ARPROT,
        m_axi_up_ARQOS,
        m_axi_up_ARREGION,
        m_axi_up_ARUSER,
        m_axi_up_RVALID,
        m_axi_up_RREADY,
        m_axi_up_RDATA,
        m_axi_up_RLAST,
        m_axi_up_RID,
        m_axi_up_RUSER,
        m_axi_up_RRESP,
        m_axi_up_BVALID,
        m_axi_up_BREADY,
        m_axi_up_BRESP,
        m_axi_up_BID,
        m_axi_up_BUSER,
        width_ap_vld,
        y_ap_vld,
        display_xsize_ap_vld,
        copy_ap_vld,
        update_ap_vld,
        ap_start,
        ap_done,
        ap_ready,
        ap_idle,
        ap_continue
);


input   ap_clk;
input   ap_rst;
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
input  [63:0] update;
output   m_axi_up_AWVALID;
input   m_axi_up_AWREADY;
output  [63:0] m_axi_up_AWADDR;
output  [0:0] m_axi_up_AWID;
output  [31:0] m_axi_up_AWLEN;
output  [2:0] m_axi_up_AWSIZE;
output  [1:0] m_axi_up_AWBURST;
output  [1:0] m_axi_up_AWLOCK;
output  [3:0] m_axi_up_AWCACHE;
output  [2:0] m_axi_up_AWPROT;
output  [3:0] m_axi_up_AWQOS;
output  [3:0] m_axi_up_AWREGION;
output  [0:0] m_axi_up_AWUSER;
output   m_axi_up_WVALID;
input   m_axi_up_WREADY;
output  [31:0] m_axi_up_WDATA;
output  [3:0] m_axi_up_WSTRB;
output   m_axi_up_WLAST;
output  [0:0] m_axi_up_WID;
output  [0:0] m_axi_up_WUSER;
output   m_axi_up_ARVALID;
input   m_axi_up_ARREADY;
output  [63:0] m_axi_up_ARADDR;
output  [0:0] m_axi_up_ARID;
output  [31:0] m_axi_up_ARLEN;
output  [2:0] m_axi_up_ARSIZE;
output  [1:0] m_axi_up_ARBURST;
output  [1:0] m_axi_up_ARLOCK;
output  [3:0] m_axi_up_ARCACHE;
output  [2:0] m_axi_up_ARPROT;
output  [3:0] m_axi_up_ARQOS;
output  [3:0] m_axi_up_ARREGION;
output  [0:0] m_axi_up_ARUSER;
input   m_axi_up_RVALID;
output   m_axi_up_RREADY;
input  [31:0] m_axi_up_RDATA;
input   m_axi_up_RLAST;
input  [0:0] m_axi_up_RID;
input  [0:0] m_axi_up_RUSER;
input  [1:0] m_axi_up_RRESP;
input   m_axi_up_BVALID;
output   m_axi_up_BREADY;
input  [1:0] m_axi_up_BRESP;
input  [0:0] m_axi_up_BID;
input  [0:0] m_axi_up_BUSER;
input   width_ap_vld;
input   y_ap_vld;
input   display_xsize_ap_vld;
input   copy_ap_vld;
input   update_ap_vld;
input   ap_start;
output   ap_done;
output   ap_ready;
output   ap_idle;
input   ap_continue;

wire   [31:0] src_V_i_q0;
wire   [31:0] src_V_t_q0;
wire    width_loop_proc5_U0_ap_start;
wire    width_loop_proc5_U0_ap_done;
wire    width_loop_proc5_U0_ap_continue;
wire    width_loop_proc5_U0_ap_idle;
wire    width_loop_proc5_U0_ap_ready;
wire    width_loop_proc5_U0_m_axi_cp_AWVALID;
wire   [63:0] width_loop_proc5_U0_m_axi_cp_AWADDR;
wire   [0:0] width_loop_proc5_U0_m_axi_cp_AWID;
wire   [31:0] width_loop_proc5_U0_m_axi_cp_AWLEN;
wire   [2:0] width_loop_proc5_U0_m_axi_cp_AWSIZE;
wire   [1:0] width_loop_proc5_U0_m_axi_cp_AWBURST;
wire   [1:0] width_loop_proc5_U0_m_axi_cp_AWLOCK;
wire   [3:0] width_loop_proc5_U0_m_axi_cp_AWCACHE;
wire   [2:0] width_loop_proc5_U0_m_axi_cp_AWPROT;
wire   [3:0] width_loop_proc5_U0_m_axi_cp_AWQOS;
wire   [3:0] width_loop_proc5_U0_m_axi_cp_AWREGION;
wire   [0:0] width_loop_proc5_U0_m_axi_cp_AWUSER;
wire    width_loop_proc5_U0_m_axi_cp_WVALID;
wire   [31:0] width_loop_proc5_U0_m_axi_cp_WDATA;
wire   [3:0] width_loop_proc5_U0_m_axi_cp_WSTRB;
wire    width_loop_proc5_U0_m_axi_cp_WLAST;
wire   [0:0] width_loop_proc5_U0_m_axi_cp_WID;
wire   [0:0] width_loop_proc5_U0_m_axi_cp_WUSER;
wire    width_loop_proc5_U0_m_axi_cp_ARVALID;
wire   [63:0] width_loop_proc5_U0_m_axi_cp_ARADDR;
wire   [0:0] width_loop_proc5_U0_m_axi_cp_ARID;
wire   [31:0] width_loop_proc5_U0_m_axi_cp_ARLEN;
wire   [2:0] width_loop_proc5_U0_m_axi_cp_ARSIZE;
wire   [1:0] width_loop_proc5_U0_m_axi_cp_ARBURST;
wire   [1:0] width_loop_proc5_U0_m_axi_cp_ARLOCK;
wire   [3:0] width_loop_proc5_U0_m_axi_cp_ARCACHE;
wire   [2:0] width_loop_proc5_U0_m_axi_cp_ARPROT;
wire   [3:0] width_loop_proc5_U0_m_axi_cp_ARQOS;
wire   [3:0] width_loop_proc5_U0_m_axi_cp_ARREGION;
wire   [0:0] width_loop_proc5_U0_m_axi_cp_ARUSER;
wire    width_loop_proc5_U0_m_axi_cp_RREADY;
wire    width_loop_proc5_U0_m_axi_cp_BREADY;
wire   [9:0] width_loop_proc5_U0_src_V1_address0;
wire    width_loop_proc5_U0_src_V1_ce0;
wire    width_loop_proc5_U0_src_V1_we0;
wire   [31:0] width_loop_proc5_U0_src_V1_d0;
wire   [31:0] width_loop_proc5_U0_width_out_din;
wire    width_loop_proc5_U0_width_out_write;
wire   [31:0] width_loop_proc5_U0_y_out_din;
wire    width_loop_proc5_U0_y_out_write;
wire   [31:0] width_loop_proc5_U0_display_xsize_out_din;
wire    width_loop_proc5_U0_display_xsize_out_write;
wire   [63:0] width_loop_proc5_U0_update_out_din;
wire    width_loop_proc5_U0_update_out_write;
wire    ap_channel_done_src_V;
wire    width_loop_proc5_U0_src_V1_full_n;
wire    copy_loop_proc_U0_ap_start;
wire    copy_loop_proc_U0_ap_done;
wire    copy_loop_proc_U0_ap_continue;
wire    copy_loop_proc_U0_ap_idle;
wire    copy_loop_proc_U0_ap_ready;
wire    copy_loop_proc_U0_width_read;
wire    copy_loop_proc_U0_y_read;
wire    copy_loop_proc_U0_display_xsize_read;
wire   [9:0] copy_loop_proc_U0_src_V1_address0;
wire    copy_loop_proc_U0_src_V1_ce0;
wire    copy_loop_proc_U0_update_read;
wire    copy_loop_proc_U0_m_axi_up_AWVALID;
wire   [63:0] copy_loop_proc_U0_m_axi_up_AWADDR;
wire   [0:0] copy_loop_proc_U0_m_axi_up_AWID;
wire   [31:0] copy_loop_proc_U0_m_axi_up_AWLEN;
wire   [2:0] copy_loop_proc_U0_m_axi_up_AWSIZE;
wire   [1:0] copy_loop_proc_U0_m_axi_up_AWBURST;
wire   [1:0] copy_loop_proc_U0_m_axi_up_AWLOCK;
wire   [3:0] copy_loop_proc_U0_m_axi_up_AWCACHE;
wire   [2:0] copy_loop_proc_U0_m_axi_up_AWPROT;
wire   [3:0] copy_loop_proc_U0_m_axi_up_AWQOS;
wire   [3:0] copy_loop_proc_U0_m_axi_up_AWREGION;
wire   [0:0] copy_loop_proc_U0_m_axi_up_AWUSER;
wire    copy_loop_proc_U0_m_axi_up_WVALID;
wire   [31:0] copy_loop_proc_U0_m_axi_up_WDATA;
wire   [3:0] copy_loop_proc_U0_m_axi_up_WSTRB;
wire    copy_loop_proc_U0_m_axi_up_WLAST;
wire   [0:0] copy_loop_proc_U0_m_axi_up_WID;
wire   [0:0] copy_loop_proc_U0_m_axi_up_WUSER;
wire    copy_loop_proc_U0_m_axi_up_ARVALID;
wire   [63:0] copy_loop_proc_U0_m_axi_up_ARADDR;
wire   [0:0] copy_loop_proc_U0_m_axi_up_ARID;
wire   [31:0] copy_loop_proc_U0_m_axi_up_ARLEN;
wire   [2:0] copy_loop_proc_U0_m_axi_up_ARSIZE;
wire   [1:0] copy_loop_proc_U0_m_axi_up_ARBURST;
wire   [1:0] copy_loop_proc_U0_m_axi_up_ARLOCK;
wire   [3:0] copy_loop_proc_U0_m_axi_up_ARCACHE;
wire   [2:0] copy_loop_proc_U0_m_axi_up_ARPROT;
wire   [3:0] copy_loop_proc_U0_m_axi_up_ARQOS;
wire   [3:0] copy_loop_proc_U0_m_axi_up_ARREGION;
wire   [0:0] copy_loop_proc_U0_m_axi_up_ARUSER;
wire    copy_loop_proc_U0_m_axi_up_RREADY;
wire    copy_loop_proc_U0_m_axi_up_BREADY;
wire    ap_sync_continue;
wire    src_V_i_full_n;
wire    src_V_t_empty_n;
wire    width_c_full_n;
wire   [31:0] width_c_dout;
wire    width_c_empty_n;
wire    y_c_full_n;
wire   [31:0] y_c_dout;
wire    y_c_empty_n;
wire    display_xsize_c_full_n;
wire   [31:0] display_xsize_c_dout;
wire    display_xsize_c_empty_n;
wire    update_c_full_n;
wire   [63:0] update_c_dout;
wire    update_c_empty_n;
wire    ap_sync_done;
wire    ap_sync_ready;
wire    width_loop_proc5_U0_start_full_n;
wire    width_loop_proc5_U0_start_write;
wire    copy_loop_proc_U0_start_full_n;
wire    copy_loop_proc_U0_start_write;

framebuffer_copy_dataflow_in_loop_height_loop_src_V #(
    .DataWidth( 32 ),
    .AddressRange( 640 ),
    .AddressWidth( 10 ))
src_V_U(
    .clk(ap_clk),
    .reset(ap_rst),
    .i_address0(width_loop_proc5_U0_src_V1_address0),
    .i_ce0(width_loop_proc5_U0_src_V1_ce0),
    .i_we0(width_loop_proc5_U0_src_V1_we0),
    .i_d0(width_loop_proc5_U0_src_V1_d0),
    .i_q0(src_V_i_q0),
    .t_address0(copy_loop_proc_U0_src_V1_address0),
    .t_ce0(copy_loop_proc_U0_src_V1_ce0),
    .t_we0(1'b0),
    .t_d0(32'd0),
    .t_q0(src_V_t_q0),
    .i_ce(1'b1),
    .t_ce(1'b1),
    .i_full_n(src_V_i_full_n),
    .i_write(width_loop_proc5_U0_ap_done),
    .t_empty_n(src_V_t_empty_n),
    .t_read(copy_loop_proc_U0_ap_ready)
);

framebuffer_copy_width_loop_proc5 width_loop_proc5_U0(
    .ap_clk(ap_clk),
    .ap_rst(ap_rst),
    .ap_start(width_loop_proc5_U0_ap_start),
    .ap_done(width_loop_proc5_U0_ap_done),
    .ap_continue(width_loop_proc5_U0_ap_continue),
    .ap_idle(width_loop_proc5_U0_ap_idle),
    .ap_ready(width_loop_proc5_U0_ap_ready),
    .width(width),
    .y(y),
    .display_xsize(display_xsize),
    .copy(copy),
    .m_axi_cp_AWVALID(width_loop_proc5_U0_m_axi_cp_AWVALID),
    .m_axi_cp_AWREADY(1'b0),
    .m_axi_cp_AWADDR(width_loop_proc5_U0_m_axi_cp_AWADDR),
    .m_axi_cp_AWID(width_loop_proc5_U0_m_axi_cp_AWID),
    .m_axi_cp_AWLEN(width_loop_proc5_U0_m_axi_cp_AWLEN),
    .m_axi_cp_AWSIZE(width_loop_proc5_U0_m_axi_cp_AWSIZE),
    .m_axi_cp_AWBURST(width_loop_proc5_U0_m_axi_cp_AWBURST),
    .m_axi_cp_AWLOCK(width_loop_proc5_U0_m_axi_cp_AWLOCK),
    .m_axi_cp_AWCACHE(width_loop_proc5_U0_m_axi_cp_AWCACHE),
    .m_axi_cp_AWPROT(width_loop_proc5_U0_m_axi_cp_AWPROT),
    .m_axi_cp_AWQOS(width_loop_proc5_U0_m_axi_cp_AWQOS),
    .m_axi_cp_AWREGION(width_loop_proc5_U0_m_axi_cp_AWREGION),
    .m_axi_cp_AWUSER(width_loop_proc5_U0_m_axi_cp_AWUSER),
    .m_axi_cp_WVALID(width_loop_proc5_U0_m_axi_cp_WVALID),
    .m_axi_cp_WREADY(1'b0),
    .m_axi_cp_WDATA(width_loop_proc5_U0_m_axi_cp_WDATA),
    .m_axi_cp_WSTRB(width_loop_proc5_U0_m_axi_cp_WSTRB),
    .m_axi_cp_WLAST(width_loop_proc5_U0_m_axi_cp_WLAST),
    .m_axi_cp_WID(width_loop_proc5_U0_m_axi_cp_WID),
    .m_axi_cp_WUSER(width_loop_proc5_U0_m_axi_cp_WUSER),
    .m_axi_cp_ARVALID(width_loop_proc5_U0_m_axi_cp_ARVALID),
    .m_axi_cp_ARREADY(m_axi_cp_ARREADY),
    .m_axi_cp_ARADDR(width_loop_proc5_U0_m_axi_cp_ARADDR),
    .m_axi_cp_ARID(width_loop_proc5_U0_m_axi_cp_ARID),
    .m_axi_cp_ARLEN(width_loop_proc5_U0_m_axi_cp_ARLEN),
    .m_axi_cp_ARSIZE(width_loop_proc5_U0_m_axi_cp_ARSIZE),
    .m_axi_cp_ARBURST(width_loop_proc5_U0_m_axi_cp_ARBURST),
    .m_axi_cp_ARLOCK(width_loop_proc5_U0_m_axi_cp_ARLOCK),
    .m_axi_cp_ARCACHE(width_loop_proc5_U0_m_axi_cp_ARCACHE),
    .m_axi_cp_ARPROT(width_loop_proc5_U0_m_axi_cp_ARPROT),
    .m_axi_cp_ARQOS(width_loop_proc5_U0_m_axi_cp_ARQOS),
    .m_axi_cp_ARREGION(width_loop_proc5_U0_m_axi_cp_ARREGION),
    .m_axi_cp_ARUSER(width_loop_proc5_U0_m_axi_cp_ARUSER),
    .m_axi_cp_RVALID(m_axi_cp_RVALID),
    .m_axi_cp_RREADY(width_loop_proc5_U0_m_axi_cp_RREADY),
    .m_axi_cp_RDATA(m_axi_cp_RDATA),
    .m_axi_cp_RLAST(m_axi_cp_RLAST),
    .m_axi_cp_RID(m_axi_cp_RID),
    .m_axi_cp_RUSER(m_axi_cp_RUSER),
    .m_axi_cp_RRESP(m_axi_cp_RRESP),
    .m_axi_cp_BVALID(1'b0),
    .m_axi_cp_BREADY(width_loop_proc5_U0_m_axi_cp_BREADY),
    .m_axi_cp_BRESP(2'd0),
    .m_axi_cp_BID(1'd0),
    .m_axi_cp_BUSER(1'd0),
    .src_V1_address0(width_loop_proc5_U0_src_V1_address0),
    .src_V1_ce0(width_loop_proc5_U0_src_V1_ce0),
    .src_V1_we0(width_loop_proc5_U0_src_V1_we0),
    .src_V1_d0(width_loop_proc5_U0_src_V1_d0),
    .update(update),
    .width_out_din(width_loop_proc5_U0_width_out_din),
    .width_out_full_n(width_c_full_n),
    .width_out_write(width_loop_proc5_U0_width_out_write),
    .y_out_din(width_loop_proc5_U0_y_out_din),
    .y_out_full_n(y_c_full_n),
    .y_out_write(width_loop_proc5_U0_y_out_write),
    .display_xsize_out_din(width_loop_proc5_U0_display_xsize_out_din),
    .display_xsize_out_full_n(display_xsize_c_full_n),
    .display_xsize_out_write(width_loop_proc5_U0_display_xsize_out_write),
    .update_out_din(width_loop_proc5_U0_update_out_din),
    .update_out_full_n(update_c_full_n),
    .update_out_write(width_loop_proc5_U0_update_out_write)
);

framebuffer_copy_copy_loop_proc copy_loop_proc_U0(
    .ap_clk(ap_clk),
    .ap_rst(ap_rst),
    .ap_start(copy_loop_proc_U0_ap_start),
    .ap_done(copy_loop_proc_U0_ap_done),
    .ap_continue(copy_loop_proc_U0_ap_continue),
    .ap_idle(copy_loop_proc_U0_ap_idle),
    .ap_ready(copy_loop_proc_U0_ap_ready),
    .width_dout(width_c_dout),
    .width_empty_n(width_c_empty_n),
    .width_read(copy_loop_proc_U0_width_read),
    .y_dout(y_c_dout),
    .y_empty_n(y_c_empty_n),
    .y_read(copy_loop_proc_U0_y_read),
    .display_xsize_dout(display_xsize_c_dout),
    .display_xsize_empty_n(display_xsize_c_empty_n),
    .display_xsize_read(copy_loop_proc_U0_display_xsize_read),
    .src_V1_address0(copy_loop_proc_U0_src_V1_address0),
    .src_V1_ce0(copy_loop_proc_U0_src_V1_ce0),
    .src_V1_q0(src_V_t_q0),
    .update_dout(update_c_dout),
    .update_empty_n(update_c_empty_n),
    .update_read(copy_loop_proc_U0_update_read),
    .m_axi_up_AWVALID(copy_loop_proc_U0_m_axi_up_AWVALID),
    .m_axi_up_AWREADY(m_axi_up_AWREADY),
    .m_axi_up_AWADDR(copy_loop_proc_U0_m_axi_up_AWADDR),
    .m_axi_up_AWID(copy_loop_proc_U0_m_axi_up_AWID),
    .m_axi_up_AWLEN(copy_loop_proc_U0_m_axi_up_AWLEN),
    .m_axi_up_AWSIZE(copy_loop_proc_U0_m_axi_up_AWSIZE),
    .m_axi_up_AWBURST(copy_loop_proc_U0_m_axi_up_AWBURST),
    .m_axi_up_AWLOCK(copy_loop_proc_U0_m_axi_up_AWLOCK),
    .m_axi_up_AWCACHE(copy_loop_proc_U0_m_axi_up_AWCACHE),
    .m_axi_up_AWPROT(copy_loop_proc_U0_m_axi_up_AWPROT),
    .m_axi_up_AWQOS(copy_loop_proc_U0_m_axi_up_AWQOS),
    .m_axi_up_AWREGION(copy_loop_proc_U0_m_axi_up_AWREGION),
    .m_axi_up_AWUSER(copy_loop_proc_U0_m_axi_up_AWUSER),
    .m_axi_up_WVALID(copy_loop_proc_U0_m_axi_up_WVALID),
    .m_axi_up_WREADY(m_axi_up_WREADY),
    .m_axi_up_WDATA(copy_loop_proc_U0_m_axi_up_WDATA),
    .m_axi_up_WSTRB(copy_loop_proc_U0_m_axi_up_WSTRB),
    .m_axi_up_WLAST(copy_loop_proc_U0_m_axi_up_WLAST),
    .m_axi_up_WID(copy_loop_proc_U0_m_axi_up_WID),
    .m_axi_up_WUSER(copy_loop_proc_U0_m_axi_up_WUSER),
    .m_axi_up_ARVALID(copy_loop_proc_U0_m_axi_up_ARVALID),
    .m_axi_up_ARREADY(1'b0),
    .m_axi_up_ARADDR(copy_loop_proc_U0_m_axi_up_ARADDR),
    .m_axi_up_ARID(copy_loop_proc_U0_m_axi_up_ARID),
    .m_axi_up_ARLEN(copy_loop_proc_U0_m_axi_up_ARLEN),
    .m_axi_up_ARSIZE(copy_loop_proc_U0_m_axi_up_ARSIZE),
    .m_axi_up_ARBURST(copy_loop_proc_U0_m_axi_up_ARBURST),
    .m_axi_up_ARLOCK(copy_loop_proc_U0_m_axi_up_ARLOCK),
    .m_axi_up_ARCACHE(copy_loop_proc_U0_m_axi_up_ARCACHE),
    .m_axi_up_ARPROT(copy_loop_proc_U0_m_axi_up_ARPROT),
    .m_axi_up_ARQOS(copy_loop_proc_U0_m_axi_up_ARQOS),
    .m_axi_up_ARREGION(copy_loop_proc_U0_m_axi_up_ARREGION),
    .m_axi_up_ARUSER(copy_loop_proc_U0_m_axi_up_ARUSER),
    .m_axi_up_RVALID(1'b0),
    .m_axi_up_RREADY(copy_loop_proc_U0_m_axi_up_RREADY),
    .m_axi_up_RDATA(32'd0),
    .m_axi_up_RLAST(1'b0),
    .m_axi_up_RID(1'd0),
    .m_axi_up_RUSER(1'd0),
    .m_axi_up_RRESP(2'd0),
    .m_axi_up_BVALID(m_axi_up_BVALID),
    .m_axi_up_BREADY(copy_loop_proc_U0_m_axi_up_BREADY),
    .m_axi_up_BRESP(m_axi_up_BRESP),
    .m_axi_up_BID(m_axi_up_BID),
    .m_axi_up_BUSER(m_axi_up_BUSER)
);

framebuffer_copy_fifo_w32_d2_S width_c_U(
    .clk(ap_clk),
    .reset(ap_rst),
    .if_read_ce(1'b1),
    .if_write_ce(1'b1),
    .if_din(width_loop_proc5_U0_width_out_din),
    .if_full_n(width_c_full_n),
    .if_write(width_loop_proc5_U0_width_out_write),
    .if_dout(width_c_dout),
    .if_empty_n(width_c_empty_n),
    .if_read(copy_loop_proc_U0_width_read)
);

framebuffer_copy_fifo_w32_d2_S y_c_U(
    .clk(ap_clk),
    .reset(ap_rst),
    .if_read_ce(1'b1),
    .if_write_ce(1'b1),
    .if_din(width_loop_proc5_U0_y_out_din),
    .if_full_n(y_c_full_n),
    .if_write(width_loop_proc5_U0_y_out_write),
    .if_dout(y_c_dout),
    .if_empty_n(y_c_empty_n),
    .if_read(copy_loop_proc_U0_y_read)
);

framebuffer_copy_fifo_w32_d2_S display_xsize_c_U(
    .clk(ap_clk),
    .reset(ap_rst),
    .if_read_ce(1'b1),
    .if_write_ce(1'b1),
    .if_din(width_loop_proc5_U0_display_xsize_out_din),
    .if_full_n(display_xsize_c_full_n),
    .if_write(width_loop_proc5_U0_display_xsize_out_write),
    .if_dout(display_xsize_c_dout),
    .if_empty_n(display_xsize_c_empty_n),
    .if_read(copy_loop_proc_U0_display_xsize_read)
);

framebuffer_copy_fifo_w64_d2_S update_c_U(
    .clk(ap_clk),
    .reset(ap_rst),
    .if_read_ce(1'b1),
    .if_write_ce(1'b1),
    .if_din(width_loop_proc5_U0_update_out_din),
    .if_full_n(update_c_full_n),
    .if_write(width_loop_proc5_U0_update_out_write),
    .if_dout(update_c_dout),
    .if_empty_n(update_c_empty_n),
    .if_read(copy_loop_proc_U0_update_read)
);

assign ap_channel_done_src_V = width_loop_proc5_U0_ap_done;

assign ap_done = copy_loop_proc_U0_ap_done;

assign ap_idle = (width_loop_proc5_U0_ap_idle & (src_V_t_empty_n ^ 1'b1) & copy_loop_proc_U0_ap_idle);

assign ap_ready = width_loop_proc5_U0_ap_ready;

assign ap_sync_continue = ap_continue;

assign ap_sync_done = copy_loop_proc_U0_ap_done;

assign ap_sync_ready = width_loop_proc5_U0_ap_ready;

assign copy_loop_proc_U0_ap_continue = ap_continue;

assign copy_loop_proc_U0_ap_start = src_V_t_empty_n;

assign copy_loop_proc_U0_start_full_n = 1'b1;

assign copy_loop_proc_U0_start_write = 1'b0;

assign m_axi_cp_ARADDR = width_loop_proc5_U0_m_axi_cp_ARADDR;

assign m_axi_cp_ARBURST = width_loop_proc5_U0_m_axi_cp_ARBURST;

assign m_axi_cp_ARCACHE = width_loop_proc5_U0_m_axi_cp_ARCACHE;

assign m_axi_cp_ARID = width_loop_proc5_U0_m_axi_cp_ARID;

assign m_axi_cp_ARLEN = width_loop_proc5_U0_m_axi_cp_ARLEN;

assign m_axi_cp_ARLOCK = width_loop_proc5_U0_m_axi_cp_ARLOCK;

assign m_axi_cp_ARPROT = width_loop_proc5_U0_m_axi_cp_ARPROT;

assign m_axi_cp_ARQOS = width_loop_proc5_U0_m_axi_cp_ARQOS;

assign m_axi_cp_ARREGION = width_loop_proc5_U0_m_axi_cp_ARREGION;

assign m_axi_cp_ARSIZE = width_loop_proc5_U0_m_axi_cp_ARSIZE;

assign m_axi_cp_ARUSER = width_loop_proc5_U0_m_axi_cp_ARUSER;

assign m_axi_cp_ARVALID = width_loop_proc5_U0_m_axi_cp_ARVALID;

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

assign m_axi_cp_RREADY = width_loop_proc5_U0_m_axi_cp_RREADY;

assign m_axi_cp_WDATA = 32'd0;

assign m_axi_cp_WID = 1'd0;

assign m_axi_cp_WLAST = 1'b0;

assign m_axi_cp_WSTRB = 4'd0;

assign m_axi_cp_WUSER = 1'd0;

assign m_axi_cp_WVALID = 1'b0;

assign m_axi_up_ARADDR = 64'd0;

assign m_axi_up_ARBURST = 2'd0;

assign m_axi_up_ARCACHE = 4'd0;

assign m_axi_up_ARID = 1'd0;

assign m_axi_up_ARLEN = 32'd0;

assign m_axi_up_ARLOCK = 2'd0;

assign m_axi_up_ARPROT = 3'd0;

assign m_axi_up_ARQOS = 4'd0;

assign m_axi_up_ARREGION = 4'd0;

assign m_axi_up_ARSIZE = 3'd0;

assign m_axi_up_ARUSER = 1'd0;

assign m_axi_up_ARVALID = 1'b0;

assign m_axi_up_AWADDR = copy_loop_proc_U0_m_axi_up_AWADDR;

assign m_axi_up_AWBURST = copy_loop_proc_U0_m_axi_up_AWBURST;

assign m_axi_up_AWCACHE = copy_loop_proc_U0_m_axi_up_AWCACHE;

assign m_axi_up_AWID = copy_loop_proc_U0_m_axi_up_AWID;

assign m_axi_up_AWLEN = copy_loop_proc_U0_m_axi_up_AWLEN;

assign m_axi_up_AWLOCK = copy_loop_proc_U0_m_axi_up_AWLOCK;

assign m_axi_up_AWPROT = copy_loop_proc_U0_m_axi_up_AWPROT;

assign m_axi_up_AWQOS = copy_loop_proc_U0_m_axi_up_AWQOS;

assign m_axi_up_AWREGION = copy_loop_proc_U0_m_axi_up_AWREGION;

assign m_axi_up_AWSIZE = copy_loop_proc_U0_m_axi_up_AWSIZE;

assign m_axi_up_AWUSER = copy_loop_proc_U0_m_axi_up_AWUSER;

assign m_axi_up_AWVALID = copy_loop_proc_U0_m_axi_up_AWVALID;

assign m_axi_up_BREADY = copy_loop_proc_U0_m_axi_up_BREADY;

assign m_axi_up_RREADY = 1'b0;

assign m_axi_up_WDATA = copy_loop_proc_U0_m_axi_up_WDATA;

assign m_axi_up_WID = copy_loop_proc_U0_m_axi_up_WID;

assign m_axi_up_WLAST = copy_loop_proc_U0_m_axi_up_WLAST;

assign m_axi_up_WSTRB = copy_loop_proc_U0_m_axi_up_WSTRB;

assign m_axi_up_WUSER = copy_loop_proc_U0_m_axi_up_WUSER;

assign m_axi_up_WVALID = copy_loop_proc_U0_m_axi_up_WVALID;

assign width_loop_proc5_U0_ap_continue = src_V_i_full_n;

assign width_loop_proc5_U0_ap_start = ap_start;

assign width_loop_proc5_U0_src_V1_full_n = src_V_i_full_n;

assign width_loop_proc5_U0_start_full_n = 1'b1;

assign width_loop_proc5_U0_start_write = 1'b0;

endmodule //framebuffer_copy_dataflow_in_loop_height_loop
