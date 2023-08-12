//----------------------------------------------------------
// Create 2022/7/3
// Author koutakimura
// -
// パラレルデータを I2S規格のシリアルデータに変換する
// BCLK LRCLK SDATA をそれぞれ出力
//----------------------------------------------------------
module i2sSerializer (
    // Internal Port
    input           iAudioClk,
    input           iAudioRst,
    input  [31:0]   iAudioData,
    output          oAudioBclk,
    output          oAudioCclk,
    output          oAudioData,
    output          oAudioLRch          // Low L-Ch / High R-Ch
);


//----------------------------------------------------------
// BCLK Generator
// MCLK = BCLK(MHz) * 8
// 24.576MHz = 3.072MHz * 8
// negedge だけの SDR なので 実際は 4cnt で検出する
//----------------------------------------------------------
localparam lpBclkCntMax = 4'd4; 

reg  [2:0] rMclkCnt;
reg  rBclk;              assign oAudioBclk = rBclk;
reg  qBclkCke;

always @(negedge iAudioClk)
begin
    if (iAudioRst)      rMclkCnt <= 3'd0;
    else if (qBclkCke)  rMclkCnt <= 3'd0;
    else                rMclkCnt <= rMclkCnt + 1'd1;

    if (iAudioRst)      rBclk <= 1'd0;
    else if (qBclkCke)  rBclk <= ~rBclk;
    else                rBclk <= rBclk;
end

always @*
begin
    qBclkCke <= (rMclkCnt == lpBclkCntMax);
end


//----------------------------------------------------------
// LRCLK Generator
// Bclk の CKE が DDR でアサートされるので、32bit x 2clk
// 合計 64カウント のレジスタを確保する
//----------------------------------------------------------
localparam lpCclkCntMax = 7'd63;

reg  rCclk;             assign {oAudioCclk, oAudioLRch} = {2{rCclk}};
reg  [6:0] rCclkCnt;
reg  qCclkCke;

always @(negedge iAudioClk)
begin
    if (iAudioRst)      rCclkCnt <= 7'd0;
    else if (qCclkCke)  rCclkCnt <= 7'd0;
    else if (qBclkCke)  rCclkCnt <= rCclkCnt + 1'd1;
    else                rCclkCnt <= rCclkCnt;

    if (iAudioRst)      rCclk <= 1'd0;
    else if (qCclkCke)  rCclk <= ~rCclk;
    else                rCclk <= rCclk;
end

always @*
begin
    qCclkCke <= (rCclkCnt == lpCclkCntMax);
end


//----------------------------------------------------------
// パラレル -> シリアル変換
// LRch 32bit MSB farst
// 
// MSB Farst で送信する必要がある。
// Cclk が DDR クロックカウントのため 0 ~ 63 までインクリメントでカウントするが、
// 1bit 詰めて、更に反転すると 31 ~ 0 のデクリメントカウンタとして使用できる
//----------------------------------------------------------
reg  rAudioData;           assign oAudioData = rAudioData;
reg  qBitRp;

always @(negedge iAudioClk)
begin
    if (qCclkCke)  rAudioData <= iAudioData[0];
    else           rAudioData <= iAudioData[qBitRp];
end

always @*
begin
    qBitRp <= ~(rCclkCnt[6:1]);
end

endmodule