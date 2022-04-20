//----------------------------------------------------------
// Create 2022/4/13
// Author koutakimura
// Editor VSCode ver1.62.7
// Build  Vivado20.2
// Board  My Board Spartan7 FTGB196
// -
// ã?ããã°ãé¤ã?ã¦å¤é¨ããä¿¡å·ãåä¿¡ãåã¯å¤é¨ã«ä¿¡å·ãé?ä¿¡ããã¢ã¸ã¥ã¼ã«ã¯ Top ã«è¨è¿°
// FPGA å?é¨ã§å®çµããã¢ã¸ã¥ã¼ã«ã¯ Base ã«è¨è¿°
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
    parameter       pBuffDepth      = 1024      // Display ã®æ¨ªå¹?ããå¤§ãããµã¤ãºãæå®?
)(
    // CLK
    input           iClk,           // OSC  clk

    // APDS9960
    inout  [1:0]    ioApdsScl,      // APDS I2C SCL
    inout  [1:0]    ioApdsSda,      // APDS I2C SDA
    input  [1:0]    iApdsIntr,      // APDS Interrupt / Open Drain Active Low

    // Flash Memory
    output [1:0]    oQspiCs,        // Qspi Flash Memory chip select Low Active
    output [1:0]    oQspiSck,       // Qspi Flash Memory Clk
    inout  [1:0]    ioQspiDq0,      // SPIæ? MOSI
    inout  [1:0]    ioQspiDq1,      // SPIæ? MISO
    inout  [1:0]    ioQspiDq2,      // SPIæ? High åºå®?, æ¸ãè¾¼ã¿ä¿è­· Low Active
    inout  [1:0]    ioQspiDq3,      // SPIæ? High åºå®?, æ¸ãè¾¼ã¿åæ­¢ Low Active

    // HDMI TX
    output          oHdmiClkPos,    // hdmi clk posedge
    output          oHdmiClkNeg,    // hdmi clk negedge
    output [2:0]    oHdmiDataPos,   // hdmi Data 8b10b posedge
    output [2:0]    oHdmiDataNeg,   // hdmi Data 8b10b negedge
    output          oHdmiScl,       // hdmi I2c scl
    inout           ioHdmiSda,      // hdmi I2c sda
    inout           ioHdmiCec,      // hdmi cec
    input           iHdmiHpd,       // hdmi hpd Low Active

    // UART
    input           iUartRx,        // Uart
    output          oUartTx,        // Uart

    // LED
    output [1:0]    oLed            // Led Flash
);

//---------------------------------------------------------------------------
// æªä½¿ç¨ Pin å²ãå½ã¦
//---------------------------------------------------------------------------
// UART
// iUartRx
assign oUartTx      = 1'b1;

// APDS
assign oApdsScl     = 2'bzz;
assign ioApdsSda    = 2'bzz;

// Flash Memory
assign oQspiSck     = 2'b00;
assign ioQspiDq0    = 2'b00;
assign ioQspiDq2    = 2'b00;
assign ioQspiDq3    = 2'b00;
assign oQspiCs      = 2'b11;



//----------------------------------------------------------
// System Reset Gen
//----------------------------------------------------------
wire wClkRst;

rstGen #(
    .pRstFallTime   (100)
) SYSTEM_RST (
    .iClk           (iClk),
    .oRst           (wClkRst)
);


//----------------------------------------------------------
// PixelClk 25  MHz
// TmdsClk  250 MHz
// BaseClk  100 MHz
//----------------------------------------------------------
wire wTmdsClk, wPixelClk, wBaseClk;
wire wSysRst;

cgbWrapper CGB (
    .iClk       (iClk),
    .iRst       (wClkRst),
    .oRst       (wSysRst),
    .oTmdsClk   (wTmdsClk),
    .oPixelClk  (wPixelClk),
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
    .pHdisplay  (pHdisplay),
    .pHback     (pHback),
    .pHfront    (pHfront),
    .pHsync     (pHsync),
    .pVdisplay  (pVdisplay),
    .pVtop      (pVtop),
    .pVbottom   (pVbottom),
    .pVsync     (pVsync)
) DTP (
    .iClk       (wPixelClk),
    .iRst       (wSysRst),
    .oVde       (wPVde),
    .oFe        (wPFe),
    .oFvde      (wPFvde),
    .oHsync     (wPHsync),
    .oVsync     (wPVsync)
);


//----------------------------------------------------------
// RGB Gen
//----------------------------------------------------------
wire [23:0] wVRGB;

CaptiveShizuhaBase # (
    .pHdisplay      (pHdisplay),
    .pVdisplay      (pVdisplay),
    .pPixelDebug    (pPixelDebug),
    .pBuffDepth     (pBuffDepth)
) BASE (
    .iPixelClk      (wPixelClk),
    .iRst           (wSysRst),
    .iBaseClk       (wBaseClk),
    .iPFvde         (wPFvde),
    .oVRGB          (wVRGB)
);


//----------------------------------------------------------
// HDMI Output
// TODO ãªã¼ã?ã£ãªåºåè¿½å?äºå®?
//----------------------------------------------------------
wire wHdmiHpd;

tgbWrapper TGB (
    .iPixelCLK      (wPixelClk),
    .iTmdsCLK       (wTmdsClk),
    .iRst           (wSysRst),
    .oHdmiClkNeg    (oHdmiClkNeg),
    .oHdmiClkPos    (oHdmiClkPos),
    .oHdmiDataNeg   (oHdmiDataNeg),
    .oHdmiDataPos   (oHdmiDataPos),
    .oHdmiScl       (oHdmiScl),
    .ioHdmiSda      (ioHdmiSda),
    .ioHdmiCec      (ioHdmiCec),
    .iHdmiHpd       (wHdmiHpd),
    .iVRGB          (wVRGB),
    .iVDE           (wPVde),
    .iHSYNC         (wPHsync),
    .iVSYNC         (wPVsync)
);

IBUF IBUF_HDMI_HPD ( 
    .O (wHdmiHpd),
    .I (iHdmiHpd)
);

//---------------------------------------------------------------------------
// Debug Pin
// 
// HPD ã¯éå¸¸ã±ã¼ãã«æ¥ç¶æã« High ã«ãªããããã©ã³ã¸ã¹ã¿ã®ã¹ã¤ã?ãã³ã°åè·¯çµç±ã§ãã?¼ãã«å¥åããããã
// ã±ã¼ãã«æ¥ç¶æã¯ Low ä¿¡å·ãæ¤å?ºããã?
//---------------------------------------------------------------------------
reg [1:0] rHpd;

always @( posedge wPixelClk )
begin
   if       (wSysRst)     rHpd <= 1'b0;
   else if  (wHdmiHpd)    rHpd <= 1'b0;
   else                   rHpd <= 1'b1;
end

assign oLed = {1'b0, rHpd};



endmodule