//----------------------------------------------------------
// Create 2022/8/21
// Author koutakimura
// -
// CPU システムの管理を司るモジュール
//----------------------------------------------------------
module Processer #(
    parameter       pHdisplay     = 480,
    parameter       pHfront       =   8,
    parameter       pHback        =  43,
    parameter       pHpulse       =  30,
    parameter       pVdisplay     = 272,
    parameter       pVfront       =  12,
    parameter       pVback        =   4,
    parameter       pVpulse       =  10,
    parameter       pPixelDebug   = "yes",
    parameter       pBuffDepth    = 1024,
    parameter       pDebug        = "off"
)(
    // External port
	// SPI
    inout           ioSpiSck,
    inout           ioSpiMiso,
    inout           ioSpiMosi,
    inout           ioSpiWp,
    inout           ioSpiHold,
    output          oSpiConfigCs,
    inout           ioSpiCs,
    input           iMSSel,
	// RAM
	output 	[18:0]	oMemAdr,
	inout	[7:0]	ioMemDq,
	output 			oRamOE,
	output 			oRamWE,
	output 			oRamCE,
	// Display
    output	[7:4]   oTftColorR,
    output	[7:4]   oTftColorG,
    output	[7:4]   oTftColorB,
    output          oTftDclk,
    output          oTftHSync,
    output          oTftVSync,
    output          oTftDe,
    output          oTftBackLight,
    output          oTftRst,
	// I2C Controller
    output          oI2CScl,
    inout           ioI2CSda,
	// PWM Audio
    output          oAudioMclk,
	// LED
	output	[1:0]	oLed,
	output 			oLedB,
	output 			oLedG,
	output 			oLedR,
	// TestPort
	output	[3:0]	oTestPort,
    // Internal Port
    // CLK Reset
    input           iSysClk,
    input           iVideoClk,
    input           iMemClk,
    input           iAudioClk,
    input           iSysRst,
    input           iAudioRst
);

// 
assign oMemAdr			= 19'd0;
assign ioMemDq			= 8'dz;
assign oRamOE			= 1'b1;
assign oRamWE			= 1'b1;
assign oRamCE			= 1'b1;
//
assign oTestPort 		= 4'd0;


//-----------------------------------------------------------------------------
// 現在接続している ブロックの個数
//-----------------------------------------------------------------------------
localparam lpBusBlockConnect = 6;


//-----------------------------------------------------------------------------
// ブロックアドレスの Bit幅、接続中のブロック数に応じて切り替える
//-----------------------------------------------------------------------------
localparam lpBlockAdrsMap = 4;	// 2022-09-03 4bit だと 最大16個のブロック接続


//-----------------------------------------------------------------------------
// ブロックアドレスマッピング ※プロジェクトの Readme.md 参照
//-----------------------------------------------------------------------------
localparam [lpBlockAdrsMap-1:0] 
	lpGpioAdrsMap	= 'h01,
	lpSPIAdrsMap	= 'h02,
	lpI2CAdrsMap	= 'h03,
	lpVTBAdrsMap	= 'h04,
	lpATBAdrsMap	= 'h05,
	lpRAMAdrsMap 	= 'h06;


//-----------------------------------------------------------------------------
// ブロック内 Csr のアドレス幅
// 基本となる lpCsrAdrsWidth のアドレス幅で Csr を利用しない場合は、
// ロジック削減のため各ブロックで有効なアドレス幅のパラメータを設定する
// 
// 下記パラメータに関しては、USI I/F Bus のアドレス幅を個々に対応して変更するのが
// 難しいと感じたため用意した。
// 
//-----------------------------------------------------------------------------
localparam lpCsrAdrsWidth	= 16;
localparam 
	lpGpioCsrActiveWidth = 8,
	lpSPICsrActiveWidth  = 8,
	lpI2CCsrActiveWidth  = 8,
	lpVTBCsrActiveWidth  = 16,		// 2022-09-03 現在 VTB だけ 16bit幅で使用している
	lpATBCsrActiveWidth  = 8,
	lpRAMCsrActiveWidth  = 8;


//----------------------------------------------------------
// バス幅を定義
//----------------------------------------------------------
// variable parameter
localparam	lpUsiBusWidth  		= 32;		// Usi バスデータ幅
localparam	lpBusAdrsBit		= 32;		// バスアドレス幅, Usi/Ufi 共通
localparam  lpUfiBusWidth		= 16;


//----------------------------------------------------------
// MCB
//----------------------------------------------------------
// Slave -> Master
reg  [31:0] 					qMUsiRdMcb;
reg  [lpBusBlockConnect-1:0]	qMUsiVdMcb;
// Master -> Slave
wire [31:0] 					wMUsiWdMcb;
wire [lpBusAdrsBit-1:0]			wMUsiAdrsMcb;
wire 							wMUsiWCkeMcb;

MicroControllerBlock #(
	.pBusBlockConnect	(lpBusBlockConnect),
	.pBusAdrsBit		(lpBusAdrsBit)
) MICRO_CONTROLLER_BLOCK (
	.iMUsiRd			(qMUsiRdMcb),
	.iMUsiREd			(qMUsiVdMcb),
	.oMUsiWd			(wMUsiWdMcb),
	.oMUsiAdrs			(wMUsiAdrsMcb),
	.oMUsiWEd			(wMUsiWCkeMcb),
	.iSysClk			(iSysClk),
	.iSysRst			(iSysRst)
);


//----------------------------------------------------------
// GPIO Block
//----------------------------------------------------------
// Slave -> Master
wire [31:0] 			wSUsiRdGpio;
wire 					wSUsiREdGpio;
// Master -> Slave
reg  [31:0] 			qSUsiWdGpio;
reg  [lpBusAdrsBit-1:0] qSUsiAdrsGpio;
reg  					qSUsiWCkeGpio;

GpioBlock #(
	.pBlockAdrsMap		(lpBlockAdrsMap),
	.pAdrsMap	 		(lpGpioAdrsMap),
	.pBusAdrsBit		(lpBusAdrsBit),
	.pCsrAdrsWidth		(lpCsrAdrsWidth),
	.pCsrActiveWidth	(lpGpioCsrActiveWidth)
) GPIO_BLOCK (
	// External Port
	.oLed				(oLed),
	.oLedB				(oLedB),
	.oLedG				(oLedG),
	.oLedR				(oLedR),
	// Internal Port
	.oSUsiRd			(wSUsiRdGpio),
	.oSUsiREd			(wSUsiREdGpio),
	.iSUsiWd			(qSUsiWdGpio),
	.iSUsiAdrs			(qSUsiAdrsGpio),
	.iSUsiWCke			(qSUsiWCkeGpio),
	.iSysClk			(iSysClk),
	.iSysRst			(iSysRst)
);


//----------------------------------------------------------
// External CPU Master SPI Block or Slave SPI Block
//----------------------------------------------------------
// Slave -> Master
reg  [31:0] 					qMUsiRdSpi;
reg  [lpBusBlockConnect-1:0]	qMUsiREdSpi;
wire [31:0] 					wSUsiRdSpi;
wire 							wSUsiREdSpi;
// Master -> Slave
wire [31:0] 					wMUsiWdSpi;
wire [lpBusAdrsBit-1:0]			wMUsiAdrsSpi;
wire 							wMUsiWCkeSpi;
reg  [31:0] 					qSUsiWdSpi;
reg  [lpBusAdrsBit-1:0]			qSUsiAdrsSpi;
reg  							qSUsiWCkeSpi;
// 
wire [lpUfiBusWidth-1:0]		wMUfiWdSpi;
wire [31:0]						wMUfiAdrsSpi;
wire 							wMUfiWEdSpi;
wire 							wMUfiWVdSpi;
// Master Select
wire 							wMUsiSel;
// Interrupt
wire 							wMSpiIntr;

SPIBlock #(
	.pBlockAdrsMap				(lpBlockAdrsMap),
	.pAdrsMap	 				(lpSPIAdrsMap),
	.pBusAdrsBit				(lpBusAdrsBit),
	.pCsrAdrsWidth				(lpCsrAdrsWidth),
	.pCsrActiveWidth			(lpSPICsrActiveWidth),
	.pBusBlockConnect			(lpBusBlockConnect),
	.pUfiBusWidth				(lpUfiBusWidth)
) SPI_BLOCK (
	// External Port
	.ioSpiSck					(ioSpiSck),
	.ioSpiMiso					(ioSpiMiso),
	.ioSpiMosi					(ioSpiMosi),
	.ioSpiWp					(ioSpiWp),
	.ioSpiHold					(ioSpiHold),
	.oSpiConfigCs				(oSpiConfigCs),
	.ioSpiCs					(ioSpiCs),
	.iMSSel						(iMSSel),
	// Slave -> Master
	.iMUsiRd					(qMUsiRdSpi),
	.iMUsiREd					(qMUsiREdSpi),
	// Master -> Slave
	.oMUsiWd					(wMUsiWdSpi),
	.oMUsiAdrs					(wMUsiAdrsSpi),
	.oMUsiWEd					(wMUsiWCkeSpi),
	// Slave -> Master
	.oSUsiRd					(wSUsiRdSpi),
	.oSUsiREd					(wSUsiREdSpi),
	// Master -> Slave
	.iSUsiWd					(qSUsiWdSpi),
	.iSUsiAdrs					(qSUsiAdrsSpi),
	.iSUsiWCke					(qSUsiWCkeSpi),
	// 
	.oMUfiWd					(wMUfiWdSpi),
	.oMUfiAdrs					(wMUfiAdrsSpi),
	.oMUfiWEd					(wMUfiWEdSpi),
	.oMUfiWVd					(wMUfiWVdSpi),
	//
	.oMUsiSel					(wMUsiSel),
	//
	.oMSpiIntr					(wMSpiIntr),
	//
	.iSysClk					(iSysClk),
	.iSysRst					(iSysRst)
);


//----------------------------------------------------------
// 外部コントローラ接続
//----------------------------------------------------------
// Slave -> Master
wire [31:0] 			wSUsiRdI2c;
wire 					wSUsiREdI2c;
// Master -> Slave
reg  [31:0] 			qSUsiWdI2c;
reg  [lpBusAdrsBit-1:0]	qSUsiAdrsI2c;
reg  					qSUsiWCkeI2c;

I2CBlock #(
	.pBlockAdrsMap		(lpBlockAdrsMap),
	.pAdrsMap	 		(lpGpioAdrsMap),
	.pBusAdrsBit		(lpBusAdrsBit),
	.pCsrAdrsWidth		(lpCsrAdrsWidth),
	.pCsrActiveWidth	(lpI2CCsrActiveWidth)
) I2C_BLOCK (
	// External Port
	.oI2CScl			(oI2CScl),
	.ioI2CSda			(ioI2CSda),
	// Internal Port
	.oSUsiRd			(wSUsiRdI2c),
	.oSUsiREd			(wSUsiREdI2c),
	.iSUsiWd			(qSUsiWdI2c),
	.iSUsiAdrs			(qSUsiAdrsI2c),
	.iSUsiWCke			(qSUsiWCkeI2c),
	.iSysClk			(iSysClk),
	.iSysRst			(iSysRst)
);

//----------------------------------------------------------
// VTB
//----------------------------------------------------------
// Slave -> Master
wire [31:0] 			wSUsiRdVtb;
wire 					wSUsiREdVtb;
// Master -> Slave
reg  [31:0] 			qSUsiWdVtb;
reg  [lpBusAdrsBit-1:0] qSUsiAdrsVtb;
reg  					qSUsiWCkeVtb;

VideoTxBlock #(
	.pBlockAdrsMap		(lpBlockAdrsMap),
	.pAdrsMap			(lpVTBAdrsMap),
	.pBusAdrsBit		(lpBusAdrsBit),
	.pCsrAdrsWidth		(lpCsrAdrsWidth),
	.pCsrActiveWidth	(lpVTBCsrActiveWidth),
	.pHdisplay			(pHdisplay),
	.pHfront			(pHfront),
	.pHback				(pHback),
	.pHpulse			(pHpulse),
	.pVdisplay			(pVdisplay),
	.pVfront			(pVfront),
	.pVback				(pVback),
	.pVpulse			(pVpulse),
	.pHdisplayWidth		(11),
	.pHfrontWidth		(7),
	.pHbackWidth		(7),
	.pHpulseWidth		(7),
	.pVdisplayWidth		(11),
	.pVfrontWidth		(5),
	.pVbackWidth		(5),
	.pVpulseWidth		(5)
) VTB (
	// External port
	.oTftColorR			(oTftColorR),
	.oTftColorG			(oTftColorG),
	.oTftColorB			(oTftColorB),
	.oTftDclk			(oTftDclk),
	.oTftHSync			(oTftHSync),
	.oTftVSync			(oTftVSync),
	.oTftDe				(oTftDe),
	.oTftBackLight		(oTftBackLight),
	.oTftRst			(oTftRst),
	// Intenal port
	.oSUsiRd			(wSUsiRdVtb),
	.oSUsiREd			(wSUsiREdVtb),
	.iSUsiWd			(qSUsiWdVtb),
	.iSUsiAdrs			(qSUsiAdrsVtb),
	.iSUsiWCke			(qSUsiWCkeVtb),
	// CLK Rst
	.iSysRst			(iSysRst),
	.iVideoClk 			(iVideoClk),
	.iSysClk			(iSysClk)
);


//----------------------------------------------------------
// Audio Tx Block
//----------------------------------------------------------
// Slave -> Master
wire [31:0] 			wSUsiRdAudio;
wire 					wSUsiREdAudio;
// Master -> Slave
reg  [31:0] 			qSUsiWdAudio;
reg  [lpBusAdrsBit-1:0]	qSUsiAdrsAudio;
reg  					qSUsiWCkeAudio;

AudioTxBlock #(
	.pBlockAdrsMap		(lpBlockAdrsMap),
	.pAdrsMap	 		(lpATBAdrsMap),
	.pBusAdrsBit		(lpBusAdrsBit),
	.pCsrAdrsWidth		(lpCsrAdrsWidth),
	.pCsrActiveWidth	(lpATBCsrActiveWidth)
) AUDIO_TX_BLOCK (
	// External Port
	.oAudioMclk			(oAudioMclk),
	// Internal Port
	.oSUsiRd			(wSUsiRdAudio),
	.oSUsiREd			(wSUsiREdAudio),
	.iSUsiWd			(qSUsiWdAudio),
	.iSUsiAdrs			(qSUsiAdrsAudio),
	.iSUsiWCke			(qSUsiWCkeAudio),
	.iSysRst			(iSysRst),
	.iSysClk			(iSysClk)
);


//----------------------------------------------------------
// 外部 RAM を操作しシステムと協調動作させる
//----------------------------------------------------------
// RAMBlock RAM_BLOCK


//----------------------------------------------------------
// USI/F BUS
//----------------------------------------------------------
// not variable parameter
localparam	lpBusLen = (lpUsiBusWidth * lpBusBlockConnect) - 1'b1;

// Slave -> Master
wire [31:0] 					wMUsiRd;
wire [lpBusBlockConnect-1:0]	wMUsiREd;
reg  [lpBusLen:0]				qSUsiRd;
reg  [lpBusBlockConnect-1:0]	qSUsiREd;
// Master -> Slave
reg  [31:0]						qMUsiWd;
reg  [lpBusAdrsBit-1:0] 		qMUsiAdrs;
reg  							qMUsiWEd;
wire [31:0] 					wSUsiWd;
wire [lpBusAdrsBit-1:0] 		wSUsiAdrs;
wire 							wSUsiWCke;

UltraSimpleInterface #(
	.pBusBlockConnect	(lpBusBlockConnect),
	.pUsiBusWidth		(lpUsiBusWidth),
	.pBusAdrsBit		(lpBusAdrsBit),
	.pBlockAdrsMap		(lpBlockAdrsMap),
	.pGpioAdrsMap		(lpGpioAdrsMap),
	.pSPIAdrsMap		(lpSPIAdrsMap),
	.pI2CAdrsMap		(lpI2CAdrsMap),
	.pVTBAdrsMap		(lpVTBAdrsMap),
	.pATBAdrsMap		(lpATBAdrsMap),
	.pRAMAdrsMap		(lpRAMAdrsMap),
	.pCsrAdrsWidth		(lpCsrAdrsWidth)
) USI_BUS (
	// Slave to Master
	.oMUsiRd			(wMUsiRd),
	.oMUsiREd			(wMUsiREd),
	.iSUsiRd			(qSUsiRd),
	.iSUsiREd			(qSUsiREd),
	// Master to Slave
	.iMUsiWd			(qMUsiWd),
	.iMUsiAdrs			(qMUsiAdrs),
	.iMUsiWEd			(qMUsiWEd),
	.oSUsiWd			(wSUsiWd),
	.oSUsiAdrs			(wSUsiAdrs),
	.oSUsiWCke			(wSUsiWCke),
	// Clk Rst
	.iUsiClk 			(iSysClk),
	.iUsiRst			(iSysRst)
);

always @*
begin
	qMUsiRdMcb		<= wMUsiRd;
	qMUsiVdMcb		<= wMUsiREd;
	qMUsiRdSpi		<= wMUsiRd;
	qMUsiREdSpi		<= wMUsiREd;
	//
	qMUsiWd			<= wMUsiSel ? wMUsiWdSpi   : wMUsiWdMcb;
	qMUsiAdrs		<= wMUsiSel ? wMUsiAdrsSpi : wMUsiAdrsMcb;
	qMUsiWEd		<= wMUsiSel ? wMUsiWCkeSpi : wMUsiWCkeMcb;
	//
	qSUsiWdGpio		<= wSUsiWd;
	qSUsiAdrsGpio 	<= wSUsiAdrs;
	qSUsiWCkeGpio	<= wSUsiWCke;
	//
	qSUsiWdSpi		<= wSUsiWd;
	qSUsiAdrsSpi	<= wSUsiAdrs;
	qSUsiWCkeSpi	<= wSUsiWCke;
	//
	qSUsiWdI2c		<= wSUsiWd;
	qSUsiAdrsI2c	<= wSUsiAdrs;
	qSUsiWCkeI2c	<= wSUsiWCke;
	//
	qSUsiWdVtb		<= wSUsiWd;
	qSUsiAdrsVtb	<= wSUsiAdrs;
	qSUsiWCkeVtb	<= wSUsiWCke;
	//
	qSUsiWdAudio	<= wSUsiWd;
	qSUsiAdrsAudio	<= wSUsiAdrs;
	qSUsiWCkeAudio	<= wSUsiWCke;
	//
	qSUsiRd			<= {32'd0, wSUsiRdAudio,  wSUsiRdVtb,  wSUsiRdI2c,  wSUsiRdSpi,  wSUsiRdGpio	};
	qSUsiREd		<= { 1'h0, wSUsiREdAudio, wSUsiREdVtb, wSUsiREdI2c, wSUsiREdSpi, wSUsiREdGpio	};
end

//----------------------------------------------------------
// UFI/F BUS
//----------------------------------------------------------
// UltraFastInterface UFI_BUS


endmodule