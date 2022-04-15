//----------------------------------------------------------
// Create 2022/4/13
// Author koutakimura
// Editor VSCode ver1.62.7
// Build  Vivado20.2
// Board  My Board Spartan7 FTGB196
// -
// デバッグを除いて外部から信号を受信、又は外部に信号を送信するモジュールは Top に記述
// FPGA 内部で完結するモジュールは Base に記述
// 
//----------------------------------------------------------
module CaptiveShizuhaTop #(
    parameter       pHdisplay       = 640,
    parameter       pHback          =  48,
    parameter       pHfront         =  16,
    parameter       pHsync          =  96,
    parameter       pVdisplay       = 480,
    parameter       pVtop           =  31,
    parameter       pVbottom        =  11,
    parameter       pVsync          =   2,
    parameter       pPixelDebug     = "off",
    parameter       pBuffDepth      = 1024
)(
    input           iClk,           // OSC  clk
    input           iUartRx,        // Uart Debug Pin
    output          oUartTx,        // Uart Debug Pin
    output [1:0]    oApdsScl,       // APDS I2C SCL
    inout  [1:0]    ioApdsSda,      // APDS I2C SDA
    output [1:0]    oQspiSck,       // Qspi Flash Memory Clk
    output [1:0]    oQspiMosi,      // Qspi Flash Memory Master Data output
    input  [1:0]    iQspiMiso,      // Qspi Flash Memory Master Data input
    output [1:0]    oQspiCs,        // Qspi Flash Memory chip select
    output          oHdmiClkNeg,    // hdmi clk negedge
    output          oHdmiClkPos,    // hdmi clk posedge
    output [2:0]    oHdmiDataPos,   // TMDS Channel Serial Data posedge
    output [2:0]    oHdmiDataNeg,   // TMDS Channel Serial Data negedge
    output          oHdmiScl,       // hdmi I2c scl
    inout           ioHdmiSda,      // hdmi I2c sda
    inout           ioHdmiCec,      // hdmi cec
    input           iHdmiHpd        // hdmi hpd
);


//---------------------------------------------------------------------------
// 未使用 Pin 割り当て
//---------------------------------------------------------------------------
wire [6:0] unUsed;
wire unUsed[0] = iQspiMiso[0];
wire unUsed[1] = iQspiMiso[1];
wire unUsed[2] = ioApdsSda[0];
wire unUsed[3] = ioApdsSda[1];
wire unUsed[4] = iHdmiHpd;
wire unUsed[5] = ioHdmiSda;
wire unUsed[6] = ioHdmiCec;

assign oUartTx      = iUartRx;
assign oApdsScl     = 2'b11;
assign ioApdsSda    = 2'bzz;
assign oQspiSck     = 2'b00;
assign oQspiMosi    = 2'b00;
assign oQspiCs      = 2'b11;
assign oHdmiScl     = 1'b1;
assign ioHdmiSda    = 1'bz;
assign ioHdmiCec    = 1'bz;


//----------------------------------------------------------
// System Reset Gen
//----------------------------------------------------------
wire wSysRst;

rstGen #(
    .pRstFallTime (100)
) SYSTEM_RST (
    .iClk   (iClk),     .oRst   (wSysRst),
);


//----------------------------------------------------------
// PicelClk 25  MHz
// TmdsClk  250 MHz
// BaseClk  100 MHz
//----------------------------------------------------------
wire wTmdsClk, wPixelClk, wBaseClk;
wire wRst;

cgbWrapper CGB (
    .iClk       (iClk),         .iRst       (wSysRst),
    .oRst       (wRst),
    .oTmdsClk   (wTmdsClk),     .oPixelClk  (wPixelClk),
    .oBaseClk   (wBaseClk)
);


//----------------------------------------------------------
// APDS9960 I2C Connect
//----------------------------------------------------------


//----------------------------------------------------------
// Display Timing 
//----------------------------------------------------------
wire wPVde, wPFe, wPFvde, wPHsync, wPVsync;

dtbWrapper #(
    .pHdisplay  (pHdisplay),    .pHback     (pHback),
    .pHfront    (pHfront),      .pHsync     (pHsync),
    .pVdisplay  (pVdisplay),    .pVtop      (pVtop),
    .pVbottom   (pVbottom),     .pVsync     (pVsync)
) DTP (
    .iClk       (wPixelClk),    .iRst       (wRst),
    .oVde       (wPVde),        .oFe        (wPFe),
    .oFvde      (wPFvde),
    .oHsync     (wPHsync),      .oVsync     (wPVsync)
);


//----------------------------------------------------------
// RGB Gen
//----------------------------------------------------------
wire [23:0] wVRGB;

CaptiveShizuhaBase # (
    .pHdisplay      (pHdisplay),    .pVdisplay      (pVdisplay),
    .pPixelDebug    (pPixelDebug),  .pBuffDepth     (pBuffDepth)
) BASE (
    .iPixelClk      (wPixelClk),    .iRst           (wRst),
    .iBaseClk       (wBaseClk),     .iPFvde         (wPFvde),

    // output Pixel Data
    .oVRGB          (wVRGB)
);


//----------------------------------------------------------
// HDMI Output
//----------------------------------------------------------
tgbWrapper TGB (
    .iPixelCLK       (wPixelClk),   .iTmdsCLK    (wTmdsClk),
    .iRst            (wRst),
    .oHdmiClkNeg     (oHdmiClkNeg), .oHdmiClkPos     (oHdmiClkPos),
    .oHdmiDataNeg    (oHdmiDataNeg),.oHdmiDataPos    (oHdmiDataPos),
    .iVRGB           (wVRGB),       .iVDE            (wPVde),
    .iHSYNC          (wPHsync),     .iVSYNC          (wPVsync)
);


endmodule