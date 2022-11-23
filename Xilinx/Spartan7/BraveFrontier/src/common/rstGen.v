//----------------------------------------------------------
// Create 2021/04/14
// Author koutakimura
// -
// 21/04/14 リセット信号を生成する
// 22/07/09 パラメータ設定で BUFGに接続を行えるように更新
//----------------------------------------------------------
module rstGen # (
    parameter [7:0] pRstFallTime 	= 150,
	parameter 		pBufgUsed 		= "no"
)(
    input   iClk,
    output  oRst
);


//---------------------------------------------------------------------------
// リセットの立下り時間
//---------------------------------------------------------------------------
localparam [7:0] lpRstFallTime = pRstFallTime - 8'd1;


//---------------------------------------------------------------------------
// リセットの生成
//---------------------------------------------------------------------------
reg         qEn;
reg [7:0]   rCnt = 8'd0;
reg rRst = 1'd1;

generate
	if (pBufgUsed == "yes")
	begin
		BUFG BUFG_AudioClk (
            .O	(oRst),
            .I	(rRst)
        );
	end
	else
	begin
		assign oRst = rRst;
	end
endgenerate

always @(posedge iClk)
begin
    rCnt <= rCnt + 1'b1;
end

always @(posedge iClk)
begin
    if (qEn)    rRst <= 1'b0;
    else        rRst <= rRst;
end

always @*
begin
	qEn <= (rCnt == lpRstFallTime);
end

endmodule
