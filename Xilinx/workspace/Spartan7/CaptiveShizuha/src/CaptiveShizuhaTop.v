//----------------------------------------------------------
// Create 2022/4/13
// Author koutakimura
// Editor VSCode ver1.62.7
// Build  Vivado20.2
// Board  My Board Spartan7 FTGB196
// -
// [Top Module �̍\��]
// Pre  Processer module
//      Processer module
// Post Processer module
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
    output [1:0]    oApdsScl,       // APDS I2C SCL
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


//----------------------------------------------------------
// �z�X�g�O�������W���[��
// 
// main �����Ɏg�p���� Clk, Display Sync �̐������s��
// (�����I�ɂ� OSC �Ɠ��� ���^�C�~���O�ŃN���b�N���o�͂����ł���)
//----------------------------------------------------------
wire wTmdsClk, wPixelClk, wSysClk;
wire wSysRst;
wire wVde, wFe, wFvde, wHsync, wVsync;

PreProcesser #(
    .pHdisplay  (pHdisplay),
    .pHback     (pHback),
    .pHfront    (pHfront),
    .pHsync     (pHsync),
    .pVdisplay  (pVdisplay),
    .pVtop      (pVtop),
    .pVbottom   (pVbottom),
    .pVsync     (pVsync)
) PREPROCESSER (
    .iClk       (iClk),
    .oTmdsClk   (wTmdsClk),
    .oPixelClk  (wPixelClk),
    .oSysClk    (wSysClk),
    .oRst       (wSysRst),
    .oVde       (wVde),
    .oFe        (wFe),
    .oFvde      (wFvde),
    .oHsync     (wHsync),
    .oVsync     (wVsync)
);


//----------------------------------------------------------
// �z�X�g���C���������W���[��
// 
// �V�X�e���̊Ǘ����i��
//----------------------------------------------------------
wire [23:0] wVRGB;

Processer # (
    .pHdisplay      (pHdisplay),
    .pVdisplay      (pVdisplay),
    .pPixelDebug    (pPixelDebug),
    .pBuffDepth     (pBuffDepth)
) PROCESSER (
    .iPixelClk      (wPixelClk),
    .iRst           (wSysRst),
    .iSysClk        (wSysClk),
    .oApdsScl       (oApdsScl),
    .ioApdsSda      (ioApdsSda),
    .iApdsIntr      (iApdsIntr),
    .oQspiCs        (oQspiCs),
    .oQspiSck       (oQspiSck),
    .ioQspiDq0      (ioQspiDq0),
    .ioQspiDq1      (ioQspiDq1),
    .ioQspiDq2      (ioQspiDq2),
    .ioQspiDq3      (ioQspiDq3),
    .iUartRx        (iUartRx),
    .oUartTx        (oUartTx),
    .iPFvde         (wFvde),
    .oVRGB          (wVRGB)
);


//----------------------------------------------------------
// TODO �I�[�f�B�I�o�͒ǉ��\��
// 
// �z�X�g�㏈�����W���[��
// 
// ��M���� Pixel Data, Sound Data �� TMDS �M���ɕϊ����o�͂��s��
//----------------------------------------------------------
PostProcesser POSTPROCESSER (
    .iPixelClk      (wPixelClk),
    .iTmdsClk       (wTmdsClk),
    .iRst           (wSysRst),
    .oHdmiClkPos    (oHdmiClkPos),
    .oHdmiClkNeg    (oHdmiClkNeg),
    .oHdmiDataPos   (oHdmiDataPos),
    .oHdmiDataNeg   (oHdmiDataNeg),
    .oHdmiScl       (oHdmiScl),
    .ioHdmiSda      (ioHdmiSda),
    .ioHdmiCec      (ioHdmiCec),
    .iHdmiHpd       (iHdmiHpd),
    .iVRGB          (wVRGB),
    .iVde           (wVde),
    .iHsync         (wHsync),
    .iVsync         (wVsync),
    .oLed           (oLed)
);

endmodule