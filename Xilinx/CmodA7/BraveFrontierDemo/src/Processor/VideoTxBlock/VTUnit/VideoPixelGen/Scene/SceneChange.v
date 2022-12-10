/*
Create 2022/12/04
Author koutakimura
-
シーンチェンジ用のピクセルデータを生成する
※シーンチェンジとはマップ間移動時の 暗転・明転処理などのこと

例えば 30fps 毎に 黒画面で徐々に暗転させる場合は下記設定にする。
iSceneFrameTiming 	= 30
iSceneFrameAddEn  	= 1
iSceneFrameRst		= 1

設定後 Alpha 値が 0 から F になると、oSceneAlphaMax が Assert される。
Host は 通知を読み取り命令に応じて下記設定にする。
iSceneFrameTiming 	= 30
iSceneFrameAddEn  	= 0
iSceneFrameSubEn  	= 1
iSceneFrameRst		= 1


設定後 Alpha 値が F から 0 になると、oSceneAlphaMin が Assert される。
Host は 通知を読み取り命令に応じて下記設定にする。
iSceneFrameRst		= 0
*/
module SceneChange #(
	parameter								pColorDepth		= 16,
	parameter 								pFifoDepth		= 16,
	parameter 								pFifoBitWidth	= 16,
	// not
	parameter								pRGBBitWidth 	= pColorDepth / 4,		// ARGB 一つの要素の Bit幅
	parameter								pAlphaBitMsb 	= pColorDepth - 1,
	parameter								pAlphaBitLsb 	= pColorDepth - (pColorDepth / 4),
	parameter	[pColorDepth-1:0]			pAlphaNum	 	= 1 << pAlphaBitLsb
)(
	// Internal Port
	input 									iFe,				// frame end
	//
	input 									iEds,				// Enable Data Src
	output 									oFull,				// FIFO Full
    output 	[pColorDepth-1:0]    			oDd,				// Dest Data
	output 									oVdd,				// Valid Dest Data 
	input 									iEdd,				// Enable Data Dest
	output 									oEmp,				// FIFO Empty
	// Csr
    input	[pColorDepth-1:0]				iSceneColor,		// 描画色
	input 	[6:0]							iSceneFrameTiming,	// SceneChange の更新速度,fps基準
	input 									iSceneFrameAddEn,	// SceneChange Add Start
	input 									iSceneFrameSubEn,	// SceneChange Sub Start
    input 									iSceneFrameRst,
	output									oSceneAlphaMax,
	output 									oSceneAlphaMin,
	// Clk rst
	input 									iRst,
    input                       			iClk
);


//-----------------------------------------------------------------------------
// 設定データに基づき、暗転処理を行う。
//-----------------------------------------------------------------------------
reg [pColorDepth-1:0] 	rScenePixel;
reg 					rSceneAlphaMax;					assign oSceneAlphaMax 	= rSceneAlphaMax;
reg 					rSceneAlphaMin;					assign oSceneAlphaMin 	= rSceneAlphaMin;
reg [6:0]				rFeCnt;
reg 					qFrameUpdateEn;
reg 					rWe, 			qWeCke;
reg 					qAlphaMax;
reg 					qAlphaMin;
//
wire [pColorDepth-1:0] 	wColorAdd = rScenePixel + pAlphaNum;
wire [pColorDepth-1:0] 	wColorSub = rScenePixel - pAlphaNum;

always @(posedge iClk)
begin
	casex ({iSceneFrameRst, qFrameUpdateEn, iFe, qAlphaMin, qAlphaMax, iSceneFrameSubEn, iSceneFrameAddEn})
		'b1x_x_xx_xx:	rScenePixel <= iSceneColor;
		'b01_1_x0_x1:	rScenePixel <= wColorAdd;
		'b01_1_0x_1x:	rScenePixel <= wColorSub;
		default: 		rScenePixel <= rScenePixel;
	endcase

	casex ({iSceneFrameRst, qFrameUpdateEn, iFe, iSceneFrameSubEn, iSceneFrameAddEn})
		'b1_x_x_xx:		rFeCnt <= 8'd0;
		'b0_1_1_xx:		rFeCnt <= 8'd0;
		'b0_0_1_x1:		rFeCnt <= rFeCnt + 1'b1;
		'b0_0_1_1x:		rFeCnt <= rFeCnt + 1'b1;
		default:	 	rFeCnt <= rFeCnt;
	endcase

	if (iSceneFrameRst)	rWe <= 1'b0;
	else if (qWeCke)	rWe <= 1'b1;
	else 				rWe <= 1'b0;

	// CSR 保存用にレジスタ出力
	rSceneAlphaMax	<= qAlphaMax;
	rSceneAlphaMin	<= qAlphaMin;
end

always @*
begin
	qWeCke			<= |{iSceneFrameSubEn, iSceneFrameAddEn} & iEds;
	qFrameUpdateEn 	<= (rFeCnt == iSceneFrameTiming);
	qAlphaMax		<= (rScenePixel[pAlphaBitMsb:pAlphaBitLsb] == 4'd15);
	qAlphaMin		<= (rScenePixel[pAlphaBitMsb:pAlphaBitLsb] == 4'd0);
end

//-----------------------------------------------------------------------------
// 他の DotGenerator とタイミングを合わせるため FIFO 経由で出力データの制御を行う
//-----------------------------------------------------------------------------
fifoController #(
	.pFifoDepth		(pFifoDepth),
	.pFifoBitWidth	(pFifoBitWidth)
) InstDotSquareFifo (
	// src side
	.iWd			(rScenePixel),
	.iWe			(rWe),
	.oFull			(oFull),
	// dst side
	.oRd			(oDd),
	.oRvd			(oVdd),
	.iRe			(iEdd),
	.oEmp			(oEmp),
	//
	.iRst			(iRst),
	.iClk			(iClk)
);

endmodule