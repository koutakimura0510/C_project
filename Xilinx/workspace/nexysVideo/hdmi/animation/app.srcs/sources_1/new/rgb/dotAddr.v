/*
 * Create 2021/1/6
 * Author koutakimura
 * Editor VSCode ver1.62.7
 * Build  Vivado20.2
 * Borad  Nexys Video
 * 
 * 現在のユーザーの位置からキャラクター描画用のドット保存Rom参照アドレスを生成する
 */
module dotAddr (
    input           iCLK,   // ディスプレイ描画clk
    input           iRST,   // system rst
    input  [ 9:0]   iUXS,
    input  [ 9:0]   iUXE,
    input  [ 9:0]   iUYS,
    input  [ 9:0]   iUYE,
    input  [ 9:0]   iHPOS,
    input  [ 9:0]   iVPOS,
    output [15:0]   oAddr,
    output          oEnable // アドレスを参照して描画データを出力する時にHigh
);

reg [15:0] iAddr;   assign oAddr = iAddr;
assign oEnable = (iUXS <= iHPOS && iHPOS < iUXE && iUYS <= iVPOS && iVPOS < iUYE) ? 1'b1 : 1'b0;

always @(posedge iCLK) begin
    if (iRST == 1'b1) begin
        iAddr <= 0;
    end else if (480 < iVPOS) begin
        iAddr <= 0;
    end else if (iUXS <= iHPOS && iHPOS < iUXE && iUYS <= iVPOS && iVPOS < iUYE) begin
        iAddr <= iAddr + 1'b1;
    end
end


endmodule