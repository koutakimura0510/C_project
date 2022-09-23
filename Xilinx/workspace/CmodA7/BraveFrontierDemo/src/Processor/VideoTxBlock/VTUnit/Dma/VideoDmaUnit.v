//----------------------------------------------------------
// Create 2022/9/17
// Author koutakimura
// -
// 与えられたアドレスと読み込むデータの長さに応じて RAM にアクセスを行う
// 
//----------------------------------------------------------
module VideoDmaUnit #(
	parameter					pUfiBusWidth		= 16,
	parameter					pBusAdrsBit			= 32,
	parameter 					pMemAdrsWidth 		= 19,
	parameter					pFifoDepth			= 1024,
	// not variable
	parameter					pFifoBitWidth		= pUfiBusWidth
)(
    // Internal Port
	// Ufi Master Read
	input 	[pUfiBusWidth-1:0]	iMUfiRd,
	input 						iMUfiREd,
	// Ufi Master Write
	output	[pUfiBusWidth-1:0]	oMUfiWd,
	output 	[pBusAdrsBit-1:0]	oMUfiAdrs,
	output 						oMUfiWEd,
	output 						oMUfiREd,
	output 						oMUfiVd,
	output 						oMUfiCmd,	// High Read, Low Write
	// Ufi Master Common
	input						iMUfiRdy,
	//
	// DMA Write Side
	input 	[pUfiBusWidth-1:0]	iDmaWd,		// 前段の Write Data
	input  						iDmaWEd,
	output 						oDmaFull,
	// DMA Read Side
	output 	[pUfiBusWidth-1:0]	oDmaRd,		// 後段への Read Data
	output 						oDmaREd,	// DMA Read Valid Data
	input 						iDmaRe,		// DMA Read Enable Data
	//
	input [pMemAdrsWidth-1:0]	iFbufAdrs1,	// DMA 書き込み開始アドレス
	input [pMemAdrsWidth-1:0]	iFbufAdrs2,	// DMA 読み込み開始アドレス
	input [pMemAdrsWidth-1:0]	iFbufLen1,	// DMA 書き込み長さ
	input [pMemAdrsWidth-1:0]	iFbufLen2,	// DMA 読み込み長さ
	input 						iDmaEn,
    // CLK Reset
	input 						iRst,
	input 						iClk
);


//-----------------------------------------------------------------------------
// DMA を使用して UFIB 経由で RAM に書き込むデータを保持
// 前段のブロックとのタイミング調停も兼ねる
//-----------------------------------------------------------------------------
wire 	[pUfiBusWidth-1:0]  wDmaFifoRd;
wire 						wRVd;
wire 						wEmp;
reg 						rDmaFifoRe;
reg 						qDmaFifoRe;

fifoController #(
	.pFifoDepth		(pFifoDepth),
	.pFifoBitWidth	(pFifoBitWidth)
) VideoDmaFifo (
	.iWd			(iDmaWd),
	.iWe			(iDmaWEd),
	.oFull			(oDmaFull),
	.oRd			(wDmaFifoRd),
	.iRe			(rDmaFifoRe),
	.oRvd			(wRVd),
	.oEmp			(wEmp),
	.iRst			(iRst),
	.iClk			(iClk)
);

//-----------------------------------------------------------------------------
// R/W ステートマシン
//-----------------------------------------------------------------------------
reg 	[pUfiBusWidth-1:0]	rDmaRd;			assign oDmaRd		= rDmaRd;
reg 						rDmaREd;		assign oDmaREd		= rDmaREd;
reg		[pUfiBusWidth-1:0]	rMUfiWd;		assign oMUfiWd		= rMUfiWd;
reg		[pMemAdrsWidth-1:0]	rMUfiAdrs;		assign oMUfiAdrs	= rMUfiAdrs;
reg							rMUfiWEd;		assign oMUfiWEd		= rMUfiWEd;
reg							rMUfiREd;		assign oMUfiREd		= rMUfiREd;
reg							rMUfiVd;		assign oMUfiVd		= rMUfiVd;
reg							rMUfiCmd;		assign oMUfiCmd		= rMUfiCmd;
//
reg							qMUfiWEd;
reg							qMUfiREd;
reg							qMUfiVd;
reg							qMUfiCmd;
//
reg		[pMemAdrsWidth-1:0]	rDmaWAdrs;
reg		[pMemAdrsWidth-1:0]	rDmaRAdrs;
reg 						rDmaWAdrsSel;
reg 						rDmaRAdrsSel;
reg 						qDmaWAdrsOverCheck;
reg 						qDmaWAdrsMatch;
reg 						qDmaRAdrsMatch;

always @(posedge iClk)
begin
	// Frame Buffer 領域の切り替え
	casex ({qDmaWAdrsOverCheck, qDmaWAdrsMatch, wRVd, iDmaEn})
		'bxxx0:		rDmaWAdrsSel <= 1'b0;
		'b0111:		rDmaWAdrsSel <= ~rDmaWAdrsSel;
		default: 	rDmaWAdrsSel <=  rDmaWAdrsSel;
	endcase

	casex ({qDmaRAdrsMatch, iDmaRe, iMUfiRdy, iDmaEn})
		'bxxx0:		rDmaRAdrsSel <= 1'b0;
		'b1111:		rDmaRAdrsSel <= ~rDmaRAdrsSel;
		default: 	rDmaRAdrsSel <=  rDmaRAdrsSel;
	endcase

	// アドレスの更新
	casex ({rDmaWAdrsSel, qDmaWAdrsOverCheck, qDmaWAdrsMatch, wRVd, iDmaEn})
		'bxxxx0:	rDmaWAdrs <= iFbufAdrs1;
		'bxx011:	rDmaWAdrs <= rDmaWAdrs + 1'b1;
		'b00111:	rDmaWAdrs <= iFbufAdrs2;
		'b10111:	rDmaWAdrs <= iFbufAdrs1;
		default:	rDmaWAdrs <= rDmaWAdrs;
	endcase

	casex ({rDmaRAdrsSel, qDmaRAdrsMatch, iDmaRe, wRVd, iMUfiRdy, iDmaEn})
		'bxxxxx0:	rDmaRAdrs <= iFbufAdrs2;
		'bx01011:	rDmaRAdrs <= rDmaRAdrs + 1'b1;
		'b011011:	rDmaRAdrs <= iFbufAdrs1;
		'b111011:	rDmaRAdrs <= iFbufAdrs2;
		default:	rDmaRAdrs <= rDmaRAdrs;
	endcase

	if (wRVd)		rMUfiWd		<= wDmaFifoRd;
	else 			rMUfiWd		<= 8'h0f;

	if (wRVd) 		rMUfiAdrs	<= rDmaWAdrs;
	else 			rMUfiAdrs	<= rDmaRAdrs;

	if (iRst)		rMUfiWEd	<= 1'b0;
	else if (iDmaEn)rMUfiWEd	<= qMUfiWEd;
	else			rMUfiWEd	<= 1'b0;

	if (iRst)		rMUfiREd	<= 1'b0;
	else if (iDmaEn)rMUfiREd	<= qMUfiREd;
	else 			rMUfiREd	<= 1'b0;

	if (iRst)		rMUfiVd		<= 1'b0;
	else if (iDmaEn)rMUfiVd 	<= qMUfiVd;
	else			rMUfiVd 	<= 1'b0;

	if (iDmaEn)		rMUfiCmd	<= qMUfiCmd;
	else 			rMUfiCmd	<= 1'b0;

	if (iRst)		rDmaFifoRe	<= 1'b0;
	else if (iDmaEn)rDmaFifoRe	<= qDmaFifoRe;
	else 			rDmaFifoRe	<= 1'b0;

	// 後段ブロックへの処理
	rDmaRd	<= iMUfiRd;

	if (iRst)		rDmaREd	<= 1'b0;
	else			rDmaREd	<= iMUfiREd;
end

//---------------------------------------------------------------------------
// FIFO レイテンシの違いを吸収するためのアドレスの先読み
//---------------------------------------------------------------------------
localparam lpAdrsAhead = 5;

integer m;
reg [pMemAdrsWidth-1:0] rDmaWAdrsAhead [0:lpAdrsAhead-1];

generate
always @(posedge iClk)
begin
	for (m = 1; m < lpAdrsAhead+1; m = m + 1)
	begin
		rDmaWAdrsAhead[m-1] <= rDmaWAdrs + m;
	end
end
endgenerate
//
  
always @*
begin
	// TODO 現在は WAdrs が RAdrs を追従する形で動作しているが、
	// 1フレーム単位で 拡大縮小など処理をする場合もあるので、
	// 必要になったら Dma R/Wアドレスがフレームの端に達した時に、両アドレスを切り替えるようにする。
	// そのかわり この module 内の VideoDmaFifo が 0 レイテンシである必要があるし、
	// ExRAM の速度も必要になってくる
	// 
	// 下記のアドレス加算処理は 前段の FIFO のデータ出力が数レイテンシ遅れるため、
	// 1クロック違いでの切り替えなどにすると、タイミングのずれが生じるため先読みでアドレスを確認している
	// フレームサイズが 2 の乗数ではないので、RAdrs が 各フレームの初めのアドレスをの時の処理も含む
	qDmaWAdrsOverCheck 	<=  (rDmaWAdrsAhead[0] == rDmaRAdrs) |
							(rDmaWAdrsAhead[1] == rDmaRAdrs) |
							(rDmaWAdrsAhead[2] == rDmaRAdrs) |
							(rDmaWAdrsAhead[3] == rDmaRAdrs) |
							(rDmaWAdrsAhead[4] == rDmaRAdrs) |
							((iFbufAdrs1 <= rDmaRAdrs) && (rDmaRAdrs < (iFbufAdrs1 + 3'd5))) |
							((iFbufAdrs2 <= rDmaRAdrs) && (rDmaRAdrs < (iFbufAdrs2 + 3'd5))) ; 
	// qDmaWAdrsOverCheck 	<=  |{rAdrsAheadFlag} |
	// 						((iFbufAdrs1 <= rDmaRAdrs) && (rDmaRAdrs < (iFbufAdrs1 + 3'd5))) |
	// 						((iFbufAdrs2 <= rDmaRAdrs) && (rDmaRAdrs < (iFbufAdrs2 + 3'd5))) ; 

	qDmaWAdrsMatch 		<= (rDmaWAdrs == iFbufLen1) | (rDmaWAdrs == iFbufLen2);
	qDmaRAdrsMatch 		<= (rDmaRAdrs == iFbufLen1) | (rDmaRAdrs == iFbufLen2);
	//	
	qMUfiWEd			<= (iDmaRe & iMUfiRdy) | wRVd;
	qMUfiREd			<= iDmaRe;						// 後段がデータ受付可能であれば Read 要求とする
	qMUfiVd				<= (iDmaRe | (~wEmp));			// 空でなければ Ufi 転送要求とする
	qMUfiCmd			<= (iDmaRe & (~wRVd));			// 後段から Read要求がなければ、WCMD とする
	qDmaFifoRe			<= (~iDmaRe) & iMUfiRdy & (~qDmaWAdrsOverCheck);

	// DMA Read のみのデバッグの残り
	// qMUfiWEd		<= iDmaRe & iMUfiRdy;
	// qMUfiVd		<= iDmaRe;						// 空でなければ Ufi 転送要求とする
	// qDmaFifoRe	<= 1'b0; // RDMA デバッグのため、書き込み側のデータは必要ない
end

/*
 DMA サイクル
 まず前提として、FrameBuffer への書き込みは、Read よりも早くなければならない。
 1.DualFrameBuufer 構造として、WDMA,RDMA は別々のアドレスを指定する。
 2.起動時は、後段の DualClkFifo が Full になるまで RAM の何も書かれていない領域から 0 を Read する。
 3.Full になると iDmaRe が Deassert されるので、WDMA に切り替え前段の FIFO からの入力データを UFI 経由で RAM に書き込みを行う。
 4.
 */

endmodule