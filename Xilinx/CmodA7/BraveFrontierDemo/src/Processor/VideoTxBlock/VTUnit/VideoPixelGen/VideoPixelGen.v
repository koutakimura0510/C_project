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
	// FIFO Depth
	parameter						pMapChipRamDepth	= 2048,	// 色サイズに対応した BRAM の最大深さ
	parameter						pMapChipRamWidth	= 10,
	// non valiable
	parameter						pOutColorDepth		= pColorDepth - (pColorDepth / 4) // alpha値を除いたbit幅
)(
	// Internal Port
	// Vtb Slave Side
	input [pUfiBusWidth-1:0] 		iSUfiWd,	// 書き込みデータ
	input [pBusAdrsBit-1:0] 		iSUfiAdrs,	// 書き込みアドレス
	input 							iSUfiWEd,	// 書き込み命令
	// Csr Display
	input	[pHdisplayWidth-1:0]	iHdisplay,
	input	[pVdisplayWidth-1:0]	iVdisplay,
	// input	[7:0]					iMapXSize,
	// input	[7:0]					iMapYSize,
	// Csr SceneChange
    input	[pColorDepth-1:0]		iSceneColor,
	input 	[6:0]					iSceneFrameTiming,
	input 							iSceneFrameAddEn,
	input 							iSceneFrameSubEn,
    input                     		iSceneFrameRst,
	output							oSceneAlphaMax,
	output 							oSceneAlphaMin,
	// Csr Player Draw
	input 	[6:0]					iPDFeUpdateCnt,
	input 	[pMapChipRamWidth-1:0]	iPDRadrsNext,
	input 							iPDRst,
	output 							oPDFeCntCke,
	// 2nd Stage Output
	output	[pOutColorDepth-1:0]	oPixel,
    output                       	oWEd,
	input 							iEdd,
    // CLK Reset
    input           				iRst,
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
//-----------------------------------------------------------------------------
// localparam lpUfiAllocationNum = 9;	// 割り振り先の BRAM の個数
// localparam
// 	lpBramMap	= 0,
// 	lpBram1		= 1,
// 	lpBram2		= 2,
// 	lpBram3		= 3,
// 	lpBram4		= 4,
// 	lpBram5		= 5,
// 	lpBram6		= 6,
// 	lpBram7		= 7;
// 	lpBram8		= 8;

// wire [pUfiBusWidth-1:0] 		wSUfiWd;
// wire [pBusAdrsBit-1:0] 			wSUfiAdrs;
// wire [lpUfiAllocationNum-1:0] 	wSUfiWEd;

// SlaveUfiAllocation #(
// 	.pUfiBusWidth				(pUfiBusWidth),
// 	.pBusAdrsBit				(pBusAdrsBit),
// 	.pUfiAllocationNum			(lpUfiAllocationNum)
// ) SlaveUfiAllocation (
// 	.iSUfiWd					(iSUfiWd),
// 	.iSUfiWAdrs					(iSUfiAdrs),
// 	.iSUfiWEd					(iSUfiWEd),
// 	.oSUfiWd					(wSUfiWd),
// 	.oSUfiAdrs					(wSUfiAdrs),
// 	.oSUfiWEd					(wSUfiWEd),
//     .iClk						(iClk)
// );


//-----------------------------------------------------------------------------
// Draw Module で共通利用する内部で高速な描画座標の生成
//-----------------------------------------------------------------------------
wire [pHdisplayWidth-1:0] 	wPixelDrawHpos;
wire [pVdisplayWidth-1:0] 	wPixelDrawVpos;
wire [pHdisplayWidth-1:4] 	wInfoHposBs;
wire [pVdisplayWidth-1:4] 	wInfoVposBs;
wire 						wAFe;
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
	.oAFE					(wAFe),
	.iRst					(iRst),
	.iCke					(qPixelDrawPositionCke),
	.iClk					(iClk)
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
// 	.iRst					(iRst),
// 	.iClk					(iClk)
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
wire [pColorDepth-1:0] 	wPlayerDrawDd;

PlayerDraw #(
	.pInitFileName			(pInitFileName),
	.pColorDepth			(pColorDepth),
	.pRamDepth				(pMapChipRamDepth)
) PlayerDraw (
	.oPixel					(wPlayerDrawDd),
	.iPlayerPixelWd			({pColorDepth{1'b0}}),
	.iPlayerPixelWe			(1'b0),
	.iFe					(wAFe),
	.iPlayerDrawVd			(),
	.iSrcEn					(),
	.iPDFeUpdateCnt			(iPDFeUpdateCnt),
	.iPDRadrsNext			(iPDRadrsNext),
	.iPDRst					(iPDRst),
	.oPDFeCntCke			(oPDFeCntCke),
	.iRst					(iRst),
	.iClk					(iClk)
);


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
wire [pColorDepth-1:0] 	wSceneChangeDd;

SceneChange #(
	.pColorDepth		(pColorDepth)
) SceneChange (
	.iFe				(wAFe),
	//
	.oPixel				(wSceneChangeDd),
	//
	.iSceneColor		(iSceneColor),
	.iSceneFrameTiming	(iSceneFrameTiming),
	.iSceneFrameAddEn	(iSceneFrameAddEn),
	.iSceneFrameSubEn	(iSceneFrameSubEn),
	.iSceneFrameRst		(iSceneFrameRst),
	.oSceneAlphaMax		(oSceneAlphaMax),
	.oSceneAlphaMin		(oSceneAlphaMin),
	//
	.iRst				(iRst),
	.iClk				(iClk)
);

//-----------------------------------------------------------------------------
// デモンストレーション
//-----------------------------------------------------------------------------
localparam 				lpVpgDemoGenFifoDepth = 512;
//
reg 					qVpgDemoEds;
wire 					wVpgDemoFull;
wire [pColorDepth-1:0] 	wVpgDemoDd;
wire 					wVpgDemoVdd;
reg  					qVpgDemoEdd;
wire 					wVpgDemoEmp;

VpgDemo #(
	.pHdisplayWidth		(pHdisplayWidth),
	.pVdisplayWidth		(pVdisplayWidth),
	.pColorDepth		(pColorDepth),
	.pFifoDepth			(lpVpgDemoGenFifoDepth),
	.pFifoBitWidth		(pColorDepth)
) VpgDemo (
	.iHdisplay			(wHdisplay),
	.iVdisplay			(wVdisplay),
	.iHpos				(wPixelDrawHpos),
	.iVpos				(wPixelDrawVpos),
	.iFe				(wAFe),
	//
	.iColor				(16'hf0f0),
	.iEds 				(qVpgDemoEds),
	.oFull				(wVpgDemoFull),
	.oDd				(wVpgDemoDd),
	.oVdd				(wVpgDemoVdd),
	.iEdd				(qVpgDemoEdd),
	.oEmp				(wVpgDemoEmp),
	.iRst				(iRst),
	.iClk				(iClk)
);

always @*
begin
	qVpgDemoEds				<= (~wVpgDemoFull);	// 自身の FIFO が満杯でなければデータ保存
	qPixelDrawPositionCke 	<= (~wVpgDemoFull);
end


//-----------------------------------------------------------------------------
// Final Stage ドットデータを結合し一つのピクセルデータに変換する
// 前段と後段から要求される制御信号は、異なる CLK ドメインによるレイテンシの違いが発生するため、
// pFifoFastOutValue パラメータで調整を行う。
// このとき、FIFO Depth のパラメータ設定には十分余裕を持つこととする。
//-----------------------------------------------------------------------------
localparam lpDotMargeToPixelConverterFifoDepth = 512;

wire [pOutColorDepth-1:0] wPixelMargeDd;		assign oPixel 	= wPixelMargeDd;
wire  wPixelMargeVdd;							assign oWEd 	= wPixelMargeVdd;
wire  wPixelMargeFull;
wire  wPixelMargeEmp;
reg   qPixelMargeEds;
reg   qPixelMargeEdd;

DotMargeToPixelConverter #(
	.pColorDepth		(pColorDepth),
	.pFifoDepth			(lpDotMargeToPixelConverterFifoDepth),
	.pFifoBitWidth		(pOutColorDepth),
	.pFifoFastOutValue	(10)
) DotMargeToPixelConverter (
	.iField				({pColorDepth{1'b0}}),
	.iNpc				({pColorDepth{1'b0}}),
	.iPlayer			({pColorDepth{1'b0}}),
	.iObject			({pColorDepth{1'b0}}),
	.iEffect1			({pColorDepth{1'b0}}),
	.iEffect2			({pColorDepth{1'b0}}),
	.iForeground		({pColorDepth{1'b0}}),
	.iMenuWindow		({pColorDepth{1'b0}}),
	.iVpgDemo 			(wVpgDemoDd),
	.iSceneChange		(wSceneChangeDd),
	//
	.iEds				(qPixelMargeEds),
	.oFull				(wPixelMargeFull),
	.oDd				(wPixelMargeDd),
	.oVdd				(wPixelMargeVdd),
	.iEdd				(qPixelMargeEdd),
	.oEmp				(wPixelMargeEmp),
	.iRst				(iRst),
	.iClk				(iClk)
);

always @*
begin
	// 前段から Write Enable
	// 前段全ステージで データ転送が可能になった時のみ受け付ける
	qPixelMargeEds	<= wVpgDemoVdd;

	// 後段からの データ転送要求受付
	qPixelMargeEdd 	<= (~wPixelMargeEmp) & iEdd;

	// 前段 にデータ受付許可発行
	qVpgDemoEdd		<= (~wPixelMargeFull);
end

endmodule

//-----------------------------------------------------------------------------
// endmodule
//-----------------------------------------------------------------------------