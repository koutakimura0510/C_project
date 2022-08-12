//----------------------------------------------------------
// Create 2022/8/2
// Author koutakimura
// -
// バスシステムの Masterと SPI の管理を司るブロック
// ioSpiCs2 GPIO は FPGA SPI の Master / Slave を切り替える役割も持つ
// Reset 終了時の I/O の状態を確認し、High Master / Low Slave とする
// 通常はフラッシュメモリと接続されるが、デバッグ時は 外部CPU と接続するためこの機能を設けた。
// 
// また、本ブロックは フラッシュメモリの操作を司る扱いではなく、SPI I/F を通じて外部ターゲットと通信を行う目的がある。
// そのため、外部ターゲット操作時にページ消去コマンドなどのシーケンス制御が必要ならば、
// 本ブロックを使用する Upper Module 内のブロックで制御を行うようにする。
// 汎用性を持たせるためこのような仕様とした。
// 
//----------------------------------------------------------
module SPIBlock #(
	// variable parameter
	parameter 							pBlockAdrsMap 		= 'd8,	// ブロックのアドレス幅を指定
	parameter [pBlockAdrsMap-1:0] 		pAdrsMap	  		= 'h03,
	parameter							pBusAdrsBit			= 16,
	parameter [3:0]						pBusSlaveConnect	= 1,	// Busに接続する Slave数 最大16
)(
	// External Port
    inout	          					ioSpiSck,
    inout           					ioSpiMiso,
    inout           					ioSpiMosi,
    inout           					ioSpiWp,
    inout           					ioSpiHold,
    output          					oSpiConfigCs,
    input	          					ioSpiCs1,
    input	          					ioSpiCs2,
    // Internal Port
	// Usi Bus Master Read
	input	[31:0]						iMUsiRd,		// RCmd 発行時に各ブロックのCSR値が入力される
	input	[pBusSlaveConnect-1:0]		iMUsiVd,		// Slave アクセス可能時 Assert
	// Usi Bus Master Write
	output	[31:0]						oMUsiWd,		// Write Data
	output	[pBusAdrsBit-1:0]			oMUsiAdrs,		// R/W Adrs
	output								oMUsiWEd,		// Write Enable
	// Usi Bus Slave Read
	output	[31:0]						oSUsiRd,		// アドレス一致時データ出力
	output								oSUsiVd,		// データ出力中 Assert
	// Usi Bus Slave Write
	input	[31:0]						iSUsiWd,		// Master Write Data
	input	[pBusAdrsBit-1:0]			iSUsiAdrs,		// Csr Access Adrs
	input								iSUsiWCke,		// Data Enable
	// Ufi Bus Master Write
	output	[31:0]						oMUfiWd,		// Write Data
	output	[31:0]						oMUfiAdrs,		// Write address
	output								oMUfiWEd,		// Write Data Enable
	output 								oMUfiWVd,		// 転送期間中 Assert
	// Interrupt
	output 								oMUsiRDe,
	// Usi Bus Master to Slave Select
	output 								oMUsiMonopoly,	// 0. Slave として機能 / 1. Master バスを独占
    // CLK Reset
    input           					iSysClk,
    input           					iSysRst
);


//----------------------------------------------------------
// Csr ビット幅
//----------------------------------------------------------
localparam lpDivClk = 16;	// SCL生成の分周値レジスタBit幅


//----------------------------------------------------------
// SPI Unit
//----------------------------------------------------------
//
reg 					qSPIEnUnit;
reg 	[lpDivClk-1:0]	qSPIDivUnit;
reg  	[7:0] 			qMWdUnit;
reg  					qMSpiCs1Unit;
reg  					qMSpiCs2Unit;
//
wire 	[7:0]			wMRdUnit;

SPIUnit #(
	.pBusAdrsBit		(pBusAdrsBit),
	.pDivClk			(lpDivClk)
) SPI_UNIT (
	.ioSpiSck			(ioSpiSck),
	.ioSpiMiso			(ioSpiMiso),
	.ioSpiMosi			(ioSpiMosi),
	.ioSpiWp			(ioSpiWp),
	.ioSpiHold			(ioSpiHold),
	.oSpiConfigCs		(oSpiConfigCs),
	.ioSpiCs1			(ioSpiCs1),
	.ioSpiCs2			(ioSpiCs2),
	// Usi Bus Master to Slave Select
	.oMUsiMonopoly		(oMUsiMonopoly),
	// Usi Bus Master Read
	.iMUsiRd			(iMUsiRd),
	// Usi Bus Master Write
	.oMUsiWd			(oMUsiWd),
	.oMUsiAdrs			(oMUsiAdrs),
	.oMUsiWEd			(oMUsiWEd),
	// Ufi Bus Master
	.oMUfiWd			(oMUfiWd),
	.oMUfiAdrs			(oMUfiAdrs),
	.oMUfiWEd			(oMUfiWEd),
	.oMUfiWVd			(oMUfiWVd),
	// Csr
	.iSPIEn				(qSPIEnUnit),
	.iSPIDiv			(qSPIDivUnit),
	.iMWd				(qMWdUnit),
	.iMSpiCs1			(qMSpiCs1Unit),
	.iMSpiCs2			(qMSpiCs2Unit),
	.oMRd				(wMRdUnit),
	// Interrupt
	.oMUsiRDe			(oMUsiRDe),
	// CLK Reset
	.iSysClk			(iSysClk),
	.iSysRst			(iSysRst)
);


//----------------------------------------------------------
// Csr space
//----------------------------------------------------------
wire 					wSPIEnCsr;
wire 	[lpDivClk-1:0]	wSPIDivCsr;
wire 	[7:0] 			wMWdCsr;
wire 					wMSpiCs1Csr;
wire 					wMSpiCs2Csr;
//
reg 	[7:0]			qMRdCsr;

SPICsr #(
	.pBlockAdrsMap		(pBlockAdrsMap),
	.pAdrsMap			(pAdrsMap),
	.pBusAdrsBit		(pBusAdrsBit),
	.pDivClk			(lpDivClk)
) SPI_CSR (
	// Usi Bus Slave
	.oSUsiRd			(oSUsiRd),
	.oSUsiVd			(oSUsiVd),
	.iSUsiWd			(iSUsiWd),
	.iSUsiAdrs			(iSUsiAdrs),
	.iSUsiWCke			(iSUsiWCke),
	// Csr Output
	.oSPIEn				(wSPIEnCsr),
	.oSPIDiv			(wSPIDivCsr),
	.oMWd				(wMWdCsr),
	.oMSpiCs1			(wMSpiCs1Csr),
	.oMSpiCs2			(wMSpiCs2Csr),
	// Csr Input
	.iMRd				(qMRdCsr),
	// CLK Reset
	.iSysClk			(iSysClk),
	.iSysRst			(iSysRst)
);

always @*
begin
	qSPIEnUnit			<= wSPIEnCsr;
	qSPIDivUnit			<= wSPIDivCsr;
	qMWdUnit			<= wMWdCsr;
	qMSpiCs1Unit		<= wMSpiCs1Csr;
	qMSpiCs2Unit		<= wMSpiCs2Csr;
	qMRdCsr				<= wMRdUnit;
end

endmodule