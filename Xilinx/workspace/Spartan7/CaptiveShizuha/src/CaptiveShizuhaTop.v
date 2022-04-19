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
    parameter       pBuffDepth      = 1024      // Display の横幅より大きくサイズを指定
)(
    // CLK
    input           iClk,           // OSC  clk

    // APDS9960
    output [1:0]    oApdsScl,       // APDS I2C SCL
    inout  [1:0]    ioApdsSda,      // APDS I2C SDA
    input  [1:0]    iApdsIntr,      // APDS Interrupt / Open Drain Active Low

    // Flash Memory
    output [1:0]    oQspiSck,       // Qspi Flash Memory Clk
    output [1:0]    ioQspiDq0,      // SPI時 MOSI
    input  [1:0]    ioQspiDq1,      // SPI時 MISO
    output [1:0]    ioQspiDq2,      // SPI時 High 固定, 書き込み保護 Low Active
    output [1:0]    ioQspiDq3,      // SPI時 High 固定, 書き込み停止 Low Active
    output [1:0]    oQspiCs,        // Qspi Flash Memory chip select Low Active

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
// 未使用 Pin 割り当て
//---------------------------------------------------------------------------
// UART
// iUartRx
assign oUartTx      = 1'b1;

// APDS
assign oApdsScl     = 2'b11;
// iApdsIntr
assign ioApdsSda    = 2'bzz;

// Flash Memory
assign oQspiSck     = 2'b00;
// iQspiMiso
assign ioQspiDq0    = 2'b00;
assign ioQspiDq2    = 2'd0;
assign ioQspiDq3    = 2'd0;
assign oQspiCs      = 2'b11;


//---------------------------------------------------------------------------
// 入力ポートはバッファに入力したものを使用する
// 後々モジュール内に移動する
//---------------------------------------------------------------------------
// IBUF # (.IBUF_LOW_PWR ("FALSE"), .IOSTANDARD ("DEFAULT")) IBUF_APDS_INTR_1 ( .O (wClkIbuf), .I (iApdsIntr[0]) );
// IBUF # (.IBUF_LOW_PWR ("FALSE"), .IOSTANDARD ("DEFAULT")) IBUF_APDS_INTR_2 ( .O (wClkIbuf), .I (iApdsIntr[1]) );
// IBUF # (.IBUF_LOW_PWR ("FALSE"), .IOSTANDARD ("DEFAULT")) IBUF_QSPI_MISO_1 ( .O (wClkIbuf), .I (iQspiMiso[0]) );
// IBUF # (.IBUF_LOW_PWR ("FALSE"), .IOSTANDARD ("DEFAULT")) IBUF_QSPI_MISO_2 ( .O (wClkIbuf), .I (iQspiMiso[1]) );
// IBUF # (.IBUF_LOW_PWR ("FALSE"), .IOSTANDARD ("DEFAULT")) IBUF_HDMI_HPD    ( .O (wClkIbuf), .I (iHdmiHpd)     );
// IBUF # (.IBUF_LOW_PWR ("FALSE"), .IOSTANDARD ("DEFAULT")) IBUF_UART_RX     ( .O (wClkIbuf), .I (iUartRx)      );


//----------------------------------------------------------
// System Reset Gen
//----------------------------------------------------------
wire wClkRst;

rstGen #(
    .pRstFallTime (100)
) SYSTEM_RST (
    .iClk   (iClk),     .oRst   (wClkRst),
);


//----------------------------------------------------------
// PixelClk 25  MHz
// TmdsClk  250 MHz
// BaseClk  100 MHz
//----------------------------------------------------------
wire wTmdsClk, wPixelClk, wBaseClk;
wire wSysRst;

cgbWrapper CGB (
    .iClk       (iClk),         .iRst       (wClkRst),
    .oRst       (wSysRst),
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
    .iClk       (wPixelClk),    .iRst       (wSysRst),
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
    .iPixelClk      (wPixelClk),    .iRst           (wSysRst),
    .iBaseClk       (wBaseClk),     .iPFvde         (wPFvde),

    // output Pixel Data
    .oVRGB          (wVRGB)
);


//----------------------------------------------------------
// HDMI Output
// TODO オーディオ出力追加予定
//----------------------------------------------------------
tgbWrapper TGB (
    .iPixelCLK      (wPixelClk),    .iTmdsCLK       (wTmdsClk),
    .iRst           (wSysRst),
    .oHdmiClkNeg    (oHdmiClkNeg),  .oHdmiClkPos    (oHdmiClkPos),
    .oHdmiDataNeg   (oHdmiDataNeg), .oHdmiDataPos   (oHdmiDataPos),
    .oHdmiScl       (oHdmiScl),     .ioHdmiSda      (ioHdmiSda),
    .ioHdmiCec      (ioHdmiCec),    .iHdmiHpd       (iHdmiHpd),
    .iVRGB          (wVRGB),        .iVDE           (wPVde),
    .iHSYNC         (wPHsync),      .iVSYNC         (wPVsync)
);


//---------------------------------------------------------------------------
// Debug Pin
// 
// HPD は通常ケーブル接続時に High になるが、トランジスタのスイッチング回路経由でポートに入力されるため
// ケーブル接続時は Low 信号が検出される
//---------------------------------------------------------------------------
reg [1:0] rHpd;

always @( posedge wPixelClk )
begin
   if       (wSysRst)   rHpd <= 1'b0;
   else if  (iHdmiHpd)  rHpd <= 1'b0;
   else                 rHpd <= 1'b1;
end

assign oLed = {1'b0, rHpd};



endmodule