/*~`^*~`^*~`^*~`^*~`^*~`^*~`^*~`^*~`^*~`^*~`^*~`^*~`^*~`^*~`^*~`^*~`^*~`^*~`^*
 *
 * File Name   : MCsiRxController.v
 * Description : Ti180M484 dev Kit MIPI RX to HDMI Output Simple Demo.
 * Simulator   : VeritakWin Ver.3.84D Build May.23.2011
 * Implem. Tool: Efinix Efinity 2022.1.226.2.11
 * Explanation : 
 *
 * Copyright(c) 2011-2022, by Net-Vision Corp. All rights reserved.
 * (Note) For this source code, it is forbidden using and issuing
 *        without permission.
 * （注） このソース・コードの無断使用および無断持ち出しを禁止します．
 *
 * Revision    :
 * 29/Dec-2022 V1.00 New Release, Inh.fr. "MCsiRxController.v" K.Kimura
 *
 *~`^*~`^*~`^*~`^*~`^*~`^*~`^*~`^*~`^*~`^*~`^*~`^*~`^*~`^*~`^*~`^*~`^*~`^*~`^*/
//-----------------------------------------------------------------------------
module MCsiRxController #(
	parameter	pMipiRxLaneNumCh1	= 2
)(
// Hard D-PHY Port
// Controls and Status Signals
output 			oMipiDphyRx1_RESET_N,				// Disables PHY and Digital Logic
output 			oMipiDphyRx1_RST0_N,				// Async FIFO RST and sync out of RST
input 			iMipiDphyRx1_STOPSTATE_CLK,			// Lane in Stop State
input 			iMipiDphyRx1_STOPSTATE_LAN0,		// Data Lane in Stop State, Active High
input 			iMipiDphyRx1_STOPSTATE_LAN1,		// Data Lane in Stop State
input 			iMipiDphyRx1_ERR_ESC_LAN0,			// Lane Escape Command Error
input 			iMipiDphyRx1_ERR_ESC_LAN1,			// Lane Escape Command Error
input 			iMipiDphyRx1_ERR_CONTROL_LAN0,		// Lane Has Line State Error
input 			iMipiDphyRx1_ERR_CONTROL_LAN1,		// Lane Has Line State Error
output 			oMipiDphyRx1_TX_REQUEST_ESC,		// Lane0 Request TX Escape Mode , TX_CLK_ESC
output 			oMipiDphyRx1_TURN_REQUEST,			// Lane0 Request Trunaround , TX_CLK_ESC
output 			oMipiDphyRx1_FORCE_RX_MODE,
output	[3:0] 	oMipiDphyRx1_TX_TRIGGER_ESC,		// Lane0 Send a Trigger Event , TX_CLK_ESC
input	[3:0] 	iMipiDphyRx1_RX_TRIGGER_ESC,		// Lane0 Received Trigger Event , RX_CLK_ESC_LAN
input 			iMipiDphyRx1_DIRECTION,
input 			iMipiDphyRx1_ERR_CONTENTION_LP0,	// Lane0 Contention Error when Driving
input 			iMipiDphyRx1_ERR_CONTENTION_LP1,	// Lane0 Contention Error when Driving
//
// HS Mode Signals
input 			iMipiDphyRx1_RX_CLK_ACTIVE_HS,		// HS Clock Lane Active
input 			iMipiDphyRx1_RX_ACTIVE_HS_LAN0,		// HS Reception Active
input 			iMipiDphyRx1_RX_ACTIVE_HS_LAN1,		// HS Reception Active
input 			iMipiDphyRx1_RX_VALID_HS_LAN0,		// HS Data Receive Valid
input 			iMipiDphyRx1_RX_VALID_HS_LAN1,		// HS Data Receive Valid
input 			iMipiDphyRx1_RX_SYNC_HS_LAN0,		// HS Reveiver Sync. Observed
input 			iMipiDphyRx1_RX_SYNC_HS_LAN1,		// HS Reveiver Sync. Observed
input 			iMipiDphyRx1_RX_SKEW_CAL_HS_LAN0,	// HS Reveiver DeSkew Burst Received.
input 			iMipiDphyRx1_RX_SKEW_CAL_HS_LAN1,	// HS Reveiver DeSkew Burst Received.
input	[7:0] 	iMipiDphyRx1_RX_DATA_HS_LAN0,		// HS Receive Data
input	[7:0] 	iMipiDphyRx1_RX_DATA_HS_LAN1,		// HS Receive Data
input 			iMipiDphyRx1_ERR_SOT_HS_LAN0,		// State-of-Transmission(SOT)Error
input 			iMipiDphyRx1_ERR_SOT_HS_LAN1,
input 			iMipiDphyRx1_ERR_SOT_SYNC_HS_LAN0,	// SOT SYnc Error
input 			iMipiDphyRx1_ERR_SOT_SYNC_HS_LAN1,
//
// LP Mode Signals
input 			iMipiDphyRx1_RX_LPDT_ESC,			// Lane enter LPDT RX Mode. , RX_CLK_ESC_LAN0
input	[7:0] 	iMipiDphyRx1_RX_DATA_ESC,			// Lane LPDT RX Data , RX_CLK_ESC_LAN0
input 			iMipiDphyRx1_RX_VALID_ESC,			// Lane LPDT RX Data Valid , RX_CLK_ESC_LAN0
input 			iMipiDphyRx1_RX_ERR_SYNC_ESC,		// LPDT RX Data Sync Error
output 			oMipiDphyRx1_TX_LPDT_ESC,			// Lane0 Enter LPDT TX Mode , TX_CLK_ESC
output	[7:0]	oMipiDphyRx1_TX_DATA_ESC,			// Lane0 LPDT TX Data , TX_CLK_ESC
output 			oMipiDphyRx1_TX_VALID_ESC,			// Lane0 LPDT TX Data Valid , TX_CLK_ESC
output 			oMipiDphyRx1_TX_READY_ESC,			// Lane0 LPDT TX Data Ready , TX_CLK_ESC
//
// Ultra Low Power Sleep Mode Signals
output			oMipiDphyRx1_TX_ULPS_ESC,				// Lane 0 Enter ULPS Mode. , TX_CLK_ESC
output			oMipiDphyRx1_TX_ULPS_EXIT,				// Lane 0 Exit ULPS Mode. , TX_CLK_ESC
input 			iMipiDphyRx1_RX_ULPS_CLK_NOT,			// CLK0 Enter ULPS Mode
input 			iMipiDphyRx1_RX_ULPS_ACTIVE_CLK_NOT,	// CLK0 is in ULPS (Active Low)
input 			iMipiDphyRx1_RX_ULPS_ESC_LAN0,			// Lane n Enter ULPS Mode. RX_CLK_ESC_LANn
input 			iMipiDphyRx1_RX_ULPS_ESC_LAN1,			// RX_CLK_ESC_LANn
input 			iMipiDphyRx1_RX_ULPS_ACTIVE_NOT_LAN0,	// Lane n is in ULPS (Active Low)
input 			iMipiDphyRx1_RX_ULPS_ACTIVE_NOT_LAN1,
//
// Clock Domain
// output 			oMipiDphyRx1_TX_CFG_CLK,			// Configration CLK
input  			iMipiDphyRx1_WORD_CLKOUT_HS,			// HS Receive Byte/Word CLK
input 			iMipiDphyRx1_LP_CLK,					// Low Power State CLK
input 			iMipiDphyRx1_RX_CLK_ESC_LAN0,			// Escape Mode Receive CLK
input 			iMipiDphyRx1_RX_CLK_ESC_LAN1,			// Escape Mode Receive CLK
output 			oMipiDphyRx1_TX_CLK_ESC,				// Escape Mode TX CLK must be lower than 20[MHz]
//
// CSI controller ouptut interface port
output [ 5:0] 	oHsDatatype,
output [15:0] 	oHsWordCnt,
output [ 7:0] 	oHsEcc,
//
// Video Signals
output  [31:0]	oVideoPixel,
output  		oVideoVd,
input 			iVideofull,
//
output 			oCdcFifoFull,
//
// Clk,Rst
input			iSRST,
input			inSRST,
input			iVRST,
input			inVRST,
input			iFRST,
input			inFRST,
input			iSCLK,
input			iVCLK,
input 			iFCLK
);
  
//-----------------------------------------------------------------------------
// MIPI D-PHY / CSI-2 Decoder
//-----------------------------------------------------------------------------
wire [31:0] wHsPixel;
wire [ 5:0] wHsDatatype;					assign oHsDatatype 	= wHsDatatype;
wire [15:0] wHsWordCnt;						assign oHsWordCnt 	= wHsWordCnt;
wire [ 7:0] wHsEcc;							assign oHsEcc 		= wHsEcc;
wire 		wHsValid;
reg 		qCsiEdv;

MCsi2Decoder MCsi2Decoder(
	// Hard D-PHY Port
	// Controls and Status Signals
	.oMipiDphyRx1_RESET_N(oMipiDphyRx1_RESET_N),
	.oMipiDphyRx1_RST0_N(oMipiDphyRx1_RST0_N),
	.iMipiDphyRx1_STOPSTATE_CLK(iMipiDphyRx1_STOPSTATE_CLK),
	.iMipiDphyRx1_STOPSTATE_LAN0(iMipiDphyRx1_STOPSTATE_LAN0),
	.iMipiDphyRx1_STOPSTATE_LAN1(iMipiDphyRx1_STOPSTATE_LAN1),
	.iMipiDphyRx1_ERR_ESC_LAN0(iMipiDphyRx1_ERR_ESC_LAN0),
	.iMipiDphyRx1_ERR_ESC_LAN1(iMipiDphyRx1_ERR_ESC_LAN1),
	.iMipiDphyRx1_ERR_CONTROL_LAN0(iMipiDphyRx1_ERR_CONTROL_LAN0),
	.iMipiDphyRx1_ERR_CONTROL_LAN1(iMipiDphyRx1_ERR_CONTROL_LAN1),
	.oMipiDphyRx1_TX_REQUEST_ESC(oMipiDphyRx1_TX_REQUEST_ESC),
	.oMipiDphyRx1_TURN_REQUEST(oMipiDphyRx1_TURN_REQUEST),
	.oMipiDphyRx1_FORCE_RX_MODE(oMipiDphyRx1_FORCE_RX_MODE),
	.oMipiDphyRx1_TX_TRIGGER_ESC(oMipiDphyRx1_TX_TRIGGER_ESC),
	.iMipiDphyRx1_RX_TRIGGER_ESC(iMipiDphyRx1_RX_TRIGGER_ESC),
	.iMipiDphyRx1_DIRECTION(iMipiDphyRx1_DIRECTION),
	.iMipiDphyRx1_ERR_CONTENTION_LP0(iMipiDphyRx1_ERR_CONTENTION_LP0),
	.iMipiDphyRx1_ERR_CONTENTION_LP1(iMipiDphyRx1_ERR_CONTENTION_LP1),
	//
	// HS Mode Signals
	.iMipiDphyRx1_RX_CLK_ACTIVE_HS(iMipiDphyRx1_RX_CLK_ACTIVE_HS),
	.iMipiDphyRx1_RX_ACTIVE_HS_LAN0(iMipiDphyRx1_RX_ACTIVE_HS_LAN0),
	.iMipiDphyRx1_RX_ACTIVE_HS_LAN1(iMipiDphyRx1_RX_ACTIVE_HS_LAN1),
	.iMipiDphyRx1_RX_VALID_HS_LAN0(iMipiDphyRx1_RX_VALID_HS_LAN0),
	.iMipiDphyRx1_RX_VALID_HS_LAN1(iMipiDphyRx1_RX_VALID_HS_LAN1),
	.iMipiDphyRx1_RX_SYNC_HS_LAN0(iMipiDphyRx1_RX_SYNC_HS_LAN0),
	.iMipiDphyRx1_RX_SYNC_HS_LAN1(iMipiDphyRx1_RX_SYNC_HS_LAN1),
	.iMipiDphyRx1_RX_SKEW_CAL_HS_LAN0(iMipiDphyRx1_RX_SKEW_CAL_HS_LAN0),
	.iMipiDphyRx1_RX_SKEW_CAL_HS_LAN1(iMipiDphyRx1_RX_SKEW_CAL_HS_LAN1),
	.iMipiDphyRx1_RX_DATA_HS_LAN0(iMipiDphyRx1_RX_DATA_HS_LAN0),
	.iMipiDphyRx1_RX_DATA_HS_LAN1(iMipiDphyRx1_RX_DATA_HS_LAN1),
	.iMipiDphyRx1_ERR_SOT_HS_LAN0(iMipiDphyRx1_ERR_SOT_HS_LAN0),
	.iMipiDphyRx1_ERR_SOT_HS_LAN1(iMipiDphyRx1_ERR_SOT_HS_LAN1),
	.iMipiDphyRx1_ERR_SOT_SYNC_HS_LAN0(iMipiDphyRx1_ERR_SOT_SYNC_HS_LAN0),
	.iMipiDphyRx1_ERR_SOT_SYNC_HS_LAN1(iMipiDphyRx1_ERR_SOT_SYNC_HS_LAN1),
	//
	// LP Mode Signals
	.iMipiDphyRx1_RX_LPDT_ESC(iMipiDphyRx1_RX_LPDT_ESC),
	.iMipiDphyRx1_RX_DATA_ESC(iMipiDphyRx1_RX_DATA_ESC),
	.iMipiDphyRx1_RX_VALID_ESC(iMipiDphyRx1_RX_VALID_ESC),
	.iMipiDphyRx1_RX_ERR_SYNC_ESC(iMipiDphyRx1_RX_ERR_SYNC_ESC),
	.oMipiDphyRx1_TX_LPDT_ESC(oMipiDphyRx1_TX_LPDT_ESC),
	.oMipiDphyRx1_TX_DATA_ESC(oMipiDphyRx1_TX_DATA_ESC),
	.oMipiDphyRx1_TX_VALID_ESC(oMipiDphyRx1_TX_VALID_ESC),
	.oMipiDphyRx1_TX_READY_ESC(oMipiDphyRx1_TX_READY_ESC),
	//
	// Ultra Low Power Sleep Mode Signals
	.oMipiDphyRx1_TX_ULPS_ESC(oMipiDphyRx1_TX_ULPS_ESC),
	.oMipiDphyRx1_TX_ULPS_EXIT(oMipiDphyRx1_TX_ULPS_EXIT),
	.iMipiDphyRx1_RX_ULPS_CLK_NOT(iMipiDphyRx1_RX_ULPS_CLK_NOT),
	.iMipiDphyRx1_RX_ULPS_ACTIVE_CLK_NOT(iMipiDphyRx1_RX_ULPS_ACTIVE_CLK_NOT),
	.iMipiDphyRx1_RX_ULPS_ESC_LAN0(iMipiDphyRx1_RX_ULPS_ESC_LAN0),
	.iMipiDphyRx1_RX_ULPS_ESC_LAN1(iMipiDphyRx1_RX_ULPS_ESC_LAN1),
	.iMipiDphyRx1_RX_ULPS_ACTIVE_NOT_LAN0(iMipiDphyRx1_RX_ULPS_ACTIVE_NOT_LAN0),
	.iMipiDphyRx1_RX_ULPS_ACTIVE_NOT_LAN1(iMipiDphyRx1_RX_ULPS_ACTIVE_NOT_LAN1),
	//
	// Clock Domain
	.iMipiDphyRx1_WORD_CLKOUT_HS(iMipiDphyRx1_WORD_CLKOUT_HS),
	.iMipiDphyRx1_LP_CLK(iMipiDphyRx1_LP_CLK),
	.iMipiDphyRx1_RX_CLK_ESC_LAN0(iMipiDphyRx1_RX_CLK_ESC_LAN0),
	.iMipiDphyRx1_RX_CLK_ESC_LAN1(iMipiDphyRx1_RX_CLK_ESC_LAN1),
	.oMipiDphyRx1_TX_CLK_ESC(oMipiDphyRx1_TX_CLK_ESC),
	//
	// Out Pixel
	.oHsPixel(wHsPixel),
	.oHsDatatype(wHsDatatype),
	.oHsWordCnt(wHsWordCnt),
	.oHsEcc(wHsEcc),
	.oHsValid(wHsValid),
	//
	// Status
	.iEdv(qCsiEdv),
	//
	// CLK RST
	.iSRST(iSRST),
	.inSRST(inSRST),
	.iSCLK(iSCLK)
);


//-----------------------------------------------------------------------------
// Dual CLK Fifo Side
// ピクセルクロックのタイミングで出力されるピクセルデータを高速なクロックに変換
// CSI2-IP から出力されるデータは垂れ流しで全て受け付ける。
// 
// ※ Titanium の DualClkRam が 最大8bit ～ 10bit, 深さ1024 までしか対応していない。
// 
//	BRAM のプリミティブ活用や、コードからの合成結果については試行回数が必要。
//	Quantum アーキテクチャの特徴を生かして、カスケード接続が定石か？
//-----------------------------------------------------------------------------
localparam lpCdcFifoBitWidth	= 16;
localparam lpCdcFifoDepth		= (8192*4) / lpCdcFifoBitWidth;
localparam lpCdcFifoBitLoop		= 16   / lpCdcFifoBitWidth;
localparam lpCdcFIfoFullAlMost	= 16;
//
reg  [31:0] 					qCdcFifoWd;
wire [lpCdcFifoBitLoop-1:0] 	wCdcFifoEmp;
wire [31:0] 					wCdcFifoRd;
wire [lpCdcFifoBitLoop-1:0] 	wCdcFifoRvd;
reg  							qCdcFifoWe;
reg  							qCdcFifoRe;
wire [lpCdcFifoBitLoop-1:0] 	wCdcFifoFull;				assign oCdcFifoFull = wCdcFifoFull[0];

genvar n;

generate
	for (n = 0; n < lpCdcFifoBitLoop; n = n + 1)
	begin
		fifoDualController #(
			.pFifoDepth	(lpCdcFifoDepth),	.pFifoBitWidth(lpCdcFifoBitWidth),
			.pFullAlMost(lpCdcFIfoFullAlMost)
		) mCsiDualClkFIFO (
			// src side
			.iWd(qCdcFifoWd[(n+1)*lpCdcFifoBitWidth-1:n*lpCdcFifoBitWidth]),
			.iWe(qCdcFifoWe),						.ofull(wCdcFifoFull[n]),
			.iWCLK(iMipiDphyRx1_WORD_CLKOUT_HS),	.iWnRST(inSRST),
			// dst side
			.oRd(wCdcFifoRd[(n+1)*lpCdcFifoBitWidth-1:n*lpCdcFifoBitWidth]),
			.oRvd(wCdcFifoRvd[n]),
			.iRe(qCdcFifoRe),						.oEmp(wCdcFifoEmp[n]),
			.iRCLK(iVCLK),							.iRnRST(inVRST)
		);
	end
endgenerate

always @*
begin
	qCdcFifoWd 	<= wHsPixel;
	qCdcFifoWe 	<= wHsValid;
	qCsiEdv		<= (~wCdcFifoFull[0]);
end


//-----------------------------------------------------------------------------
// Fifo Side
//-----------------------------------------------------------------------------
localparam lpFtiFifoBitWidth	= 16;
localparam lpFtiFifoDepth		= (8192*4) / lpFtiFifoBitWidth;
localparam lpFtiFifoBitLoop		= 16   / lpFtiFifoBitWidth;
localparam lpFtiFifoFullAlMost	= 16;

wire [15:0] 				wFtiRd;								assign oVideoPixel = {16'd0,wFtiRd};
wire [lpFtiFifoBitLoop-1:0]	wFtiRvd;							assign oVideoVd    = wFtiRvd[0];
reg  						qFtiRe;
wire [lpFtiFifoBitLoop-1:0]	wFtiEmp;
wire [lpFtiFifoBitLoop-1:0]	wFtifull;

generate
	for (n = 0; n < lpFtiFifoBitLoop; n = n + 1) begin
		fifoController #(
			.pFifoDepth(lpFtiFifoDepth),	.pFifoBitWidth(lpFtiFifoBitWidth),
			.pFullAlMost(lpFtiFifoFullAlMost)
		) mVideoFIFO (
			// Write Side
			.iWd(wCdcFifoRd[(n+1)*lpFtiFifoBitWidth-1:n*lpFtiFifoBitWidth]),
			.iWe(wCdcFifoRvd[0]),			.ofull(wFtifull[n]),
			// Read Side
			.oRd(wFtiRd[(n+1)*lpFtiFifoBitWidth-1:n*lpFtiFifoBitWidth]),
			.iRe(qFtiRe),
			.oRvd(wFtiRvd[n]),				.oEmp(wFtiEmp[n]),
			// common
			.iCLK(iVCLK),					.inRST(inVRST)
		);
	end
endgenerate

always @*
begin
	qCdcFifoRe 	<= (~wFtifull[0]) & (~wCdcFifoEmp[0]);
	qFtiRe		<= (~iVideofull) & (~wFtiEmp[0]);
end


//-----------------------------------------------------------------------------
// ILA 用モニタリング
//-----------------------------------------------------------------------------
reg 		rHsStartTrigger;
reg 		rHsValid;
reg 		rStopState;
reg 		rClkActiveHs;
reg 		rSkewCalHs;
reg 		rActiveHs;
reg 		rSkewCalHs;
reg 		rErrSotHs;
reg 		rErrSotSyncHs;
reg [7:0] 	rRxLaneData0, rRxLaneData1;
reg [15:0]	rValidCnt;
reg 		rHsClk;

always @(posedge iMipiDphyRx1_WORD_CLKOUT_HS, negedge inSRST)
begin
	if (!inSRST)	rHsClk <= 1'b0;
	else 			rHsClk <= ~rHsClk;

	if (!inSRST)	rHsStartTrigger <= 1'b0;
	else 			rHsStartTrigger <= iMipiDphyRx1_RX_SYNC_HS_LAN0;

	if (!inSRST)	rRxLaneData0 	<= 8'b0;
	else 			rRxLaneData0 	<= iMipiDphyRx1_RX_DATA_HS_LAN0;

	if (!inSRST)	rRxLaneData1 	<= 8'b0;
	else 			rRxLaneData1 	<= iMipiDphyRx1_RX_DATA_HS_LAN1;

	if (!inSRST)	rHsValid 		<= 1'b0;
	else 			rHsValid 		<= iMipiDphyRx1_RX_VALID_HS_LAN0;

	if (!inSRST)	rStopState		 <= 1'b0;
	else 			rStopState		 <= iMipiDphyRx1_STOPSTATE_LAN0;

	if (!inSRST)	rClkActiveHs 	<= 1'b0;
	else 			rClkActiveHs 	<= iMipiDphyRx1_RX_CLK_ACTIVE_HS;

	if (!inSRST)	rActiveHs <= 1'b0;
	else 			rActiveHs <= iMipiDphyRx1_RX_ACTIVE_HS_LAN0;

	if (!inSRST)	rSkewCalHs <= 1'b0;
	else 			rSkewCalHs <= iMipiDphyRx1_RX_SKEW_CAL_HS_LAN0;

	if (!inSRST)	rErrSotHs <= 1'b0;
	else 			rErrSotHs <= iMipiDphyRx1_ERR_SOT_HS_LAN0;

	if (!inSRST)	rErrSotSyncHs <= 1'b0;
	else 			rErrSotSyncHs <= iMipiDphyRx1_RX_ERR_SYNC_ESC;

	if (!inSRST)	rValidCnt <= 16'd0;
	else if (iMipiDphyRx1_RX_VALID_HS_LAN0)	rValidCnt <= rValidCnt + 1'b1;
	else 									rValidCnt <= 16'd0;
end

/*
ハード D-PHY 信号メモ

MipiDphyRx1_WORD_CLKOUT_HS
HS モードのクロックドメイン、データの開始前と終了後まで持続する

MipiDphyRx1_RX_SYNC_HS_LAN0
HS モードで、有効データ入力時に開始として立ち上がりされる

MipiDphyRx1_RX_VALID_HS_LAN0
HS モードで、Packet Header, Packet Data, Packet Footer の
出力期間中に Assert される信号

MipiDphyRx1_STOPSTATE_LAN1
WORD_CLKOUT_HS シーケンス開始時(CLK 立ち上がり)に Dissert され、
VALID の Dissert と同時に Assert される。
HS モードの終了を検出可能。

MipiDphyRx1_RX_CLK_ACTIVE_HS
WORD_CLKOUT_HS 駆動中に Assert され続ける信号

MipiDphyRx1_RX_ACTIVE_HS_LAN0
VALID 期間中 Assert され続ける信号

*/

endmodule