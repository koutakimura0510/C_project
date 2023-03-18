/*~`^*~`^*~`^*~`^*~`^*~`^*~`^*~`^*~`^*~`^*~`^*~`^*~`^*~`^*~`^*~`^*~`^*~`^*~`^*
 *
 * File Name   : MVideoTimingGen.v
 * Description : Ti180M484 dev Kit MIPI RX to HDMI Output Simple Demo.
 * Simulator   : VeritakWin Ver.3.84D Build May.23.2011
 * Implem. Tool: Efinix Efinity 2022.1.226.2.11
 * Explanation : 
 *
 * Copyright(c) 2011-2023, by Net-Vision Corp. All rights reserved.
 * (Note) For this source code, it is forbidden using and issuing
 *        without permission.
 * （注） このソース・コードの無断使用および無断持ち出しを禁止します．
 *
 * Revision    :
 * 02/Jan-2023 V1.00 New Release, Inh.fr. "MVideoTimingGen.v" K.Kimura
 *
 *~`^*~`^*~`^*~`^*~`^*~`^*~`^*~`^*~`^*~`^*~`^*~`^*~`^*~`^*~`^*~`^*~`^*~`^*~`^*/
//-----------------------------------------------------------------------------
module MPixelFormatConverter (
	input 	[63:0]				iRd,		// 前段からの入力データ
	output 						oRe,		// 前段への読み込み命令
	input 						iRvd,		// 前段からの転送通知
	input 						iEmp,		// 前段からの Fifo状況
	//
	output	[15:0]				oWd,		// 後段への転送データ
	output 						oWe,		// 後段へデータ転送通知
	input 						ifull,		// 後段からの受付通知
	//
    input                       iRST,
    input                       iCLK
);

reg  		rRe, qReCke;					assign oRe = rRe;
reg [1:0]	rConvertCnt = 2'd0;
reg [1:0] 	rSt;

always @(posedge iCLK)
begin
	if (iRST)
	begin
		rSt <= 2'd0;
		rRe <= 1'b0;
	end
	else
	begin
		case (rSt)
			2'd0: begin
				rSt <= qReCke ? 2'd1 : 2'd0;
				rRe <= qReCke ? 1'b1 : 1'b0;
			end 

			2'd1: begin
				rSt <= 2'd2;
				rRe <= 1'b0;
			end 

			2'd2: begin
				rSt <= iRvd ? 2'd0 : 2'd2;
				rRe <= 1'b0;
			end 

			default: begin
				rSt <= 2'd0;
				rRe <= 1'b0;
			end
		endcase
	end
end

always @*
begin
	casex ( {iEmp,(rConvertCnt==2'd0)} )
		'b11:		qReCke <= 1'b1;	// Assert
		default: 	qReCke <= 1'b0;
	endcase
end


//-----------------------------------------------------------------------------
// Bit 分割
//-----------------------------------------------------------------------------
reg [15:0] 	rWd [0:3];			assign oWd = rWd[0];
reg 		rWe;				assign oWe = rWe;
reg 		rRvd, qRvdCke;

always @(posedge iCLK)
begin
	if (iRvd)
	begin
		rConvertCnt <= 2'd3;
		rWd[0] 		<= {iRd[15:8],  iRd[7:0] };
		rWd[1] 		<= {iRd[31:24], iRd[23:16]};
		rWd[2] 		<= {iRd[47:40], iRd[39:32]};
		rWd[3] 		<= {iRd[63:56], iRd[55:48]};
		rWe			<= 1'b1;
	end
	else if (rRvd & ifull)
	begin
		rConvertCnt <= (rConvertCnt==2'd0) ? rConvertCnt : rConvertCnt - 1'b1;
		rWd[0] 		<= rWd[1];
		rWd[1] 		<= rWd[2];
		rWd[2] 		<= rWd[3];
		rWd[3] 		<= rWd[0];
		rWe			<= (rConvertCnt==2'd0) ? 1'b0 : 1'b1;
	end
	else
	begin
		rConvertCnt <= rConvertCnt;
		rWd[0] 		<= rWd[0];
		rWd[1] 		<= rWd[1];
		rWd[2] 		<= rWd[2];
		rWd[3] 		<= rWd[3];
		rWe			<= 1'b0;
	end

	if (iRST)			rRvd <= 1'b0;
	else if (qRvdCke)	rRvd <= ~rRvd;
	else 				rRvd <=  rRvd;
end

always @*
begin
	casex ( {rRvd,iRvd,(rConvertCnt==2'd0)} )
		'b01x:		qRvdCke <= 1'b1;	// Assert
		'b1x1:		qRvdCke <= 1'b1;	// Dissert
		default: 	qRvdCke <= 1'b0;
	endcase
end

endmodule