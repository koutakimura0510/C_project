// ==============================================================
// RTL generated by Vitis HLS - High-Level Synthesis from C, C++ and OpenCL v2020.2 (64-bit)
// Version: 2020.2
// Copyright (C) Copyright 1986-2020 Xilinx, Inc. All Rights Reserved.
// 
// ===========================================================

`timescale 1 ns / 1 ps 

(* CORE_GENERATION_INFO="affine_scale_affine_scale,hls_ip_2020_2,{HLS_INPUT_TYPE=cxx,HLS_INPUT_FLOAT=0,HLS_INPUT_FIXED=0,HLS_INPUT_PART=xc7z020-clg400-1,HLS_INPUT_CLOCK=10.000000,HLS_INPUT_ARCH=others,HLS_SYN_CLOCK=7.300000,HLS_SYN_LAT=72986,HLS_SYN_TPT=none,HLS_SYN_MEM=11,HLS_SYN_DSP=0,HLS_SYN_FF=19445,HLS_SYN_LUT=13887,HLS_VERSION=2020_2}" *)

module affine_scale (
        s_axi_control_AWVALID,
        s_axi_control_AWREADY,
        s_axi_control_AWADDR,
        s_axi_control_WVALID,
        s_axi_control_WREADY,
        s_axi_control_WDATA,
        s_axi_control_WSTRB,
        s_axi_control_ARVALID,
        s_axi_control_ARREADY,
        s_axi_control_ARADDR,
        s_axi_control_RVALID,
        s_axi_control_RREADY,
        s_axi_control_RDATA,
        s_axi_control_RRESP,
        s_axi_control_BVALID,
        s_axi_control_BREADY,
        s_axi_control_BRESP,
        ap_clk,
        ap_rst_n,
        interrupt,
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
        m_axi_dst_BUSER
);

parameter    C_S_AXI_CONTROL_DATA_WIDTH = 32;
parameter    C_S_AXI_CONTROL_ADDR_WIDTH = 8;
parameter    C_S_AXI_DATA_WIDTH = 32;
parameter    C_S_AXI_ADDR_WIDTH = 32;
parameter    C_M_AXI_SRC_ID_WIDTH = 1;
parameter    C_M_AXI_SRC_ADDR_WIDTH = 64;
parameter    C_M_AXI_SRC_DATA_WIDTH = 32;
parameter    C_M_AXI_SRC_AWUSER_WIDTH = 1;
parameter    C_M_AXI_SRC_ARUSER_WIDTH = 1;
parameter    C_M_AXI_SRC_WUSER_WIDTH = 1;
parameter    C_M_AXI_SRC_RUSER_WIDTH = 1;
parameter    C_M_AXI_SRC_BUSER_WIDTH = 1;
parameter    C_M_AXI_SRC_USER_VALUE = 0;
parameter    C_M_AXI_SRC_PROT_VALUE = 0;
parameter    C_M_AXI_SRC_CACHE_VALUE = 3;
parameter    C_M_AXI_ID_WIDTH = 1;
parameter    C_M_AXI_ADDR_WIDTH = 64;
parameter    C_M_AXI_DATA_WIDTH = 32;
parameter    C_M_AXI_AWUSER_WIDTH = 1;
parameter    C_M_AXI_ARUSER_WIDTH = 1;
parameter    C_M_AXI_WUSER_WIDTH = 1;
parameter    C_M_AXI_RUSER_WIDTH = 1;
parameter    C_M_AXI_BUSER_WIDTH = 1;
parameter    C_M_AXI_DST_ID_WIDTH = 1;
parameter    C_M_AXI_DST_ADDR_WIDTH = 64;
parameter    C_M_AXI_DST_DATA_WIDTH = 32;
parameter    C_M_AXI_DST_AWUSER_WIDTH = 1;
parameter    C_M_AXI_DST_ARUSER_WIDTH = 1;
parameter    C_M_AXI_DST_WUSER_WIDTH = 1;
parameter    C_M_AXI_DST_RUSER_WIDTH = 1;
parameter    C_M_AXI_DST_BUSER_WIDTH = 1;
parameter    C_M_AXI_DST_USER_VALUE = 0;
parameter    C_M_AXI_DST_PROT_VALUE = 0;
parameter    C_M_AXI_DST_CACHE_VALUE = 3;

parameter C_S_AXI_CONTROL_WSTRB_WIDTH = (32 / 8);
parameter C_S_AXI_WSTRB_WIDTH = (32 / 8);
parameter C_M_AXI_SRC_WSTRB_WIDTH = (32 / 8);
parameter C_M_AXI_WSTRB_WIDTH = (32 / 8);
parameter C_M_AXI_DST_WSTRB_WIDTH = (32 / 8);

input   s_axi_control_AWVALID;
output   s_axi_control_AWREADY;
input  [C_S_AXI_CONTROL_ADDR_WIDTH - 1:0] s_axi_control_AWADDR;
input   s_axi_control_WVALID;
output   s_axi_control_WREADY;
input  [C_S_AXI_CONTROL_DATA_WIDTH - 1:0] s_axi_control_WDATA;
input  [C_S_AXI_CONTROL_WSTRB_WIDTH - 1:0] s_axi_control_WSTRB;
input   s_axi_control_ARVALID;
output   s_axi_control_ARREADY;
input  [C_S_AXI_CONTROL_ADDR_WIDTH - 1:0] s_axi_control_ARADDR;
output   s_axi_control_RVALID;
input   s_axi_control_RREADY;
output  [C_S_AXI_CONTROL_DATA_WIDTH - 1:0] s_axi_control_RDATA;
output  [1:0] s_axi_control_RRESP;
output   s_axi_control_BVALID;
input   s_axi_control_BREADY;
output  [1:0] s_axi_control_BRESP;
input   ap_clk;
input   ap_rst_n;
output   interrupt;
output   m_axi_src_AWVALID;
input   m_axi_src_AWREADY;
output  [C_M_AXI_SRC_ADDR_WIDTH - 1:0] m_axi_src_AWADDR;
output  [C_M_AXI_SRC_ID_WIDTH - 1:0] m_axi_src_AWID;
output  [7:0] m_axi_src_AWLEN;
output  [2:0] m_axi_src_AWSIZE;
output  [1:0] m_axi_src_AWBURST;
output  [1:0] m_axi_src_AWLOCK;
output  [3:0] m_axi_src_AWCACHE;
output  [2:0] m_axi_src_AWPROT;
output  [3:0] m_axi_src_AWQOS;
output  [3:0] m_axi_src_AWREGION;
output  [C_M_AXI_SRC_AWUSER_WIDTH - 1:0] m_axi_src_AWUSER;
output   m_axi_src_WVALID;
input   m_axi_src_WREADY;
output  [C_M_AXI_SRC_DATA_WIDTH - 1:0] m_axi_src_WDATA;
output  [C_M_AXI_SRC_WSTRB_WIDTH - 1:0] m_axi_src_WSTRB;
output   m_axi_src_WLAST;
output  [C_M_AXI_SRC_ID_WIDTH - 1:0] m_axi_src_WID;
output  [C_M_AXI_SRC_WUSER_WIDTH - 1:0] m_axi_src_WUSER;
output   m_axi_src_ARVALID;
input   m_axi_src_ARREADY;
output  [C_M_AXI_SRC_ADDR_WIDTH - 1:0] m_axi_src_ARADDR;
output  [C_M_AXI_SRC_ID_WIDTH - 1:0] m_axi_src_ARID;
output  [7:0] m_axi_src_ARLEN;
output  [2:0] m_axi_src_ARSIZE;
output  [1:0] m_axi_src_ARBURST;
output  [1:0] m_axi_src_ARLOCK;
output  [3:0] m_axi_src_ARCACHE;
output  [2:0] m_axi_src_ARPROT;
output  [3:0] m_axi_src_ARQOS;
output  [3:0] m_axi_src_ARREGION;
output  [C_M_AXI_SRC_ARUSER_WIDTH - 1:0] m_axi_src_ARUSER;
input   m_axi_src_RVALID;
output   m_axi_src_RREADY;
input  [C_M_AXI_SRC_DATA_WIDTH - 1:0] m_axi_src_RDATA;
input   m_axi_src_RLAST;
input  [C_M_AXI_SRC_ID_WIDTH - 1:0] m_axi_src_RID;
input  [C_M_AXI_SRC_RUSER_WIDTH - 1:0] m_axi_src_RUSER;
input  [1:0] m_axi_src_RRESP;
input   m_axi_src_BVALID;
output   m_axi_src_BREADY;
input  [1:0] m_axi_src_BRESP;
input  [C_M_AXI_SRC_ID_WIDTH - 1:0] m_axi_src_BID;
input  [C_M_AXI_SRC_BUSER_WIDTH - 1:0] m_axi_src_BUSER;
output   m_axi_dst_AWVALID;
input   m_axi_dst_AWREADY;
output  [C_M_AXI_DST_ADDR_WIDTH - 1:0] m_axi_dst_AWADDR;
output  [C_M_AXI_DST_ID_WIDTH - 1:0] m_axi_dst_AWID;
output  [7:0] m_axi_dst_AWLEN;
output  [2:0] m_axi_dst_AWSIZE;
output  [1:0] m_axi_dst_AWBURST;
output  [1:0] m_axi_dst_AWLOCK;
output  [3:0] m_axi_dst_AWCACHE;
output  [2:0] m_axi_dst_AWPROT;
output  [3:0] m_axi_dst_AWQOS;
output  [3:0] m_axi_dst_AWREGION;
output  [C_M_AXI_DST_AWUSER_WIDTH - 1:0] m_axi_dst_AWUSER;
output   m_axi_dst_WVALID;
input   m_axi_dst_WREADY;
output  [C_M_AXI_DST_DATA_WIDTH - 1:0] m_axi_dst_WDATA;
output  [C_M_AXI_DST_WSTRB_WIDTH - 1:0] m_axi_dst_WSTRB;
output   m_axi_dst_WLAST;
output  [C_M_AXI_DST_ID_WIDTH - 1:0] m_axi_dst_WID;
output  [C_M_AXI_DST_WUSER_WIDTH - 1:0] m_axi_dst_WUSER;
output   m_axi_dst_ARVALID;
input   m_axi_dst_ARREADY;
output  [C_M_AXI_DST_ADDR_WIDTH - 1:0] m_axi_dst_ARADDR;
output  [C_M_AXI_DST_ID_WIDTH - 1:0] m_axi_dst_ARID;
output  [7:0] m_axi_dst_ARLEN;
output  [2:0] m_axi_dst_ARSIZE;
output  [1:0] m_axi_dst_ARBURST;
output  [1:0] m_axi_dst_ARLOCK;
output  [3:0] m_axi_dst_ARCACHE;
output  [2:0] m_axi_dst_ARPROT;
output  [3:0] m_axi_dst_ARQOS;
output  [3:0] m_axi_dst_ARREGION;
output  [C_M_AXI_DST_ARUSER_WIDTH - 1:0] m_axi_dst_ARUSER;
input   m_axi_dst_RVALID;
output   m_axi_dst_RREADY;
input  [C_M_AXI_DST_DATA_WIDTH - 1:0] m_axi_dst_RDATA;
input   m_axi_dst_RLAST;
input  [C_M_AXI_DST_ID_WIDTH - 1:0] m_axi_dst_RID;
input  [C_M_AXI_DST_RUSER_WIDTH - 1:0] m_axi_dst_RUSER;
input  [1:0] m_axi_dst_RRESP;
input   m_axi_dst_BVALID;
output   m_axi_dst_BREADY;
input  [1:0] m_axi_dst_BRESP;
input  [C_M_AXI_DST_ID_WIDTH - 1:0] m_axi_dst_BID;
input  [C_M_AXI_DST_BUSER_WIDTH - 1:0] m_axi_dst_BUSER;

 reg    ap_rst_n_inv;
wire   [63:0] srcin;
wire   [63:0] dstin;
wire   [63:0] dstout;
wire   [31:0] mapchip_maxwidth;
wire   [31:0] mapchip_maxheight;
wire   [31:0] mapchip_draw_xsize;
wire   [31:0] mapchip_draw_ysize;
wire   [31:0] xstart_pos;
wire   [31:0] ystart_pos;
wire   [31:0] frame_size;
wire   [7:0] alpha;
wire   [31:0] id;
wire   [31:0] a;
wire   [31:0] b;
wire   [31:0] c;
wire   [31:0] d;
wire   [31:0] m;
wire   [31:0] n;
wire    ap_start;
reg    ap_ready;
reg    ap_done;
reg    ap_idle;
wire    src_AWREADY;
wire    src_WREADY;
wire    src_ARREADY;
wire    src_RVALID;
wire   [31:0] src_RDATA;
wire    src_RLAST;
wire   [0:0] src_RID;
wire   [0:0] src_RUSER;
wire   [1:0] src_RRESP;
wire    src_BVALID;
wire   [1:0] src_BRESP;
wire   [0:0] src_BID;
wire   [0:0] src_BUSER;
wire    dst_AWREADY;
wire    dst_WREADY;
wire    dst_ARREADY;
wire    dst_RVALID;
wire   [31:0] dst_RDATA;
wire    dst_RLAST;
wire   [0:0] dst_RID;
wire   [0:0] dst_RUSER;
wire   [1:0] dst_RRESP;
wire    dst_BVALID;
wire   [1:0] dst_BRESP;
wire   [0:0] dst_BID;
wire   [0:0] dst_BUSER;
wire   [19:0] dataflow_in_loop_height_loop_U0_d;
wire   [19:0] dataflow_in_loop_height_loop_U0_a;
wire   [19:0] dataflow_in_loop_height_loop_U0_c;
wire   [19:0] dataflow_in_loop_height_loop_U0_b;
wire    dataflow_in_loop_height_loop_U0_m_axi_src_AWVALID;
wire   [63:0] dataflow_in_loop_height_loop_U0_m_axi_src_AWADDR;
wire   [0:0] dataflow_in_loop_height_loop_U0_m_axi_src_AWID;
wire   [31:0] dataflow_in_loop_height_loop_U0_m_axi_src_AWLEN;
wire   [2:0] dataflow_in_loop_height_loop_U0_m_axi_src_AWSIZE;
wire   [1:0] dataflow_in_loop_height_loop_U0_m_axi_src_AWBURST;
wire   [1:0] dataflow_in_loop_height_loop_U0_m_axi_src_AWLOCK;
wire   [3:0] dataflow_in_loop_height_loop_U0_m_axi_src_AWCACHE;
wire   [2:0] dataflow_in_loop_height_loop_U0_m_axi_src_AWPROT;
wire   [3:0] dataflow_in_loop_height_loop_U0_m_axi_src_AWQOS;
wire   [3:0] dataflow_in_loop_height_loop_U0_m_axi_src_AWREGION;
wire   [0:0] dataflow_in_loop_height_loop_U0_m_axi_src_AWUSER;
wire    dataflow_in_loop_height_loop_U0_m_axi_src_WVALID;
wire   [31:0] dataflow_in_loop_height_loop_U0_m_axi_src_WDATA;
wire   [3:0] dataflow_in_loop_height_loop_U0_m_axi_src_WSTRB;
wire    dataflow_in_loop_height_loop_U0_m_axi_src_WLAST;
wire   [0:0] dataflow_in_loop_height_loop_U0_m_axi_src_WID;
wire   [0:0] dataflow_in_loop_height_loop_U0_m_axi_src_WUSER;
wire    dataflow_in_loop_height_loop_U0_m_axi_src_ARVALID;
wire   [63:0] dataflow_in_loop_height_loop_U0_m_axi_src_ARADDR;
wire   [0:0] dataflow_in_loop_height_loop_U0_m_axi_src_ARID;
wire   [31:0] dataflow_in_loop_height_loop_U0_m_axi_src_ARLEN;
wire   [2:0] dataflow_in_loop_height_loop_U0_m_axi_src_ARSIZE;
wire   [1:0] dataflow_in_loop_height_loop_U0_m_axi_src_ARBURST;
wire   [1:0] dataflow_in_loop_height_loop_U0_m_axi_src_ARLOCK;
wire   [3:0] dataflow_in_loop_height_loop_U0_m_axi_src_ARCACHE;
wire   [2:0] dataflow_in_loop_height_loop_U0_m_axi_src_ARPROT;
wire   [3:0] dataflow_in_loop_height_loop_U0_m_axi_src_ARQOS;
wire   [3:0] dataflow_in_loop_height_loop_U0_m_axi_src_ARREGION;
wire   [0:0] dataflow_in_loop_height_loop_U0_m_axi_src_ARUSER;
wire    dataflow_in_loop_height_loop_U0_m_axi_src_RREADY;
wire    dataflow_in_loop_height_loop_U0_m_axi_src_BREADY;
wire    dataflow_in_loop_height_loop_U0_m_axi_dst_AWVALID;
wire   [63:0] dataflow_in_loop_height_loop_U0_m_axi_dst_AWADDR;
wire   [0:0] dataflow_in_loop_height_loop_U0_m_axi_dst_AWID;
wire   [31:0] dataflow_in_loop_height_loop_U0_m_axi_dst_AWLEN;
wire   [2:0] dataflow_in_loop_height_loop_U0_m_axi_dst_AWSIZE;
wire   [1:0] dataflow_in_loop_height_loop_U0_m_axi_dst_AWBURST;
wire   [1:0] dataflow_in_loop_height_loop_U0_m_axi_dst_AWLOCK;
wire   [3:0] dataflow_in_loop_height_loop_U0_m_axi_dst_AWCACHE;
wire   [2:0] dataflow_in_loop_height_loop_U0_m_axi_dst_AWPROT;
wire   [3:0] dataflow_in_loop_height_loop_U0_m_axi_dst_AWQOS;
wire   [3:0] dataflow_in_loop_height_loop_U0_m_axi_dst_AWREGION;
wire   [0:0] dataflow_in_loop_height_loop_U0_m_axi_dst_AWUSER;
wire    dataflow_in_loop_height_loop_U0_m_axi_dst_WVALID;
wire   [31:0] dataflow_in_loop_height_loop_U0_m_axi_dst_WDATA;
wire   [3:0] dataflow_in_loop_height_loop_U0_m_axi_dst_WSTRB;
wire    dataflow_in_loop_height_loop_U0_m_axi_dst_WLAST;
wire   [0:0] dataflow_in_loop_height_loop_U0_m_axi_dst_WID;
wire   [0:0] dataflow_in_loop_height_loop_U0_m_axi_dst_WUSER;
wire    dataflow_in_loop_height_loop_U0_m_axi_dst_ARVALID;
wire   [63:0] dataflow_in_loop_height_loop_U0_m_axi_dst_ARADDR;
wire   [0:0] dataflow_in_loop_height_loop_U0_m_axi_dst_ARID;
wire   [31:0] dataflow_in_loop_height_loop_U0_m_axi_dst_ARLEN;
wire   [2:0] dataflow_in_loop_height_loop_U0_m_axi_dst_ARSIZE;
wire   [1:0] dataflow_in_loop_height_loop_U0_m_axi_dst_ARBURST;
wire   [1:0] dataflow_in_loop_height_loop_U0_m_axi_dst_ARLOCK;
wire   [3:0] dataflow_in_loop_height_loop_U0_m_axi_dst_ARCACHE;
wire   [2:0] dataflow_in_loop_height_loop_U0_m_axi_dst_ARPROT;
wire   [3:0] dataflow_in_loop_height_loop_U0_m_axi_dst_ARQOS;
wire   [3:0] dataflow_in_loop_height_loop_U0_m_axi_dst_ARREGION;
wire   [0:0] dataflow_in_loop_height_loop_U0_m_axi_dst_ARUSER;
wire    dataflow_in_loop_height_loop_U0_m_axi_dst_RREADY;
wire    dataflow_in_loop_height_loop_U0_m_axi_dst_BREADY;
wire    dataflow_in_loop_height_loop_U0_ap_start;
wire    dataflow_in_loop_height_loop_U0_ap_done;
wire    dataflow_in_loop_height_loop_U0_ap_ready;
wire    dataflow_in_loop_height_loop_U0_ap_idle;
wire    dataflow_in_loop_height_loop_U0_ap_continue;
wire    ap_sync_continue;
wire    ap_sync_done;
wire    ap_sync_ready;
reg   [31:0] loop_dataflow_input_count;
reg   [31:0] loop_dataflow_output_count;
wire   [31:0] bound_minus_1;
wire    dataflow_in_loop_height_loop_U0_start_full_n;
wire    dataflow_in_loop_height_loop_U0_start_write;
wire    ap_ce_reg;

// power-on initialization
initial begin
#0 loop_dataflow_input_count = 32'd0;
#0 loop_dataflow_output_count = 32'd0;
end

affine_scale_control_s_axi #(
    .C_S_AXI_ADDR_WIDTH( C_S_AXI_CONTROL_ADDR_WIDTH ),
    .C_S_AXI_DATA_WIDTH( C_S_AXI_CONTROL_DATA_WIDTH ))
control_s_axi_U(
    .AWVALID(s_axi_control_AWVALID),
    .AWREADY(s_axi_control_AWREADY),
    .AWADDR(s_axi_control_AWADDR),
    .WVALID(s_axi_control_WVALID),
    .WREADY(s_axi_control_WREADY),
    .WDATA(s_axi_control_WDATA),
    .WSTRB(s_axi_control_WSTRB),
    .ARVALID(s_axi_control_ARVALID),
    .ARREADY(s_axi_control_ARREADY),
    .ARADDR(s_axi_control_ARADDR),
    .RVALID(s_axi_control_RVALID),
    .RREADY(s_axi_control_RREADY),
    .RDATA(s_axi_control_RDATA),
    .RRESP(s_axi_control_RRESP),
    .BVALID(s_axi_control_BVALID),
    .BREADY(s_axi_control_BREADY),
    .BRESP(s_axi_control_BRESP),
    .ACLK(ap_clk),
    .ARESET(ap_rst_n_inv),
    .ACLK_EN(1'b1),
    .srcin(srcin),
    .dstin(dstin),
    .dstout(dstout),
    .mapchip_maxwidth(mapchip_maxwidth),
    .mapchip_maxheight(mapchip_maxheight),
    .mapchip_draw_xsize(mapchip_draw_xsize),
    .mapchip_draw_ysize(mapchip_draw_ysize),
    .xstart_pos(xstart_pos),
    .ystart_pos(ystart_pos),
    .frame_size(frame_size),
    .alpha(alpha),
    .id(id),
    .a(a),
    .b(b),
    .c(c),
    .d(d),
    .m(m),
    .n(n),
    .ap_start(ap_start),
    .interrupt(interrupt),
    .ap_ready(ap_ready),
    .ap_done(ap_done),
    .ap_idle(ap_idle)
);

affine_scale_src_m_axi #(
    .CONSERVATIVE( 0 ),
    .USER_DW( 32 ),
    .USER_AW( 64 ),
    .USER_MAXREQS( 5 ),
    .NUM_READ_OUTSTANDING( 16 ),
    .NUM_WRITE_OUTSTANDING( 16 ),
    .MAX_READ_BURST_LENGTH( 32 ),
    .MAX_WRITE_BURST_LENGTH( 16 ),
    .C_M_AXI_ID_WIDTH( C_M_AXI_SRC_ID_WIDTH ),
    .C_M_AXI_ADDR_WIDTH( C_M_AXI_SRC_ADDR_WIDTH ),
    .C_M_AXI_DATA_WIDTH( C_M_AXI_SRC_DATA_WIDTH ),
    .C_M_AXI_AWUSER_WIDTH( C_M_AXI_SRC_AWUSER_WIDTH ),
    .C_M_AXI_ARUSER_WIDTH( C_M_AXI_SRC_ARUSER_WIDTH ),
    .C_M_AXI_WUSER_WIDTH( C_M_AXI_SRC_WUSER_WIDTH ),
    .C_M_AXI_RUSER_WIDTH( C_M_AXI_SRC_RUSER_WIDTH ),
    .C_M_AXI_BUSER_WIDTH( C_M_AXI_SRC_BUSER_WIDTH ),
    .C_USER_VALUE( C_M_AXI_SRC_USER_VALUE ),
    .C_PROT_VALUE( C_M_AXI_SRC_PROT_VALUE ),
    .C_CACHE_VALUE( C_M_AXI_SRC_CACHE_VALUE ))
src_m_axi_U(
    .AWVALID(m_axi_src_AWVALID),
    .AWREADY(m_axi_src_AWREADY),
    .AWADDR(m_axi_src_AWADDR),
    .AWID(m_axi_src_AWID),
    .AWLEN(m_axi_src_AWLEN),
    .AWSIZE(m_axi_src_AWSIZE),
    .AWBURST(m_axi_src_AWBURST),
    .AWLOCK(m_axi_src_AWLOCK),
    .AWCACHE(m_axi_src_AWCACHE),
    .AWPROT(m_axi_src_AWPROT),
    .AWQOS(m_axi_src_AWQOS),
    .AWREGION(m_axi_src_AWREGION),
    .AWUSER(m_axi_src_AWUSER),
    .WVALID(m_axi_src_WVALID),
    .WREADY(m_axi_src_WREADY),
    .WDATA(m_axi_src_WDATA),
    .WSTRB(m_axi_src_WSTRB),
    .WLAST(m_axi_src_WLAST),
    .WID(m_axi_src_WID),
    .WUSER(m_axi_src_WUSER),
    .ARVALID(m_axi_src_ARVALID),
    .ARREADY(m_axi_src_ARREADY),
    .ARADDR(m_axi_src_ARADDR),
    .ARID(m_axi_src_ARID),
    .ARLEN(m_axi_src_ARLEN),
    .ARSIZE(m_axi_src_ARSIZE),
    .ARBURST(m_axi_src_ARBURST),
    .ARLOCK(m_axi_src_ARLOCK),
    .ARCACHE(m_axi_src_ARCACHE),
    .ARPROT(m_axi_src_ARPROT),
    .ARQOS(m_axi_src_ARQOS),
    .ARREGION(m_axi_src_ARREGION),
    .ARUSER(m_axi_src_ARUSER),
    .RVALID(m_axi_src_RVALID),
    .RREADY(m_axi_src_RREADY),
    .RDATA(m_axi_src_RDATA),
    .RLAST(m_axi_src_RLAST),
    .RID(m_axi_src_RID),
    .RUSER(m_axi_src_RUSER),
    .RRESP(m_axi_src_RRESP),
    .BVALID(m_axi_src_BVALID),
    .BREADY(m_axi_src_BREADY),
    .BRESP(m_axi_src_BRESP),
    .BID(m_axi_src_BID),
    .BUSER(m_axi_src_BUSER),
    .ACLK(ap_clk),
    .ARESET(ap_rst_n_inv),
    .ACLK_EN(1'b1),
    .I_ARVALID(dataflow_in_loop_height_loop_U0_m_axi_src_ARVALID),
    .I_ARREADY(src_ARREADY),
    .I_ARADDR(dataflow_in_loop_height_loop_U0_m_axi_src_ARADDR),
    .I_ARID(dataflow_in_loop_height_loop_U0_m_axi_src_ARID),
    .I_ARLEN(dataflow_in_loop_height_loop_U0_m_axi_src_ARLEN),
    .I_ARSIZE(dataflow_in_loop_height_loop_U0_m_axi_src_ARSIZE),
    .I_ARLOCK(dataflow_in_loop_height_loop_U0_m_axi_src_ARLOCK),
    .I_ARCACHE(dataflow_in_loop_height_loop_U0_m_axi_src_ARCACHE),
    .I_ARQOS(dataflow_in_loop_height_loop_U0_m_axi_src_ARQOS),
    .I_ARPROT(dataflow_in_loop_height_loop_U0_m_axi_src_ARPROT),
    .I_ARUSER(dataflow_in_loop_height_loop_U0_m_axi_src_ARUSER),
    .I_ARBURST(dataflow_in_loop_height_loop_U0_m_axi_src_ARBURST),
    .I_ARREGION(dataflow_in_loop_height_loop_U0_m_axi_src_ARREGION),
    .I_RVALID(src_RVALID),
    .I_RREADY(dataflow_in_loop_height_loop_U0_m_axi_src_RREADY),
    .I_RDATA(src_RDATA),
    .I_RID(src_RID),
    .I_RUSER(src_RUSER),
    .I_RRESP(src_RRESP),
    .I_RLAST(src_RLAST),
    .I_AWVALID(1'b0),
    .I_AWREADY(src_AWREADY),
    .I_AWADDR(64'd0),
    .I_AWID(1'd0),
    .I_AWLEN(32'd0),
    .I_AWSIZE(3'd0),
    .I_AWLOCK(2'd0),
    .I_AWCACHE(4'd0),
    .I_AWQOS(4'd0),
    .I_AWPROT(3'd0),
    .I_AWUSER(1'd0),
    .I_AWBURST(2'd0),
    .I_AWREGION(4'd0),
    .I_WVALID(1'b0),
    .I_WREADY(src_WREADY),
    .I_WDATA(32'd0),
    .I_WID(1'd0),
    .I_WUSER(1'd0),
    .I_WLAST(1'b0),
    .I_WSTRB(4'd0),
    .I_BVALID(src_BVALID),
    .I_BREADY(1'b0),
    .I_BRESP(src_BRESP),
    .I_BID(src_BID),
    .I_BUSER(src_BUSER)
);

affine_scale_dst_m_axi #(
    .CONSERVATIVE( 0 ),
    .USER_DW( 32 ),
    .USER_AW( 64 ),
    .USER_MAXREQS( 5 ),
    .NUM_READ_OUTSTANDING( 16 ),
    .NUM_WRITE_OUTSTANDING( 16 ),
    .MAX_READ_BURST_LENGTH( 32 ),
    .MAX_WRITE_BURST_LENGTH( 32 ),
    .C_M_AXI_ID_WIDTH( C_M_AXI_DST_ID_WIDTH ),
    .C_M_AXI_ADDR_WIDTH( C_M_AXI_DST_ADDR_WIDTH ),
    .C_M_AXI_DATA_WIDTH( C_M_AXI_DST_DATA_WIDTH ),
    .C_M_AXI_AWUSER_WIDTH( C_M_AXI_DST_AWUSER_WIDTH ),
    .C_M_AXI_ARUSER_WIDTH( C_M_AXI_DST_ARUSER_WIDTH ),
    .C_M_AXI_WUSER_WIDTH( C_M_AXI_DST_WUSER_WIDTH ),
    .C_M_AXI_RUSER_WIDTH( C_M_AXI_DST_RUSER_WIDTH ),
    .C_M_AXI_BUSER_WIDTH( C_M_AXI_DST_BUSER_WIDTH ),
    .C_USER_VALUE( C_M_AXI_DST_USER_VALUE ),
    .C_PROT_VALUE( C_M_AXI_DST_PROT_VALUE ),
    .C_CACHE_VALUE( C_M_AXI_DST_CACHE_VALUE ))
dst_m_axi_U(
    .AWVALID(m_axi_dst_AWVALID),
    .AWREADY(m_axi_dst_AWREADY),
    .AWADDR(m_axi_dst_AWADDR),
    .AWID(m_axi_dst_AWID),
    .AWLEN(m_axi_dst_AWLEN),
    .AWSIZE(m_axi_dst_AWSIZE),
    .AWBURST(m_axi_dst_AWBURST),
    .AWLOCK(m_axi_dst_AWLOCK),
    .AWCACHE(m_axi_dst_AWCACHE),
    .AWPROT(m_axi_dst_AWPROT),
    .AWQOS(m_axi_dst_AWQOS),
    .AWREGION(m_axi_dst_AWREGION),
    .AWUSER(m_axi_dst_AWUSER),
    .WVALID(m_axi_dst_WVALID),
    .WREADY(m_axi_dst_WREADY),
    .WDATA(m_axi_dst_WDATA),
    .WSTRB(m_axi_dst_WSTRB),
    .WLAST(m_axi_dst_WLAST),
    .WID(m_axi_dst_WID),
    .WUSER(m_axi_dst_WUSER),
    .ARVALID(m_axi_dst_ARVALID),
    .ARREADY(m_axi_dst_ARREADY),
    .ARADDR(m_axi_dst_ARADDR),
    .ARID(m_axi_dst_ARID),
    .ARLEN(m_axi_dst_ARLEN),
    .ARSIZE(m_axi_dst_ARSIZE),
    .ARBURST(m_axi_dst_ARBURST),
    .ARLOCK(m_axi_dst_ARLOCK),
    .ARCACHE(m_axi_dst_ARCACHE),
    .ARPROT(m_axi_dst_ARPROT),
    .ARQOS(m_axi_dst_ARQOS),
    .ARREGION(m_axi_dst_ARREGION),
    .ARUSER(m_axi_dst_ARUSER),
    .RVALID(m_axi_dst_RVALID),
    .RREADY(m_axi_dst_RREADY),
    .RDATA(m_axi_dst_RDATA),
    .RLAST(m_axi_dst_RLAST),
    .RID(m_axi_dst_RID),
    .RUSER(m_axi_dst_RUSER),
    .RRESP(m_axi_dst_RRESP),
    .BVALID(m_axi_dst_BVALID),
    .BREADY(m_axi_dst_BREADY),
    .BRESP(m_axi_dst_BRESP),
    .BID(m_axi_dst_BID),
    .BUSER(m_axi_dst_BUSER),
    .ACLK(ap_clk),
    .ARESET(ap_rst_n_inv),
    .ACLK_EN(1'b1),
    .I_ARVALID(dataflow_in_loop_height_loop_U0_m_axi_dst_ARVALID),
    .I_ARREADY(dst_ARREADY),
    .I_ARADDR(dataflow_in_loop_height_loop_U0_m_axi_dst_ARADDR),
    .I_ARID(dataflow_in_loop_height_loop_U0_m_axi_dst_ARID),
    .I_ARLEN(dataflow_in_loop_height_loop_U0_m_axi_dst_ARLEN),
    .I_ARSIZE(dataflow_in_loop_height_loop_U0_m_axi_dst_ARSIZE),
    .I_ARLOCK(dataflow_in_loop_height_loop_U0_m_axi_dst_ARLOCK),
    .I_ARCACHE(dataflow_in_loop_height_loop_U0_m_axi_dst_ARCACHE),
    .I_ARQOS(dataflow_in_loop_height_loop_U0_m_axi_dst_ARQOS),
    .I_ARPROT(dataflow_in_loop_height_loop_U0_m_axi_dst_ARPROT),
    .I_ARUSER(dataflow_in_loop_height_loop_U0_m_axi_dst_ARUSER),
    .I_ARBURST(dataflow_in_loop_height_loop_U0_m_axi_dst_ARBURST),
    .I_ARREGION(dataflow_in_loop_height_loop_U0_m_axi_dst_ARREGION),
    .I_RVALID(dst_RVALID),
    .I_RREADY(dataflow_in_loop_height_loop_U0_m_axi_dst_RREADY),
    .I_RDATA(dst_RDATA),
    .I_RID(dst_RID),
    .I_RUSER(dst_RUSER),
    .I_RRESP(dst_RRESP),
    .I_RLAST(dst_RLAST),
    .I_AWVALID(dataflow_in_loop_height_loop_U0_m_axi_dst_AWVALID),
    .I_AWREADY(dst_AWREADY),
    .I_AWADDR(dataflow_in_loop_height_loop_U0_m_axi_dst_AWADDR),
    .I_AWID(dataflow_in_loop_height_loop_U0_m_axi_dst_AWID),
    .I_AWLEN(dataflow_in_loop_height_loop_U0_m_axi_dst_AWLEN),
    .I_AWSIZE(dataflow_in_loop_height_loop_U0_m_axi_dst_AWSIZE),
    .I_AWLOCK(dataflow_in_loop_height_loop_U0_m_axi_dst_AWLOCK),
    .I_AWCACHE(dataflow_in_loop_height_loop_U0_m_axi_dst_AWCACHE),
    .I_AWQOS(dataflow_in_loop_height_loop_U0_m_axi_dst_AWQOS),
    .I_AWPROT(dataflow_in_loop_height_loop_U0_m_axi_dst_AWPROT),
    .I_AWUSER(dataflow_in_loop_height_loop_U0_m_axi_dst_AWUSER),
    .I_AWBURST(dataflow_in_loop_height_loop_U0_m_axi_dst_AWBURST),
    .I_AWREGION(dataflow_in_loop_height_loop_U0_m_axi_dst_AWREGION),
    .I_WVALID(dataflow_in_loop_height_loop_U0_m_axi_dst_WVALID),
    .I_WREADY(dst_WREADY),
    .I_WDATA(dataflow_in_loop_height_loop_U0_m_axi_dst_WDATA),
    .I_WID(dataflow_in_loop_height_loop_U0_m_axi_dst_WID),
    .I_WUSER(dataflow_in_loop_height_loop_U0_m_axi_dst_WUSER),
    .I_WLAST(dataflow_in_loop_height_loop_U0_m_axi_dst_WLAST),
    .I_WSTRB(dataflow_in_loop_height_loop_U0_m_axi_dst_WSTRB),
    .I_BVALID(dst_BVALID),
    .I_BREADY(dataflow_in_loop_height_loop_U0_m_axi_dst_BREADY),
    .I_BRESP(dst_BRESP),
    .I_BID(dst_BID),
    .I_BUSER(dst_BUSER)
);

affine_scale_dataflow_in_loop_height_loop dataflow_in_loop_height_loop_U0(
    .ap_clk(ap_clk),
    .ap_rst(ap_rst_n_inv),
    .mapchip_draw_xsize(mapchip_draw_xsize),
    .mapchip_maxwidth(mapchip_maxwidth),
    .d(dataflow_in_loop_height_loop_U0_d),
    .a(dataflow_in_loop_height_loop_U0_a),
    .c(dataflow_in_loop_height_loop_U0_c),
    .b(dataflow_in_loop_height_loop_U0_b),
    .m(m),
    .trunc_ln69(loop_dataflow_input_count),
    .mapchip_maxheight(mapchip_maxheight),
    .n(n),
    .id(id),
    .ystart_pos(ystart_pos),
    .xstart_pos(xstart_pos),
    .srcin(srcin),
    .m_axi_src_AWVALID(dataflow_in_loop_height_loop_U0_m_axi_src_AWVALID),
    .m_axi_src_AWREADY(1'b0),
    .m_axi_src_AWADDR(dataflow_in_loop_height_loop_U0_m_axi_src_AWADDR),
    .m_axi_src_AWID(dataflow_in_loop_height_loop_U0_m_axi_src_AWID),
    .m_axi_src_AWLEN(dataflow_in_loop_height_loop_U0_m_axi_src_AWLEN),
    .m_axi_src_AWSIZE(dataflow_in_loop_height_loop_U0_m_axi_src_AWSIZE),
    .m_axi_src_AWBURST(dataflow_in_loop_height_loop_U0_m_axi_src_AWBURST),
    .m_axi_src_AWLOCK(dataflow_in_loop_height_loop_U0_m_axi_src_AWLOCK),
    .m_axi_src_AWCACHE(dataflow_in_loop_height_loop_U0_m_axi_src_AWCACHE),
    .m_axi_src_AWPROT(dataflow_in_loop_height_loop_U0_m_axi_src_AWPROT),
    .m_axi_src_AWQOS(dataflow_in_loop_height_loop_U0_m_axi_src_AWQOS),
    .m_axi_src_AWREGION(dataflow_in_loop_height_loop_U0_m_axi_src_AWREGION),
    .m_axi_src_AWUSER(dataflow_in_loop_height_loop_U0_m_axi_src_AWUSER),
    .m_axi_src_WVALID(dataflow_in_loop_height_loop_U0_m_axi_src_WVALID),
    .m_axi_src_WREADY(1'b0),
    .m_axi_src_WDATA(dataflow_in_loop_height_loop_U0_m_axi_src_WDATA),
    .m_axi_src_WSTRB(dataflow_in_loop_height_loop_U0_m_axi_src_WSTRB),
    .m_axi_src_WLAST(dataflow_in_loop_height_loop_U0_m_axi_src_WLAST),
    .m_axi_src_WID(dataflow_in_loop_height_loop_U0_m_axi_src_WID),
    .m_axi_src_WUSER(dataflow_in_loop_height_loop_U0_m_axi_src_WUSER),
    .m_axi_src_ARVALID(dataflow_in_loop_height_loop_U0_m_axi_src_ARVALID),
    .m_axi_src_ARREADY(src_ARREADY),
    .m_axi_src_ARADDR(dataflow_in_loop_height_loop_U0_m_axi_src_ARADDR),
    .m_axi_src_ARID(dataflow_in_loop_height_loop_U0_m_axi_src_ARID),
    .m_axi_src_ARLEN(dataflow_in_loop_height_loop_U0_m_axi_src_ARLEN),
    .m_axi_src_ARSIZE(dataflow_in_loop_height_loop_U0_m_axi_src_ARSIZE),
    .m_axi_src_ARBURST(dataflow_in_loop_height_loop_U0_m_axi_src_ARBURST),
    .m_axi_src_ARLOCK(dataflow_in_loop_height_loop_U0_m_axi_src_ARLOCK),
    .m_axi_src_ARCACHE(dataflow_in_loop_height_loop_U0_m_axi_src_ARCACHE),
    .m_axi_src_ARPROT(dataflow_in_loop_height_loop_U0_m_axi_src_ARPROT),
    .m_axi_src_ARQOS(dataflow_in_loop_height_loop_U0_m_axi_src_ARQOS),
    .m_axi_src_ARREGION(dataflow_in_loop_height_loop_U0_m_axi_src_ARREGION),
    .m_axi_src_ARUSER(dataflow_in_loop_height_loop_U0_m_axi_src_ARUSER),
    .m_axi_src_RVALID(src_RVALID),
    .m_axi_src_RREADY(dataflow_in_loop_height_loop_U0_m_axi_src_RREADY),
    .m_axi_src_RDATA(src_RDATA),
    .m_axi_src_RLAST(src_RLAST),
    .m_axi_src_RID(src_RID),
    .m_axi_src_RUSER(src_RUSER),
    .m_axi_src_RRESP(src_RRESP),
    .m_axi_src_BVALID(1'b0),
    .m_axi_src_BREADY(dataflow_in_loop_height_loop_U0_m_axi_src_BREADY),
    .m_axi_src_BRESP(2'd0),
    .m_axi_src_BID(1'd0),
    .m_axi_src_BUSER(1'd0),
    .frame_size(frame_size),
    .dstin(dstin),
    .m_axi_dst_AWVALID(dataflow_in_loop_height_loop_U0_m_axi_dst_AWVALID),
    .m_axi_dst_AWREADY(dst_AWREADY),
    .m_axi_dst_AWADDR(dataflow_in_loop_height_loop_U0_m_axi_dst_AWADDR),
    .m_axi_dst_AWID(dataflow_in_loop_height_loop_U0_m_axi_dst_AWID),
    .m_axi_dst_AWLEN(dataflow_in_loop_height_loop_U0_m_axi_dst_AWLEN),
    .m_axi_dst_AWSIZE(dataflow_in_loop_height_loop_U0_m_axi_dst_AWSIZE),
    .m_axi_dst_AWBURST(dataflow_in_loop_height_loop_U0_m_axi_dst_AWBURST),
    .m_axi_dst_AWLOCK(dataflow_in_loop_height_loop_U0_m_axi_dst_AWLOCK),
    .m_axi_dst_AWCACHE(dataflow_in_loop_height_loop_U0_m_axi_dst_AWCACHE),
    .m_axi_dst_AWPROT(dataflow_in_loop_height_loop_U0_m_axi_dst_AWPROT),
    .m_axi_dst_AWQOS(dataflow_in_loop_height_loop_U0_m_axi_dst_AWQOS),
    .m_axi_dst_AWREGION(dataflow_in_loop_height_loop_U0_m_axi_dst_AWREGION),
    .m_axi_dst_AWUSER(dataflow_in_loop_height_loop_U0_m_axi_dst_AWUSER),
    .m_axi_dst_WVALID(dataflow_in_loop_height_loop_U0_m_axi_dst_WVALID),
    .m_axi_dst_WREADY(dst_WREADY),
    .m_axi_dst_WDATA(dataflow_in_loop_height_loop_U0_m_axi_dst_WDATA),
    .m_axi_dst_WSTRB(dataflow_in_loop_height_loop_U0_m_axi_dst_WSTRB),
    .m_axi_dst_WLAST(dataflow_in_loop_height_loop_U0_m_axi_dst_WLAST),
    .m_axi_dst_WID(dataflow_in_loop_height_loop_U0_m_axi_dst_WID),
    .m_axi_dst_WUSER(dataflow_in_loop_height_loop_U0_m_axi_dst_WUSER),
    .m_axi_dst_ARVALID(dataflow_in_loop_height_loop_U0_m_axi_dst_ARVALID),
    .m_axi_dst_ARREADY(dst_ARREADY),
    .m_axi_dst_ARADDR(dataflow_in_loop_height_loop_U0_m_axi_dst_ARADDR),
    .m_axi_dst_ARID(dataflow_in_loop_height_loop_U0_m_axi_dst_ARID),
    .m_axi_dst_ARLEN(dataflow_in_loop_height_loop_U0_m_axi_dst_ARLEN),
    .m_axi_dst_ARSIZE(dataflow_in_loop_height_loop_U0_m_axi_dst_ARSIZE),
    .m_axi_dst_ARBURST(dataflow_in_loop_height_loop_U0_m_axi_dst_ARBURST),
    .m_axi_dst_ARLOCK(dataflow_in_loop_height_loop_U0_m_axi_dst_ARLOCK),
    .m_axi_dst_ARCACHE(dataflow_in_loop_height_loop_U0_m_axi_dst_ARCACHE),
    .m_axi_dst_ARPROT(dataflow_in_loop_height_loop_U0_m_axi_dst_ARPROT),
    .m_axi_dst_ARQOS(dataflow_in_loop_height_loop_U0_m_axi_dst_ARQOS),
    .m_axi_dst_ARREGION(dataflow_in_loop_height_loop_U0_m_axi_dst_ARREGION),
    .m_axi_dst_ARUSER(dataflow_in_loop_height_loop_U0_m_axi_dst_ARUSER),
    .m_axi_dst_RVALID(dst_RVALID),
    .m_axi_dst_RREADY(dataflow_in_loop_height_loop_U0_m_axi_dst_RREADY),
    .m_axi_dst_RDATA(dst_RDATA),
    .m_axi_dst_RLAST(dst_RLAST),
    .m_axi_dst_RID(dst_RID),
    .m_axi_dst_RUSER(dst_RUSER),
    .m_axi_dst_RRESP(dst_RRESP),
    .m_axi_dst_BVALID(dst_BVALID),
    .m_axi_dst_BREADY(dataflow_in_loop_height_loop_U0_m_axi_dst_BREADY),
    .m_axi_dst_BRESP(dst_BRESP),
    .m_axi_dst_BID(dst_BID),
    .m_axi_dst_BUSER(dst_BUSER),
    .alpha(alpha),
    .dstout(dstout),
    .mapchip_draw_xsize_ap_vld(1'b1),
    .mapchip_maxwidth_ap_vld(1'b1),
    .d_ap_vld(1'b1),
    .a_ap_vld(1'b1),
    .c_ap_vld(1'b1),
    .b_ap_vld(1'b1),
    .m_ap_vld(1'b1),
    .trunc_ln69_ap_vld(1'b0),
    .mapchip_maxheight_ap_vld(1'b1),
    .n_ap_vld(1'b1),
    .id_ap_vld(1'b1),
    .ystart_pos_ap_vld(1'b1),
    .xstart_pos_ap_vld(1'b1),
    .srcin_ap_vld(1'b1),
    .frame_size_ap_vld(1'b1),
    .dstin_ap_vld(1'b1),
    .alpha_ap_vld(1'b1),
    .dstout_ap_vld(1'b1),
    .ap_start(dataflow_in_loop_height_loop_U0_ap_start),
    .ap_done(dataflow_in_loop_height_loop_U0_ap_done),
    .ap_ready(dataflow_in_loop_height_loop_U0_ap_ready),
    .ap_idle(dataflow_in_loop_height_loop_U0_ap_idle),
    .ap_continue(dataflow_in_loop_height_loop_U0_ap_continue)
);

always @ (posedge ap_clk) begin
    if (ap_rst_n_inv == 1'b1) begin
        loop_dataflow_input_count <= 32'd0;
    end else begin
        if ((~(loop_dataflow_input_count == bound_minus_1) & (ap_start == 1'b1) & (dataflow_in_loop_height_loop_U0_ap_ready == 1'b1))) begin
            loop_dataflow_input_count <= (loop_dataflow_input_count + 32'd1);
        end else if (((ap_start == 1'b1) & (loop_dataflow_input_count == bound_minus_1) & (dataflow_in_loop_height_loop_U0_ap_ready == 1'b1))) begin
            loop_dataflow_input_count <= 32'd0;
        end
    end
end

always @ (posedge ap_clk) begin
    if (ap_rst_n_inv == 1'b1) begin
        loop_dataflow_output_count <= 32'd0;
    end else begin
        if ((~(loop_dataflow_output_count == bound_minus_1) & (dataflow_in_loop_height_loop_U0_ap_continue == 1'b1) & (dataflow_in_loop_height_loop_U0_ap_done == 1'b1))) begin
            loop_dataflow_output_count <= (loop_dataflow_output_count + 32'd1);
        end else if (((loop_dataflow_output_count == bound_minus_1) & (dataflow_in_loop_height_loop_U0_ap_continue == 1'b1) & (dataflow_in_loop_height_loop_U0_ap_done == 1'b1))) begin
            loop_dataflow_output_count <= 32'd0;
        end
    end
end

always @ (*) begin
    if (((loop_dataflow_output_count == bound_minus_1) & (dataflow_in_loop_height_loop_U0_ap_done == 1'b1))) begin
        ap_done = 1'b1;
    end else begin
        ap_done = 1'b0;
    end
end

always @ (*) begin
    if (((ap_start == 1'b0) & (loop_dataflow_output_count == 32'd0) & (dataflow_in_loop_height_loop_U0_ap_idle == 1'b1))) begin
        ap_idle = 1'b1;
    end else begin
        ap_idle = 1'b0;
    end
end

always @ (*) begin
    if (((ap_start == 1'b1) & (loop_dataflow_input_count == bound_minus_1) & (dataflow_in_loop_height_loop_U0_ap_ready == 1'b1))) begin
        ap_ready = 1'b1;
    end else begin
        ap_ready = 1'b0;
    end
end

assign dataflow_in_loop_height_loop_U0_ap_continue = 1'b1;

always @ (*) begin
    ap_rst_n_inv = ~ap_rst_n;
end

assign ap_sync_continue = 1'b1;

assign ap_sync_done = dataflow_in_loop_height_loop_U0_ap_done;

assign ap_sync_ready = dataflow_in_loop_height_loop_U0_ap_ready;

assign bound_minus_1 = (mapchip_draw_ysize - 32'd1);

assign dataflow_in_loop_height_loop_U0_a = {{a[(20 - 32'd1):0]}};

assign dataflow_in_loop_height_loop_U0_ap_start = ap_start;

assign dataflow_in_loop_height_loop_U0_b = {{b[(20 - 32'd1):0]}};

assign dataflow_in_loop_height_loop_U0_c = {{c[(20 - 32'd1):0]}};

assign dataflow_in_loop_height_loop_U0_d = {{d[(20 - 32'd1):0]}};

assign dataflow_in_loop_height_loop_U0_start_full_n = 1'b1;

assign dataflow_in_loop_height_loop_U0_start_write = 1'b0;


// synthesis translate_off
`include "affine_scale_hls_deadlock_detector.vh"
// synthesis translate_on

endmodule //affine_scale

