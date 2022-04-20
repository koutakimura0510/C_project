//----------------------------------------------------------
// Create 2022/4/13
// Author koutakimura
// Editor VSCode ver1.62.7
// Build  Vivado20.2
// Board  My Board Spartan7 FTGB196
// -
// �f�o�b�O�������ĊO������M������M�A���͊O���ɐM���𑗐M���郂�W���[���� Top �ɋL�q
// FPGA �����Ŋ������郂�W���[���� Base �ɋL�q
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
    parameter       pBuffDepth      = 1024      // Display �̉������傫���T�C�Y���w��
)(
    input           iClk,           // OSC  clk
    inout  [1:0]    ioApdsScl,      // APDS I2C SCL
    inout  [1:0]    ioApdsSda,      // APDS I2C SDA
    input  [1:0]    iApdsIntr,      // APDS Interrupt / Open Drain Active Low
    output [1:0]    oQspiCs,        // Qspi Flash Memory chip select Low Active
    output [1:0]    oQspiSck,       // Qspi Flash Memory Clk
    inout  [1:0]    ioQspiDq0,      // SPI�� MOSI
    inout  [1:0]    ioQspiDq1,      // SPI�� MISO
    inout  [1:0]    ioQspiDq2,      // SPI�� High �Œ�, �������ݕی� Low Active
    inout  [1:0]    ioQspiDq3,      // SPI�� High �Œ�, �������ݒ�~ Low Active
    output          oHdmiClkPos,    // hdmi clk posedge
    output          oHdmiClkNeg,    // hdmi clk negedge
    output [2:0]    oHdmiDataPos,   // hdmi Data 8b10b posedge
    output [2:0]    oHdmiDataNeg,   // hdmi Data 8b10b negedge
    output          oHdmiScl,       // hdmi I2c scl
    inout           ioHdmiSda,      // hdmi I2c sda
    inout           ioHdmiCec,      // hdmi cec
    input           iHdmiHpd,       // hdmi hpd Low Active
    input           iUartRx,        // Uart
    output          oUartTx,        // Uart
    output [1:0]    oLed            // Led Flash
);

//---------------------------------------------------------------------------
// ���g�p Pin ���蓖��
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
    .oRst           (wClkRst),
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
// TODO �I�[�f�B�I�o�͒ǉ��\��
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
// HPD �͒ʏ�P�[�u���ڑ����� High �ɂȂ邪�A�g�����W�X�^�̃X�C�b�`���O��H�o�R�Ń|�[�g�ɓ��͂���邽��
// �P�[�u���ڑ����� Low �M�������o�����
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