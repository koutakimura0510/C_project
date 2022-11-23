//----------------------------------------------------------
// Create 2022/8/30
// Author koutakimura
// -
// 1pixel毎の描画データ生成
// キャラクターの座標データ生成と module を分けるか悩んだが
// 座標データは Pixel 描画に必要な info とみなし同じ module で管理することとした。
// 
// 
// ※ Zynq プロジェクト時の考え方の違いがある。
// ソフトで座標やアニメーション表現したときは、インターバルタイマー関数や
// PL 部でカウントしているカウント値を読んで「時間」で処理の決定を行っていたが、
// 今回からは 1Frame 単位で処理を行う。
// こうしないと指定の FPS が出ているか確認できないし、時間だとタイミングが正しいのか分からなくなる。
// 「秒数を計測して処理をさせる」は制限時間などに用いて、描画には極力用いないこと。
// -
// レイヤーの並び順は下記の通りである。
// 
// ・Field:フィールド
// 		ワールドマップ・フィールドマップ
// 
// ・NPC:NPC
// 		プレイヤー以外のキャラクター
// 
// ・Player:プレイヤー
// 		操作キャラクター
// 
// ・Object:前オブジェクト
// 		宝箱などのオブジェクトと、滝の裏側など通過できるフィールドのこと
// 
// ・Field2:
// 		ドラクエ5 のエルヘブンのような立体感のあるマップを生成するのに必要
// 
// ・Effect:エフェクト
// 		戦闘エフェクト描画、フィールドエフェクトはない予定
// 
// ・Foreground:前景
// 		霧や光源など
// 
// ・Menu:メニュー
// 		ウィンドウメニュー
// 
// ・Scene:シーン
// 		シーンチェンジ
// 
// module を平行に並べるため、一番レイテンシが大きいブロックで処理速度が決定する。
// 
//----------------------------------------------------------
module VideoPixelGen #(
	// Ufi
	parameter						pUfiBusWidth		= 16,
	parameter						pBusAdrsBit			= 16,
	// Display Size
    parameter       				pHdisplayWidth		= 11,	// 11bit だと FHD まで
    parameter       				pVdisplayWidth		= 11,
	// Map Info
	parameter						pMapXSizeMax		= 250,
	parameter						pMapIdWidth			= 8,
	// MapChip
	parameter						pMapChipBasicSize	= 16,
	parameter						pMapChipBasicBs		= 4,	// pMapChipBasicSize の サイズで Bit Shiftした時の 幅
	// Color Depth
	parameter						pColorDepth			= 16,
	// non valiable
	parameter						pOutColorDepth		= pColorDepth - (pColorDepth / 4) // alpha値を除いたbit幅
)(
	// Internal Port
	// Vtb Slave Side
	input [pUfiBusWidth-1:0] 		iSUfiWd,	// 書き込みデータ
	input [pBusAdrsBit-1:0] 		iSUfiAdrs,	// 書き込みアドレス
	input 							iSUfiWEd,	// 書き込み命令
	// Csr Input
	input	[pHdisplayWidth-1:0]	iHdisplay,
	input	[pVdisplayWidth-1:0]	iVdisplay,
	// Csr Map Info
	input	[7:0]					iMapXSize,
	input	[7:0]					iMapYSize,
	// 2nd Stage Output
	output	[pOutColorDepth-1:0]	oPixel,
    output                       	oWEd,
    // CLK Reset
    input           				iRst,
	input 							iCke,
    input           				iClk
);


//-----------------------------------------------------------------------------
// Csr レジスタ入力値を配線遅延など考慮して一度レジスタで受信する
// 横幅 480 の場合、0 ~ 479 の範囲を使用するため、設定値から -1 した値を各 module で利用する
//-----------------------------------------------------------------------------
reg	[pHdisplayWidth-1:0] rHdisplay;
reg	[pVdisplayWidth-1:0] rVdisplay;
wire[pHdisplayWidth-1:0] wHdisplay;		assign wHdisplay = rHdisplay;
wire[pVdisplayWidth-1:0] wVdisplay;		assign wVdisplay = rVdisplay;

initial
begin
	rHdisplay = {pHdisplayWidth{1'b0}};
	rVdisplay = {pVdisplayWidth{1'b0}};
end

always @(posedge iClk)
begin
	rHdisplay <= iHdisplay - 1'b1;
	rVdisplay <= iVdisplay - 1'b1;
end


//-----------------------------------------------------------------------------
// 書き込みデータの割り振り
// BRAM の個数
//-----------------------------------------------------------------------------
localparam lpUfiAllocationNum = 9;

SlaveUfiAllocation #(
	.pUfiBusWidth		(pUfiBusWidth),
	.pBusAdrsBit		(pBusAdrsBit),
	.pUfiAllocationNum	(lpUfiAllocationNum)
) SlaveUfiAllocation (
	.iSUfiWd			(iSUfiWd),
	.iSUfiWAdrs			(iSUfiAdrs),
	.iSUfiWEd			(iSUfiWEd),
	.oSUfiWd			(wSUfiWd),
	.oSUfiAdrs			(wSUfiAdrs),
	.oSUfiWEd			(wSUfiWEd)
);


//-----------------------------------------------------------------------------
// Draw Module で共通利用する内部で高速な描画座標の生成
//-----------------------------------------------------------------------------
wire [pHdisplayWidth-1:0] 	wPixelDrawHpos;
wire [pVdisplayWidth-1:0] 	wPixelDrawVpos;
wire [pHdisplayWidth-1:4] 	wInfoHposBs;
wire [pVdisplayWidth-1:4] 	wInfoVposBs;
wire 						wAFE;
reg 						qPixelDrawPositionCke;

PixelDrawPosition #(
	.pHdisplayWidth			(pHdisplayWidth),
	.pVdisplayWidth			(pVdisplayWidth),
	.pMapChipBasicBs		(pMapChipBasicBs)
) PixelDrawPosition (
	.iHdisplay				(wHdisplay),
	.iVdisplay				(wVdisplay),
	.oHpos					(wPixelDrawHpos),
	.oVpos					(wPixelDrawVpos),
	.oHposBs				(wInfoHposBs),
	.oVposBs				(wInfoVposBs),
	.oAFE					(wAFE),
	.iRst					(iRst),
	.iCke					(qPixelDrawPositionCke),
	.iClk					(iClk)
);


//-----------------------------------------------------------------------------
// キャラクター(Player,NPC)の座標データ算出
//-----------------------------------------------------------------------------
DrawUnitPosInfo (

) DrawUnitPosInfo (

);


//-----------------------------------------------------------------------------
// MapIdInfo の取得・更新
//-----------------------------------------------------------------------------
DrawMapIdInfo #(
	.pMapSizeWidth		(pMapXSizeMax),
	.pMapIdWidth		(pMapIdWidth),
	.pMapInfoNumber		(4)
) DrawMapIdInfo (
	.iMapInfoWd			(iMapInfoWd),
	.iMapInfoCke		(iMapInfoCke),
	.iMapInfoVd			(iMapInfoVd),
	.iMapInfoRAdrs		(iMapInfoRAdrs),
	.oInfoFieldId		(oInfoFieldId),
	.oInfoObjectId		(oInfoObjectId),
	.oInfoField2Id		(oInfoField2Id),
	.oInfoForegroundId	(oInfoForegroundId),
	.iRst				(iRst),
	.iClk				(iClk)
);


//-----------------------------------------------------------------------------
// 制約が必要そうではある。
// BRAM を cache 扱いとしないと、RAM へのアクセス時間が足りなさそう。
// 16 x 16 x 16 = 4096
// 4096 * 8 = 32768 , 36kB に収まる
// ドラクエ方式として、上下左右の右足左足で 合計 8マップチップのため収まりそう。
//-----------------------------------------------------------------------------
//-----------------------------------------------------------------------------
// Field Draw
//-----------------------------------------------------------------------------
//-----------------------------------------------------------------------------
// NPC Draw
//-----------------------------------------------------------------------------
//-----------------------------------------------------------------------------
// Player Draw
//-----------------------------------------------------------------------------
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
localparam lpDotSquareGenFifoDepth = 16;
//
reg 					qDotSquareEds;
wire 					wDotSquareFull;
wire [pColorDepth-1:0] 	wDotSquareDd;
wire 					wDotSquareVdd;
reg  					qDotSquareEdd;
wire 					wDotSquareEmp;

SceneChange #(
	.pHdisplayWidth		(pHdisplayWidth),
	.pVdisplayWidth		(pVdisplayWidth),
	.pColorDepth		(pColorDepth),
	.pFifoDepth			(lpDotSquareGenFifoDepth),
	.pFifoBitWidth		(pColorDepth)
) SceneChange (
	.iColor				(16'h00f0),
	.iHdisplay			(wHdisplay),
	.iVdisplay			(wVdisplay),
	.iHpos				(wPixelDrawHpos),
	.iVpos				(wPixelDrawVpos),
	.iFe				(wAFE),
	.iEds 				(qDotSquareEds),
	.oFull				(wDotSquareFull),
	.oDd				(wDotSquareDd),
	.oVdd				(wDotSquareVdd),
	.iEdd				(qDotSquareEdd),
	.oEmp				(wDotSquareEmp),
	.iRst				(iRst),
	.iClk				(iClk)
);

always @*
begin
	qDotSquareEds			<= (~wDotSquareFull);
	qPixelDrawPositionCke 	<= (~wDotSquareFull);
end


//-----------------------------------------------------------------------------
// Final Stage ドットデータを結合し一つのピクセルデータに変換する
//-----------------------------------------------------------------------------
localparam lpDotMargeToPixelConverterFifoDepth = 16;

wire [pOutColorDepth-1:0] wPixelMargeDd;		assign oPixel = wPixelMargeDd;
wire  wPixelMargeVdd;							assign oWEd 	  = wPixelMargeVdd;
wire  wPixelMargeFull;
wire  wPixelMargeEmp;
reg   qPixelMargeEds;
reg   qPixelMargeEdd;

DotMargeToPixelConverter #(
	.pColorDepth	(pColorDepth),
	.pFifoDepth		(lpDotMargeToPixelConverterFifoDepth),
	.pFifoBitWidth	(pOutColorDepth)
) DotMargeToPixelConverter (
	.iDistantground	({pColorDepth{1'b0}}),
	.iBackground	(wDotSquareDd),
	.iField			({pColorDepth{1'b0}}),
	.iNpc			({pColorDepth{1'b0}}),
	.iPlayer		({pColorDepth{1'b0}}),
	.iObject		({pColorDepth{1'b0}}),
	.iEffect1		({pColorDepth{1'b0}}),
	.iEffect2		({pColorDepth{1'b0}}),
	.iForeground	({pColorDepth{1'b0}}),
	.iMenuWindow	({pColorDepth{1'b0}}),
	.iEds			(qPixelMargeEds),
	.oFull			(wPixelMargeFull),
	.oDd			(wPixelMargeDd),
	.oVdd			(wPixelMargeVdd),
	.iEdd			(qPixelMargeEdd),
	.oEmp			(wPixelMargeEmp),
	.iRst			(iRst),
	.iClk			(iClk)
);

always @*
begin
	qPixelMargeEds	<= wDotSquareVdd;
	qPixelMargeEdd 	<= (~wPixelMargeEmp) & iCke;
	qDotSquareEdd	<= (~wPixelMargeFull);
end


endmodule