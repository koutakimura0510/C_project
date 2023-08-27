/*-----------------------------------------------------------------------------
 * 1pixel毎の描画データ生成
 *
 * 23-08-23 v1.00 : new release
 * 
 * -
 * レイヤーの並び順は下記の通りである。
 * Field		:ワールドマップ・フィールドマップ
 * NPC			:プレイヤー以外のキャラクター
 * Player		:操作キャラクター
 * Object		:宝箱などのオブジェクトと、滝の裏側など通過できるフィールドのこと
 * Field2		:ドラクエ5 のエルヘブンのような立体感のあるマップを生成するのに必要
 * Effect		:戦闘エフェクト描画、フィールドエフェクトはない予定
 * Foreground	:前景、霧や光源など
 * Menu			:ウィンドウメニュー
 * Scene		:シーンチェンジ
 * 
 *-----------------------------------------------------------------------------*/
module VideoPixelGenUnit #(
	// Display Size
    parameter	pVHA = 480,
    parameter	pVVA = 272,
	parameter	pVHAW = 11,		// 11bit だと FHD まで
	parameter	pVVAW = 11,
	// Color Depth
	parameter	pColorDepth = 16,
	// non valiable
	parameter	pOutColorDepth = pColorDepth - (pColorDepth / 4) // alpha値を除いたbit幅
)(
	// Csr SceneChange
    input	[pColorDepth-1:0]	iSceneColor,
	input	[6:0]	iSceneFrameTiming,
	input 	iSceneFrameAddEn,
	input 	iSceneFrameSubEn,
    input 	iSceneFrameRst,
	output	oSceneAlphaMax,
	output 	oSceneAlphaMin,
	// Fifo I/F
	output	[pColorDepth-1:0] oRd,
	input	iRe,
    output	oRvd,
	output  oEmp,
    // CLK Reset
    input	iRST,
    input	inRST,
    input	iCLK
);


//-----------------------------------------------------------------------------
// 横幅 480 の場合、0 ~ 479 の範囲を使用するため、設定値から -1 する
//-----------------------------------------------------------------------------
localparam [pVHAW-1:0] lpVHA = pVHA - 1;
localparam [pVVAW-1:0] lpVVA = pVVA - 1;


//-----------------------------------------------------------------------------
// Dst Side FIFO
// module の出力部分を FIFO I/F にすることで扱いやすくする目的
//-----------------------------------------------------------------------------
localparam lpPdfDepth 		= 512;
localparam lpPdfBitWidth 	= pColorDepth;

reg  [lpPdfBitWidth-1:0]	qPdfWd;
reg		qPdfWe;
wire	wPdfFull;
wire [lpPdfBitWidth-1:0]	wPdfRd;
wire 	wPdfRvd;
reg  	qPdfRe;
wire 	wPdfEmp;

SyncFifoController #(
	.pFifoDepth(lpPdfDepth),
	.pFifoBitWidth(lpPdfBitWidth)
) PixelDstFifo (
	// write
	.iWd(qPdfWd),		.iWe(qPdfWe),
	.oFull(wPdfFull),
	.oRemaingCntAlert(),
	// read
	.oRd(wPdfRd),		.iRe(qPdfRe),
	.oRvd(wPdfRvd),		.oEmp(wPdfEmp),
	// common
	.inARST(inRST),		.iCLK(iCLK)
);

always @*
begin
	qPdfRe <= iRe;
end

assign oRd  = wPdfRd;
assign oRvd = wPdfRvd;
assign oEmp = wPdfEmp;

//-----------------------------------------------------------------------------
// PixelDrawPosition(Pdp)
//-----------------------------------------------------------------------------
wire [pVHAW-1:0] 	wPdpHpos;
wire [pVVAW-1:0] 	wPdpVpos;
wire [pVHAW-1:4] 	wPdpHposBs;
wire [pVVAW-1:4] 	wPdpVposBs;
wire 	wPdpFe;
reg		qPdpCke;

PixelDrawPosition #(
	.pVHAW(pVHAW),
	.pVVAW(pVVAW),
	.pMapChipBasicBs(4)
) PixelDrawPosition (
	// Vide Para Input
	.iVha(lpVHA),			.iVva(lpVVA),
	// Video Pos Output
	.oHpos(wPdpHpos),		.oVpos(wPdpVpos),
	.oHposBs(wPdpHposBs),	.oVposBs(wPdpVposBs),
	.oFeFast(wPdpFe),
	// Common
	.iRST(iRST),	.iCKE(1'b1),	.iCLK(iCLK)
);

//-----------------------------------------------------------------------------
// Demo
//-----------------------------------------------------------------------------
DotSquareGen #(
	.pVHAW(pVHAW),
	.pVVAW(pVVAW),
	.pColorDepth(pColorDepth)
) DotSquareGen (
	.oPixel(oPixel),
	.iColor(16'hffff),
	.iHpos(wPdpHpos),
	.iVpos(wPdpVpos),
	.iDLeftX(1),
	.iDRightX(33),
	.iDTopY(272-1-32),
	.iDUnderY(272-1)
);

//-----------------------------------------------------------------------------
// キャラクター(Player,NPC)の座標データ算出
//-----------------------------------------------------------------------------
// DrawUnitPosInfo (

// ) DrawUnitPosInfo (

// );


//-----------------------------------------------------------------------------
// MapIdInfo の取得・更新
// TODO MCB に移動する
//-----------------------------------------------------------------------------
// wire [7:0] wInfoFieldId;
// wire [7:0] wInfoObjectId;
// wire [7:0] wInfoField2Id;
// wire [7:0] wInfoForegroundId;

// DrawMapIdInfo #(
// 	.pMapSizeWidth			(pMapXSizeMax),
// 	.pMapIdWidth			(pMapIdWidth),
// 	.pMapInfoNumber			(4)
// ) DrawMapIdInfo (
// 	.iMapInfoWd				(wSUfiWd),
// 	.iMapInfoWAdrs			(wSUfiAdrs),
// 	.iMapInfoCke			(wSUfiWEd[lpBramMap]),
// 	.oInfoFieldId			(wInfoFieldId),
// 	.oInfoObjectId			(wInfoObjectId),
// 	.oInfoField2Id			(wInfoField2Id),
// 	.oInfoForegroundId		(wInfoForegroundId),
// 	.iRST					(iRST),
// 	.iCLK					(iCLK)
// );


//-----------------------------------------------------------------------------
// 制約が必要そうではある。
// BRAM を cache 扱いとしないと、RAM へのアクセス時間が足りなさそう。
// 16 x 16 x 16 = 4096
// 4096 * 8 = 32768 , 36kB に収まる
// ドラクエ方式として、上下左右の右足左足で 合計 8マップチップのため収まりそう。
// 
// 格納可能なマップチップ数が 8 個ならば、1マップ(または 1画面)で、
// 各レイヤーの使用できるマップチップ最大個数を決める必要がある。
// 
// ※ 上記タイル方式はボツとする。MCB 内でマップIDを取得し、IDによって RAM
// に格納されている マップチップのアドレスを計算・取得する。
// 1 Line の描画データを各 BRAM に割り振りを行う。
// BRAM は 4Line 格納可能である。
// 
// ※ 更に上記方法をやめて、やっぱりマップチップ読み込み方式で行うことにした。
// 16Byte 小刻みに読み込むのは レイテンシが悪すぎる。
//-----------------------------------------------------------------------------
//-----------------------------------------------------------------------------
// Field Draw
//-----------------------------------------------------------------------------
// DrawFieldMapchip (

// ) DrawFieldMapchip (

// );


//-----------------------------------------------------------------------------
// NPC Draw
//-----------------------------------------------------------------------------
//-----------------------------------------------------------------------------
// Player Draw (以降 PD)
// 気づいたが、Dot データは BRAM に格納されているので、
// Enable を Assert すればタイミング制御は容易なのではと思う。
//-----------------------------------------------------------------------------
// wire [pColorDepth-1:0] 	wPlayerDrawDd;

// PlayerDraw #(
// 	.pInitFileName			(pInitFileName),
// 	.pColorDepth			(pColorDepth),
// 	.pRamDepth				(pMapChipRamDepth)
// ) PlayerDraw (
// 	.oPixel					(wPlayerDrawDd),
// 	.iPlayerPixelWd			({pColorDepth{1'b0}}),
// 	.iPlayerPixelWe			(1'b0),
// 	.iFe					(wAFe),
// 	.iPlayerDrawVd			(),
// 	.iSrcEn					(),
// 	.iPDFeUpdateCnt			(iPDFeUpdateCnt),
// 	.iPDRadrsNext			(iPDRadrsNext),
// 	.iPDRst					(iPDRst),
// 	.oPDFeCntCke			(oPDFeCntCke),
// 	.iRST					(iRST),
// 	.iCLK					(iCLK)
// );


//-----------------------------------------------------------------------------
// Object Draw
//-----------------------------------------------------------------------------
//-----------------------------------------------------------------------------
// Effect Draw
//-----------------------------------------------------------------------------
//-----------------------------------------------------------------------------
// Foreground Draw
//-----------------------------------------------------------------------------
//-----------------------------------------------------------------------------
// Menu Draw
//-----------------------------------------------------------------------------
//-----------------------------------------------------------------------------
// Scene Draw
//-----------------------------------------------------------------------------
// wire [pColorDepth-1:0] 	wSceneChangeDd;

// SceneChange #(
// 	.pColorDepth		(pColorDepth)
// ) SceneChange (
// 	.iFe				(wAFe),
// 	//
// 	.oPixel				(wSceneChangeDd),
// 	//
// 	.iSceneColor		(iSceneColor),
// 	.iSceneFrameTiming	(iSceneFrameTiming),
// 	.iSceneFrameAddEn	(iSceneFrameAddEn),
// 	.iSceneFrameSubEn	(iSceneFrameSubEn),
// 	.iSceneFrameRst		(iSceneFrameRst),
// 	.oSceneAlphaMax		(oSceneAlphaMax),
// 	.oSceneAlphaMin		(oSceneAlphaMin),
// 	//
// 	.iRST				(iRST),
// 	.iCLK				(iCLK)
// );

//-----------------------------------------------------------------------------
// デモンストレーション
//-----------------------------------------------------------------------------
// localparam 				lpVpgDemoGenFifoDepth = 512;
// //
// reg 					qVpgDemoEds;
// wire 					wVpgDemoFull;
// wire [pColorDepth-1:0] 	wVpgDemoDd;
// wire 					wVpgDemoVdd;
// reg  					qVpgDemoEdd;
// wire 					wVpgDemoEmp;

// VpgDemo #(
// 	.pHdisplayWidth		(pHdisplayWidth),
// 	.pVdisplayWidth		(pVdisplayWidth),
// 	.pColorDepth		(pColorDepth),
// 	.pFifoDepth			(lpVpgDemoGenFifoDepth),
// 	.pFifoBitWidth		(pColorDepth)
// ) VpgDemo (
// 	.iHdisplay			(wHdisplay),
// 	.iVdisplay			(wVdisplay),
// 	.iHpos				(wPdpHpos),
// 	.iVpos				(wPdpVpos),
// 	.iFe				(wAFe),
// 	//
// 	.iColor				(16'hf0f0),
// 	.iEds 				(qVpgDemoEds),
// 	.oFull				(wVpgDemoFull),
// 	.oDd				(wVpgDemoDd),
// 	.oVdd				(wVpgDemoVdd),
// 	.iEdd				(qVpgDemoEdd),
// 	.oEmp				(wVpgDemoEmp),
// 	.iRST				(iRST),
// 	.iCLK				(iCLK)
// );

// always @*
// begin
// 	qVpgDemoEds				<= (~wVpgDemoFull);	// 自身の FIFO が満杯でなければデータ保存
// 	qPdpCke 	<= (~wVpgDemoFull);
// end


// //-----------------------------------------------------------------------------
// // Final Stage ドットデータを結合し一つのピクセルデータに変換する
// // 前段と後段から要求される制御信号は、異なる CLK ドメインによるレイテンシの違いが発生するため、
// // pFifoFastOutValue パラメータで調整を行う。
// // このとき、FIFO Depth のパラメータ設定には十分余裕を持つこととする。
// //-----------------------------------------------------------------------------
// localparam lpDotMargeToPixelConverterFifoDepth = 512;

// wire [pOutColorDepth-1:0] wPixelMargeDd;		assign oPixel 	= wPixelMargeDd;
// wire  wPixelMargeVdd;							assign oWEd 	= wPixelMargeVdd;
// wire  wPixelMargeFull;
// wire  wPixelMargeEmp;
// reg   qPixelMargeEds;
// reg   qPixelMargeEdd;

// DotMargeToPixelConverter #(
// 	.pColorDepth		(pColorDepth),
// 	.pFifoDepth			(lpDotMargeToPixelConverterFifoDepth),
// 	.pFifoBitWidth		(pOutColorDepth),
// 	.pFifoFastOutValue	(10)
// ) DotMargeToPixelConverter (
// 	.iField				({pColorDepth{1'b0}}),
// 	.iNpc				({pColorDepth{1'b0}}),
// 	.iPlayer			({pColorDepth{1'b0}}),
// 	.iObject			({pColorDepth{1'b0}}),
// 	.iEffect1			({pColorDepth{1'b0}}),
// 	.iEffect2			({pColorDepth{1'b0}}),
// 	.iForeground		({pColorDepth{1'b0}}),
// 	.iMenuWindow		({pColorDepth{1'b0}}),
// 	.iVpgDemo 			(wVpgDemoDd),
// 	.iSceneChange		(wSceneChangeDd),
// 	//
// 	.iEds				(qPixelMargeEds),
// 	.oFull				(wPixelMargeFull),
// 	.oDd				(wPixelMargeDd),
// 	.oVdd				(wPixelMargeVdd),
// 	.iEdd				(qPixelMargeEdd),
// 	.oEmp				(wPixelMargeEmp),
// 	.iRST				(iRST),
// 	.iCLK				(iCLK)
// );

// always @*
// begin
// 	// 前段から Write Enable
// 	// 前段全ステージで データ転送が可能になった時のみ受け付ける
// 	qPixelMargeEds	<= wVpgDemoVdd;

// 	// 後段からの データ転送要求受付
// 	qPixelMargeEdd 	<= (~wPixelMargeEmp) & iEdd;

// 	// 前段 にデータ受付許可発行
// 	qVpgDemoEdd		<= (~wPixelMargeFull);
// end

endmodule

//-----------------------------------------------------------------------------
// endmodule
//-----------------------------------------------------------------------------