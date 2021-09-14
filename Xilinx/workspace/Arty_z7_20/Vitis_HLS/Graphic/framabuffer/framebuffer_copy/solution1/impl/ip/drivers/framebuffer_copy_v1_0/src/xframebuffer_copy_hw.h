// ==============================================================
// Vitis HLS - High-Level Synthesis from C, C++ and OpenCL v2020.2 (64-bit)
// Copyright 1986-2020 Xilinx, Inc. All Rights Reserved.
// ==============================================================
// control
// 0x00 : Control signals
//        bit 0  - ap_start (Read/Write/COH)
//        bit 1  - ap_done (Read/COR)
//        bit 2  - ap_idle (Read)
//        bit 3  - ap_ready (Read)
//        bit 7  - auto_restart (Read/Write)
//        others - reserved
// 0x04 : Global Interrupt Enable Register
//        bit 0  - Global Interrupt Enable (Read/Write)
//        others - reserved
// 0x08 : IP Interrupt Enable Register (Read/Write)
//        bit 0  - enable ap_done interrupt (Read/Write)
//        bit 1  - enable ap_ready interrupt (Read/Write)
//        others - reserved
// 0x0c : IP Interrupt Status Register (Read/TOW)
//        bit 0  - ap_done (COR/TOW)
//        bit 1  - ap_ready (COR/TOW)
//        others - reserved
// 0x10 : Data signal of copy
//        bit 31~0 - copy[31:0] (Read/Write)
// 0x14 : Data signal of copy
//        bit 31~0 - copy[63:32] (Read/Write)
// 0x18 : reserved
// 0x1c : Data signal of update
//        bit 31~0 - update[31:0] (Read/Write)
// 0x20 : Data signal of update
//        bit 31~0 - update[63:32] (Read/Write)
// 0x24 : reserved
// 0x28 : Data signal of width
//        bit 31~0 - width[31:0] (Read/Write)
// 0x2c : reserved
// 0x30 : Data signal of height
//        bit 31~0 - height[31:0] (Read/Write)
// 0x34 : reserved
// 0x38 : Data signal of display_xsize
//        bit 31~0 - display_xsize[31:0] (Read/Write)
// 0x3c : reserved
// (SC = Self Clear, COR = Clear on Read, TOW = Toggle on Write, COH = Clear on Handshake)

#define XFRAMEBUFFER_COPY_CONTROL_ADDR_AP_CTRL            0x00
#define XFRAMEBUFFER_COPY_CONTROL_ADDR_GIE                0x04
#define XFRAMEBUFFER_COPY_CONTROL_ADDR_IER                0x08
#define XFRAMEBUFFER_COPY_CONTROL_ADDR_ISR                0x0c
#define XFRAMEBUFFER_COPY_CONTROL_ADDR_COPY_DATA          0x10
#define XFRAMEBUFFER_COPY_CONTROL_BITS_COPY_DATA          64
#define XFRAMEBUFFER_COPY_CONTROL_ADDR_UPDATE_DATA        0x1c
#define XFRAMEBUFFER_COPY_CONTROL_BITS_UPDATE_DATA        64
#define XFRAMEBUFFER_COPY_CONTROL_ADDR_WIDTH_DATA         0x28
#define XFRAMEBUFFER_COPY_CONTROL_BITS_WIDTH_DATA         32
#define XFRAMEBUFFER_COPY_CONTROL_ADDR_HEIGHT_DATA        0x30
#define XFRAMEBUFFER_COPY_CONTROL_BITS_HEIGHT_DATA        32
#define XFRAMEBUFFER_COPY_CONTROL_ADDR_DISPLAY_XSIZE_DATA 0x38
#define XFRAMEBUFFER_COPY_CONTROL_BITS_DISPLAY_XSIZE_DATA 32

