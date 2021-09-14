// ==============================================================
// RTL generated by Vitis HLS - High-Level Synthesis from C, C++ and OpenCL v2020.2 (64-bit)
// Version: 2020.2
// Copyright (C) Copyright 1986-2020 Xilinx, Inc. All Rights Reserved.
// 
// ===========================================================

`timescale 1 ns / 1 ps 

module mapchip_png_dataflow_in_loop_height_loop_entry6 (
        ap_clk,
        ap_rst,
        ap_start,
        ap_done,
        ap_continue,
        ap_idle,
        ap_ready,
        mapchip_draw_xsize,
        id,
        mapchip_maxheight,
        ystart_pos,
        mapchip_maxwidth,
        xstart_pos,
        y,
        srcin,
        frame_size,
        dstin,
        alpha,
        dstout,
        mapchip_draw_xsize_out_din,
        mapchip_draw_xsize_out_full_n,
        mapchip_draw_xsize_out_write,
        mapchip_draw_xsize_out1_din,
        mapchip_draw_xsize_out1_full_n,
        mapchip_draw_xsize_out1_write,
        id_out_din,
        id_out_full_n,
        id_out_write,
        mapchip_maxheight_out_din,
        mapchip_maxheight_out_full_n,
        mapchip_maxheight_out_write,
        ystart_pos_out_din,
        ystart_pos_out_full_n,
        ystart_pos_out_write,
        mapchip_maxwidth_out_din,
        mapchip_maxwidth_out_full_n,
        mapchip_maxwidth_out_write,
        xstart_pos_out_din,
        xstart_pos_out_full_n,
        xstart_pos_out_write,
        y_out_din,
        y_out_full_n,
        y_out_write,
        y_out2_din,
        y_out2_full_n,
        y_out2_write,
        srcin_out_din,
        srcin_out_full_n,
        srcin_out_write,
        frame_size_out_din,
        frame_size_out_full_n,
        frame_size_out_write,
        frame_size_out3_din,
        frame_size_out3_full_n,
        frame_size_out3_write,
        dstin_out_din,
        dstin_out_full_n,
        dstin_out_write,
        alpha_out_din,
        alpha_out_full_n,
        alpha_out_write,
        dstout_out_din,
        dstout_out_full_n,
        dstout_out_write
);

parameter    ap_ST_fsm_state1 = 1'd1;

input   ap_clk;
input   ap_rst;
input   ap_start;
output   ap_done;
input   ap_continue;
output   ap_idle;
output   ap_ready;
input  [31:0] mapchip_draw_xsize;
input  [31:0] id;
input  [31:0] mapchip_maxheight;
input  [31:0] ystart_pos;
input  [31:0] mapchip_maxwidth;
input  [31:0] xstart_pos;
input  [31:0] y;
input  [63:0] srcin;
input  [31:0] frame_size;
input  [63:0] dstin;
input  [7:0] alpha;
input  [63:0] dstout;
output  [31:0] mapchip_draw_xsize_out_din;
input   mapchip_draw_xsize_out_full_n;
output   mapchip_draw_xsize_out_write;
output  [31:0] mapchip_draw_xsize_out1_din;
input   mapchip_draw_xsize_out1_full_n;
output   mapchip_draw_xsize_out1_write;
output  [31:0] id_out_din;
input   id_out_full_n;
output   id_out_write;
output  [31:0] mapchip_maxheight_out_din;
input   mapchip_maxheight_out_full_n;
output   mapchip_maxheight_out_write;
output  [31:0] ystart_pos_out_din;
input   ystart_pos_out_full_n;
output   ystart_pos_out_write;
output  [31:0] mapchip_maxwidth_out_din;
input   mapchip_maxwidth_out_full_n;
output   mapchip_maxwidth_out_write;
output  [31:0] xstart_pos_out_din;
input   xstart_pos_out_full_n;
output   xstart_pos_out_write;
output  [31:0] y_out_din;
input   y_out_full_n;
output   y_out_write;
output  [31:0] y_out2_din;
input   y_out2_full_n;
output   y_out2_write;
output  [63:0] srcin_out_din;
input   srcin_out_full_n;
output   srcin_out_write;
output  [31:0] frame_size_out_din;
input   frame_size_out_full_n;
output   frame_size_out_write;
output  [31:0] frame_size_out3_din;
input   frame_size_out3_full_n;
output   frame_size_out3_write;
output  [63:0] dstin_out_din;
input   dstin_out_full_n;
output   dstin_out_write;
output  [7:0] alpha_out_din;
input   alpha_out_full_n;
output   alpha_out_write;
output  [63:0] dstout_out_din;
input   dstout_out_full_n;
output   dstout_out_write;

reg ap_done;
reg ap_idle;
reg ap_ready;
reg mapchip_draw_xsize_out_write;
reg mapchip_draw_xsize_out1_write;
reg id_out_write;
reg mapchip_maxheight_out_write;
reg ystart_pos_out_write;
reg mapchip_maxwidth_out_write;
reg xstart_pos_out_write;
reg y_out_write;
reg y_out2_write;
reg srcin_out_write;
reg frame_size_out_write;
reg frame_size_out3_write;
reg dstin_out_write;
reg alpha_out_write;
reg dstout_out_write;

reg    ap_done_reg;
(* fsm_encoding = "none" *) reg   [0:0] ap_CS_fsm;
wire    ap_CS_fsm_state1;
reg    mapchip_draw_xsize_out_blk_n;
reg    mapchip_draw_xsize_out1_blk_n;
reg    id_out_blk_n;
reg    mapchip_maxheight_out_blk_n;
reg    ystart_pos_out_blk_n;
reg    mapchip_maxwidth_out_blk_n;
reg    xstart_pos_out_blk_n;
reg    y_out_blk_n;
reg    y_out2_blk_n;
reg    srcin_out_blk_n;
reg    frame_size_out_blk_n;
reg    frame_size_out3_blk_n;
reg    dstin_out_blk_n;
reg    alpha_out_blk_n;
reg    dstout_out_blk_n;
reg    ap_block_state1;
reg   [0:0] ap_NS_fsm;
wire    ap_ce_reg;

// power-on initialization
initial begin
#0 ap_done_reg = 1'b0;
#0 ap_CS_fsm = 1'd1;
end

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
        end else if ((~((dstout_out_full_n == 1'b0) | (dstin_out_full_n == 1'b0) | (frame_size_out3_full_n == 1'b0) | (frame_size_out_full_n == 1'b0) | (srcin_out_full_n == 1'b0) | (ap_start == 1'b0) | (y_out2_full_n == 1'b0) | (y_out_full_n == 1'b0) | (xstart_pos_out_full_n == 1'b0) | (mapchip_maxwidth_out_full_n == 1'b0) | (ystart_pos_out_full_n == 1'b0) | (mapchip_maxheight_out_full_n == 1'b0) | (id_out_full_n == 1'b0) | (mapchip_draw_xsize_out1_full_n == 1'b0) | (mapchip_draw_xsize_out_full_n == 1'b0) | (1'b0 == alpha_out_full_n) | (ap_done_reg == 1'b1)) & (1'b1 == ap_CS_fsm_state1))) begin
            ap_done_reg <= 1'b1;
        end
    end
end

always @ (*) begin
    if ((~((ap_start == 1'b0) | (ap_done_reg == 1'b1)) & (1'b1 == ap_CS_fsm_state1))) begin
        alpha_out_blk_n = alpha_out_full_n;
    end else begin
        alpha_out_blk_n = 1'b1;
    end
end

always @ (*) begin
    if ((~((dstout_out_full_n == 1'b0) | (dstin_out_full_n == 1'b0) | (frame_size_out3_full_n == 1'b0) | (frame_size_out_full_n == 1'b0) | (srcin_out_full_n == 1'b0) | (ap_start == 1'b0) | (y_out2_full_n == 1'b0) | (y_out_full_n == 1'b0) | (xstart_pos_out_full_n == 1'b0) | (mapchip_maxwidth_out_full_n == 1'b0) | (ystart_pos_out_full_n == 1'b0) | (mapchip_maxheight_out_full_n == 1'b0) | (id_out_full_n == 1'b0) | (mapchip_draw_xsize_out1_full_n == 1'b0) | (mapchip_draw_xsize_out_full_n == 1'b0) | (1'b0 == alpha_out_full_n) | (ap_done_reg == 1'b1)) & (1'b1 == ap_CS_fsm_state1))) begin
        alpha_out_write = 1'b1;
    end else begin
        alpha_out_write = 1'b0;
    end
end

always @ (*) begin
    if ((~((dstout_out_full_n == 1'b0) | (dstin_out_full_n == 1'b0) | (frame_size_out3_full_n == 1'b0) | (frame_size_out_full_n == 1'b0) | (srcin_out_full_n == 1'b0) | (ap_start == 1'b0) | (y_out2_full_n == 1'b0) | (y_out_full_n == 1'b0) | (xstart_pos_out_full_n == 1'b0) | (mapchip_maxwidth_out_full_n == 1'b0) | (ystart_pos_out_full_n == 1'b0) | (mapchip_maxheight_out_full_n == 1'b0) | (id_out_full_n == 1'b0) | (mapchip_draw_xsize_out1_full_n == 1'b0) | (mapchip_draw_xsize_out_full_n == 1'b0) | (1'b0 == alpha_out_full_n) | (ap_done_reg == 1'b1)) & (1'b1 == ap_CS_fsm_state1))) begin
        ap_done = 1'b1;
    end else begin
        ap_done = ap_done_reg;
    end
end

always @ (*) begin
    if (((ap_start == 1'b0) & (1'b1 == ap_CS_fsm_state1))) begin
        ap_idle = 1'b1;
    end else begin
        ap_idle = 1'b0;
    end
end

always @ (*) begin
    if ((~((dstout_out_full_n == 1'b0) | (dstin_out_full_n == 1'b0) | (frame_size_out3_full_n == 1'b0) | (frame_size_out_full_n == 1'b0) | (srcin_out_full_n == 1'b0) | (ap_start == 1'b0) | (y_out2_full_n == 1'b0) | (y_out_full_n == 1'b0) | (xstart_pos_out_full_n == 1'b0) | (mapchip_maxwidth_out_full_n == 1'b0) | (ystart_pos_out_full_n == 1'b0) | (mapchip_maxheight_out_full_n == 1'b0) | (id_out_full_n == 1'b0) | (mapchip_draw_xsize_out1_full_n == 1'b0) | (mapchip_draw_xsize_out_full_n == 1'b0) | (1'b0 == alpha_out_full_n) | (ap_done_reg == 1'b1)) & (1'b1 == ap_CS_fsm_state1))) begin
        ap_ready = 1'b1;
    end else begin
        ap_ready = 1'b0;
    end
end

always @ (*) begin
    if ((~((ap_start == 1'b0) | (ap_done_reg == 1'b1)) & (1'b1 == ap_CS_fsm_state1))) begin
        dstin_out_blk_n = dstin_out_full_n;
    end else begin
        dstin_out_blk_n = 1'b1;
    end
end

always @ (*) begin
    if ((~((dstout_out_full_n == 1'b0) | (dstin_out_full_n == 1'b0) | (frame_size_out3_full_n == 1'b0) | (frame_size_out_full_n == 1'b0) | (srcin_out_full_n == 1'b0) | (ap_start == 1'b0) | (y_out2_full_n == 1'b0) | (y_out_full_n == 1'b0) | (xstart_pos_out_full_n == 1'b0) | (mapchip_maxwidth_out_full_n == 1'b0) | (ystart_pos_out_full_n == 1'b0) | (mapchip_maxheight_out_full_n == 1'b0) | (id_out_full_n == 1'b0) | (mapchip_draw_xsize_out1_full_n == 1'b0) | (mapchip_draw_xsize_out_full_n == 1'b0) | (1'b0 == alpha_out_full_n) | (ap_done_reg == 1'b1)) & (1'b1 == ap_CS_fsm_state1))) begin
        dstin_out_write = 1'b1;
    end else begin
        dstin_out_write = 1'b0;
    end
end

always @ (*) begin
    if ((~((ap_start == 1'b0) | (ap_done_reg == 1'b1)) & (1'b1 == ap_CS_fsm_state1))) begin
        dstout_out_blk_n = dstout_out_full_n;
    end else begin
        dstout_out_blk_n = 1'b1;
    end
end

always @ (*) begin
    if ((~((dstout_out_full_n == 1'b0) | (dstin_out_full_n == 1'b0) | (frame_size_out3_full_n == 1'b0) | (frame_size_out_full_n == 1'b0) | (srcin_out_full_n == 1'b0) | (ap_start == 1'b0) | (y_out2_full_n == 1'b0) | (y_out_full_n == 1'b0) | (xstart_pos_out_full_n == 1'b0) | (mapchip_maxwidth_out_full_n == 1'b0) | (ystart_pos_out_full_n == 1'b0) | (mapchip_maxheight_out_full_n == 1'b0) | (id_out_full_n == 1'b0) | (mapchip_draw_xsize_out1_full_n == 1'b0) | (mapchip_draw_xsize_out_full_n == 1'b0) | (1'b0 == alpha_out_full_n) | (ap_done_reg == 1'b1)) & (1'b1 == ap_CS_fsm_state1))) begin
        dstout_out_write = 1'b1;
    end else begin
        dstout_out_write = 1'b0;
    end
end

always @ (*) begin
    if ((~((ap_start == 1'b0) | (ap_done_reg == 1'b1)) & (1'b1 == ap_CS_fsm_state1))) begin
        frame_size_out3_blk_n = frame_size_out3_full_n;
    end else begin
        frame_size_out3_blk_n = 1'b1;
    end
end

always @ (*) begin
    if ((~((dstout_out_full_n == 1'b0) | (dstin_out_full_n == 1'b0) | (frame_size_out3_full_n == 1'b0) | (frame_size_out_full_n == 1'b0) | (srcin_out_full_n == 1'b0) | (ap_start == 1'b0) | (y_out2_full_n == 1'b0) | (y_out_full_n == 1'b0) | (xstart_pos_out_full_n == 1'b0) | (mapchip_maxwidth_out_full_n == 1'b0) | (ystart_pos_out_full_n == 1'b0) | (mapchip_maxheight_out_full_n == 1'b0) | (id_out_full_n == 1'b0) | (mapchip_draw_xsize_out1_full_n == 1'b0) | (mapchip_draw_xsize_out_full_n == 1'b0) | (1'b0 == alpha_out_full_n) | (ap_done_reg == 1'b1)) & (1'b1 == ap_CS_fsm_state1))) begin
        frame_size_out3_write = 1'b1;
    end else begin
        frame_size_out3_write = 1'b0;
    end
end

always @ (*) begin
    if ((~((ap_start == 1'b0) | (ap_done_reg == 1'b1)) & (1'b1 == ap_CS_fsm_state1))) begin
        frame_size_out_blk_n = frame_size_out_full_n;
    end else begin
        frame_size_out_blk_n = 1'b1;
    end
end

always @ (*) begin
    if ((~((dstout_out_full_n == 1'b0) | (dstin_out_full_n == 1'b0) | (frame_size_out3_full_n == 1'b0) | (frame_size_out_full_n == 1'b0) | (srcin_out_full_n == 1'b0) | (ap_start == 1'b0) | (y_out2_full_n == 1'b0) | (y_out_full_n == 1'b0) | (xstart_pos_out_full_n == 1'b0) | (mapchip_maxwidth_out_full_n == 1'b0) | (ystart_pos_out_full_n == 1'b0) | (mapchip_maxheight_out_full_n == 1'b0) | (id_out_full_n == 1'b0) | (mapchip_draw_xsize_out1_full_n == 1'b0) | (mapchip_draw_xsize_out_full_n == 1'b0) | (1'b0 == alpha_out_full_n) | (ap_done_reg == 1'b1)) & (1'b1 == ap_CS_fsm_state1))) begin
        frame_size_out_write = 1'b1;
    end else begin
        frame_size_out_write = 1'b0;
    end
end

always @ (*) begin
    if ((~((ap_start == 1'b0) | (ap_done_reg == 1'b1)) & (1'b1 == ap_CS_fsm_state1))) begin
        id_out_blk_n = id_out_full_n;
    end else begin
        id_out_blk_n = 1'b1;
    end
end

always @ (*) begin
    if ((~((dstout_out_full_n == 1'b0) | (dstin_out_full_n == 1'b0) | (frame_size_out3_full_n == 1'b0) | (frame_size_out_full_n == 1'b0) | (srcin_out_full_n == 1'b0) | (ap_start == 1'b0) | (y_out2_full_n == 1'b0) | (y_out_full_n == 1'b0) | (xstart_pos_out_full_n == 1'b0) | (mapchip_maxwidth_out_full_n == 1'b0) | (ystart_pos_out_full_n == 1'b0) | (mapchip_maxheight_out_full_n == 1'b0) | (id_out_full_n == 1'b0) | (mapchip_draw_xsize_out1_full_n == 1'b0) | (mapchip_draw_xsize_out_full_n == 1'b0) | (1'b0 == alpha_out_full_n) | (ap_done_reg == 1'b1)) & (1'b1 == ap_CS_fsm_state1))) begin
        id_out_write = 1'b1;
    end else begin
        id_out_write = 1'b0;
    end
end

always @ (*) begin
    if ((~((ap_start == 1'b0) | (ap_done_reg == 1'b1)) & (1'b1 == ap_CS_fsm_state1))) begin
        mapchip_draw_xsize_out1_blk_n = mapchip_draw_xsize_out1_full_n;
    end else begin
        mapchip_draw_xsize_out1_blk_n = 1'b1;
    end
end

always @ (*) begin
    if ((~((dstout_out_full_n == 1'b0) | (dstin_out_full_n == 1'b0) | (frame_size_out3_full_n == 1'b0) | (frame_size_out_full_n == 1'b0) | (srcin_out_full_n == 1'b0) | (ap_start == 1'b0) | (y_out2_full_n == 1'b0) | (y_out_full_n == 1'b0) | (xstart_pos_out_full_n == 1'b0) | (mapchip_maxwidth_out_full_n == 1'b0) | (ystart_pos_out_full_n == 1'b0) | (mapchip_maxheight_out_full_n == 1'b0) | (id_out_full_n == 1'b0) | (mapchip_draw_xsize_out1_full_n == 1'b0) | (mapchip_draw_xsize_out_full_n == 1'b0) | (1'b0 == alpha_out_full_n) | (ap_done_reg == 1'b1)) & (1'b1 == ap_CS_fsm_state1))) begin
        mapchip_draw_xsize_out1_write = 1'b1;
    end else begin
        mapchip_draw_xsize_out1_write = 1'b0;
    end
end

always @ (*) begin
    if ((~((ap_start == 1'b0) | (ap_done_reg == 1'b1)) & (1'b1 == ap_CS_fsm_state1))) begin
        mapchip_draw_xsize_out_blk_n = mapchip_draw_xsize_out_full_n;
    end else begin
        mapchip_draw_xsize_out_blk_n = 1'b1;
    end
end

always @ (*) begin
    if ((~((dstout_out_full_n == 1'b0) | (dstin_out_full_n == 1'b0) | (frame_size_out3_full_n == 1'b0) | (frame_size_out_full_n == 1'b0) | (srcin_out_full_n == 1'b0) | (ap_start == 1'b0) | (y_out2_full_n == 1'b0) | (y_out_full_n == 1'b0) | (xstart_pos_out_full_n == 1'b0) | (mapchip_maxwidth_out_full_n == 1'b0) | (ystart_pos_out_full_n == 1'b0) | (mapchip_maxheight_out_full_n == 1'b0) | (id_out_full_n == 1'b0) | (mapchip_draw_xsize_out1_full_n == 1'b0) | (mapchip_draw_xsize_out_full_n == 1'b0) | (1'b0 == alpha_out_full_n) | (ap_done_reg == 1'b1)) & (1'b1 == ap_CS_fsm_state1))) begin
        mapchip_draw_xsize_out_write = 1'b1;
    end else begin
        mapchip_draw_xsize_out_write = 1'b0;
    end
end

always @ (*) begin
    if ((~((ap_start == 1'b0) | (ap_done_reg == 1'b1)) & (1'b1 == ap_CS_fsm_state1))) begin
        mapchip_maxheight_out_blk_n = mapchip_maxheight_out_full_n;
    end else begin
        mapchip_maxheight_out_blk_n = 1'b1;
    end
end

always @ (*) begin
    if ((~((dstout_out_full_n == 1'b0) | (dstin_out_full_n == 1'b0) | (frame_size_out3_full_n == 1'b0) | (frame_size_out_full_n == 1'b0) | (srcin_out_full_n == 1'b0) | (ap_start == 1'b0) | (y_out2_full_n == 1'b0) | (y_out_full_n == 1'b0) | (xstart_pos_out_full_n == 1'b0) | (mapchip_maxwidth_out_full_n == 1'b0) | (ystart_pos_out_full_n == 1'b0) | (mapchip_maxheight_out_full_n == 1'b0) | (id_out_full_n == 1'b0) | (mapchip_draw_xsize_out1_full_n == 1'b0) | (mapchip_draw_xsize_out_full_n == 1'b0) | (1'b0 == alpha_out_full_n) | (ap_done_reg == 1'b1)) & (1'b1 == ap_CS_fsm_state1))) begin
        mapchip_maxheight_out_write = 1'b1;
    end else begin
        mapchip_maxheight_out_write = 1'b0;
    end
end

always @ (*) begin
    if ((~((ap_start == 1'b0) | (ap_done_reg == 1'b1)) & (1'b1 == ap_CS_fsm_state1))) begin
        mapchip_maxwidth_out_blk_n = mapchip_maxwidth_out_full_n;
    end else begin
        mapchip_maxwidth_out_blk_n = 1'b1;
    end
end

always @ (*) begin
    if ((~((dstout_out_full_n == 1'b0) | (dstin_out_full_n == 1'b0) | (frame_size_out3_full_n == 1'b0) | (frame_size_out_full_n == 1'b0) | (srcin_out_full_n == 1'b0) | (ap_start == 1'b0) | (y_out2_full_n == 1'b0) | (y_out_full_n == 1'b0) | (xstart_pos_out_full_n == 1'b0) | (mapchip_maxwidth_out_full_n == 1'b0) | (ystart_pos_out_full_n == 1'b0) | (mapchip_maxheight_out_full_n == 1'b0) | (id_out_full_n == 1'b0) | (mapchip_draw_xsize_out1_full_n == 1'b0) | (mapchip_draw_xsize_out_full_n == 1'b0) | (1'b0 == alpha_out_full_n) | (ap_done_reg == 1'b1)) & (1'b1 == ap_CS_fsm_state1))) begin
        mapchip_maxwidth_out_write = 1'b1;
    end else begin
        mapchip_maxwidth_out_write = 1'b0;
    end
end

always @ (*) begin
    if ((~((ap_start == 1'b0) | (ap_done_reg == 1'b1)) & (1'b1 == ap_CS_fsm_state1))) begin
        srcin_out_blk_n = srcin_out_full_n;
    end else begin
        srcin_out_blk_n = 1'b1;
    end
end

always @ (*) begin
    if ((~((dstout_out_full_n == 1'b0) | (dstin_out_full_n == 1'b0) | (frame_size_out3_full_n == 1'b0) | (frame_size_out_full_n == 1'b0) | (srcin_out_full_n == 1'b0) | (ap_start == 1'b0) | (y_out2_full_n == 1'b0) | (y_out_full_n == 1'b0) | (xstart_pos_out_full_n == 1'b0) | (mapchip_maxwidth_out_full_n == 1'b0) | (ystart_pos_out_full_n == 1'b0) | (mapchip_maxheight_out_full_n == 1'b0) | (id_out_full_n == 1'b0) | (mapchip_draw_xsize_out1_full_n == 1'b0) | (mapchip_draw_xsize_out_full_n == 1'b0) | (1'b0 == alpha_out_full_n) | (ap_done_reg == 1'b1)) & (1'b1 == ap_CS_fsm_state1))) begin
        srcin_out_write = 1'b1;
    end else begin
        srcin_out_write = 1'b0;
    end
end

always @ (*) begin
    if ((~((ap_start == 1'b0) | (ap_done_reg == 1'b1)) & (1'b1 == ap_CS_fsm_state1))) begin
        xstart_pos_out_blk_n = xstart_pos_out_full_n;
    end else begin
        xstart_pos_out_blk_n = 1'b1;
    end
end

always @ (*) begin
    if ((~((dstout_out_full_n == 1'b0) | (dstin_out_full_n == 1'b0) | (frame_size_out3_full_n == 1'b0) | (frame_size_out_full_n == 1'b0) | (srcin_out_full_n == 1'b0) | (ap_start == 1'b0) | (y_out2_full_n == 1'b0) | (y_out_full_n == 1'b0) | (xstart_pos_out_full_n == 1'b0) | (mapchip_maxwidth_out_full_n == 1'b0) | (ystart_pos_out_full_n == 1'b0) | (mapchip_maxheight_out_full_n == 1'b0) | (id_out_full_n == 1'b0) | (mapchip_draw_xsize_out1_full_n == 1'b0) | (mapchip_draw_xsize_out_full_n == 1'b0) | (1'b0 == alpha_out_full_n) | (ap_done_reg == 1'b1)) & (1'b1 == ap_CS_fsm_state1))) begin
        xstart_pos_out_write = 1'b1;
    end else begin
        xstart_pos_out_write = 1'b0;
    end
end

always @ (*) begin
    if ((~((ap_start == 1'b0) | (ap_done_reg == 1'b1)) & (1'b1 == ap_CS_fsm_state1))) begin
        y_out2_blk_n = y_out2_full_n;
    end else begin
        y_out2_blk_n = 1'b1;
    end
end

always @ (*) begin
    if ((~((dstout_out_full_n == 1'b0) | (dstin_out_full_n == 1'b0) | (frame_size_out3_full_n == 1'b0) | (frame_size_out_full_n == 1'b0) | (srcin_out_full_n == 1'b0) | (ap_start == 1'b0) | (y_out2_full_n == 1'b0) | (y_out_full_n == 1'b0) | (xstart_pos_out_full_n == 1'b0) | (mapchip_maxwidth_out_full_n == 1'b0) | (ystart_pos_out_full_n == 1'b0) | (mapchip_maxheight_out_full_n == 1'b0) | (id_out_full_n == 1'b0) | (mapchip_draw_xsize_out1_full_n == 1'b0) | (mapchip_draw_xsize_out_full_n == 1'b0) | (1'b0 == alpha_out_full_n) | (ap_done_reg == 1'b1)) & (1'b1 == ap_CS_fsm_state1))) begin
        y_out2_write = 1'b1;
    end else begin
        y_out2_write = 1'b0;
    end
end

always @ (*) begin
    if ((~((ap_start == 1'b0) | (ap_done_reg == 1'b1)) & (1'b1 == ap_CS_fsm_state1))) begin
        y_out_blk_n = y_out_full_n;
    end else begin
        y_out_blk_n = 1'b1;
    end
end

always @ (*) begin
    if ((~((dstout_out_full_n == 1'b0) | (dstin_out_full_n == 1'b0) | (frame_size_out3_full_n == 1'b0) | (frame_size_out_full_n == 1'b0) | (srcin_out_full_n == 1'b0) | (ap_start == 1'b0) | (y_out2_full_n == 1'b0) | (y_out_full_n == 1'b0) | (xstart_pos_out_full_n == 1'b0) | (mapchip_maxwidth_out_full_n == 1'b0) | (ystart_pos_out_full_n == 1'b0) | (mapchip_maxheight_out_full_n == 1'b0) | (id_out_full_n == 1'b0) | (mapchip_draw_xsize_out1_full_n == 1'b0) | (mapchip_draw_xsize_out_full_n == 1'b0) | (1'b0 == alpha_out_full_n) | (ap_done_reg == 1'b1)) & (1'b1 == ap_CS_fsm_state1))) begin
        y_out_write = 1'b1;
    end else begin
        y_out_write = 1'b0;
    end
end

always @ (*) begin
    if ((~((ap_start == 1'b0) | (ap_done_reg == 1'b1)) & (1'b1 == ap_CS_fsm_state1))) begin
        ystart_pos_out_blk_n = ystart_pos_out_full_n;
    end else begin
        ystart_pos_out_blk_n = 1'b1;
    end
end

always @ (*) begin
    if ((~((dstout_out_full_n == 1'b0) | (dstin_out_full_n == 1'b0) | (frame_size_out3_full_n == 1'b0) | (frame_size_out_full_n == 1'b0) | (srcin_out_full_n == 1'b0) | (ap_start == 1'b0) | (y_out2_full_n == 1'b0) | (y_out_full_n == 1'b0) | (xstart_pos_out_full_n == 1'b0) | (mapchip_maxwidth_out_full_n == 1'b0) | (ystart_pos_out_full_n == 1'b0) | (mapchip_maxheight_out_full_n == 1'b0) | (id_out_full_n == 1'b0) | (mapchip_draw_xsize_out1_full_n == 1'b0) | (mapchip_draw_xsize_out_full_n == 1'b0) | (1'b0 == alpha_out_full_n) | (ap_done_reg == 1'b1)) & (1'b1 == ap_CS_fsm_state1))) begin
        ystart_pos_out_write = 1'b1;
    end else begin
        ystart_pos_out_write = 1'b0;
    end
end

always @ (*) begin
    case (ap_CS_fsm)
        ap_ST_fsm_state1 : begin
            ap_NS_fsm = ap_ST_fsm_state1;
        end
        default : begin
            ap_NS_fsm = 'bx;
        end
    endcase
end

assign alpha_out_din = alpha;

assign ap_CS_fsm_state1 = ap_CS_fsm[32'd0];

always @ (*) begin
    ap_block_state1 = ((dstout_out_full_n == 1'b0) | (dstin_out_full_n == 1'b0) | (frame_size_out3_full_n == 1'b0) | (frame_size_out_full_n == 1'b0) | (srcin_out_full_n == 1'b0) | (ap_start == 1'b0) | (y_out2_full_n == 1'b0) | (y_out_full_n == 1'b0) | (xstart_pos_out_full_n == 1'b0) | (mapchip_maxwidth_out_full_n == 1'b0) | (ystart_pos_out_full_n == 1'b0) | (mapchip_maxheight_out_full_n == 1'b0) | (id_out_full_n == 1'b0) | (mapchip_draw_xsize_out1_full_n == 1'b0) | (mapchip_draw_xsize_out_full_n == 1'b0) | (1'b0 == alpha_out_full_n) | (ap_done_reg == 1'b1));
end

assign dstin_out_din = dstin;

assign dstout_out_din = dstout;

assign frame_size_out3_din = frame_size;

assign frame_size_out_din = frame_size;

assign id_out_din = id;

assign mapchip_draw_xsize_out1_din = mapchip_draw_xsize;

assign mapchip_draw_xsize_out_din = mapchip_draw_xsize;

assign mapchip_maxheight_out_din = mapchip_maxheight;

assign mapchip_maxwidth_out_din = mapchip_maxwidth;

assign srcin_out_din = srcin;

assign xstart_pos_out_din = xstart_pos;

assign y_out2_din = y;

assign y_out_din = y;

assign ystart_pos_out_din = ystart_pos;

endmodule //mapchip_png_dataflow_in_loop_height_loop_entry6
