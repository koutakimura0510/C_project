//----------------------------------------------------------
// Create 2022/8/2
// Author koutakimura
// -
// バスシステムの Masterと SPI の管理を司るブロック
// iMSSel GPIO は FPGA SPI の Master / Slave を切り替える役割も持つ
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
	parameter 							pBlockAdrsMap 		= 8,	// ブロックのアドレス幅を指定
	parameter [pBlockAdrsMap-1:0] 		pAdrsMap	  		= 'h03,
	parameter							pBusAdrsBit			= 16,
	parameter [3:0]						pBusSlaveConnect	= 1,	// Busに接続する Slave数 最大16
	parameter							pUfiBusWidth		= 16
)(
	// External Port
    inout								ioSpiSck,
    inout								ioSpiMiso,
    inout								ioSpiMosi,
    inout								ioSpiWp,
    inout								ioSpiHold,
    output								oSpiConfigCs,
    inout								ioSpiCs,
    input								iMSSel,			// Master Slave Select / Default External PullUp
    // Internal Port
	// Usi Bus Master Read
	input	[31:0]						iMUsiRd,		// CSR Read Data
	input	[pBusSlaveConnect-1:0]		iMUsiREd,		// Read Assert
	// Usi Bus Master Write
	output	[31:0]						oMUsiWd,		// Write Data
	output	[pBusAdrsBit-1:0]			oMUsiAdrs,		// R/W Adrs
	output								oMUsiWEd,		// Write Enable
	// Usi Bus Slave Read
	output	[31:0]						oSUsiRd,		// Read Data
	output								oSUsiREd,		// Read Data Enable
	// Usi Bus Slave Write
	input	[31:0]						iSUsiWd,		// Master Write Data
	input	[pBusAdrsBit-1:0]			iSUsiAdrs,		// Csr Access Adrs
	input								iSUsiWCke,		// Data Enable
	// Ufi Bus Master Write
	output	[pUfiBusWidth-1:0]			oMUfiWd,		// Write Data
	output	[31:0]						oMUfiAdrs,		// Write address
	output								oMUfiWEd,		// Write Data Enable
	output 								oMUfiWVd,		// 転送期間中 Assert
	// Interrupt
	output 								oMSpiIntr,		// FPGA Master Byte Read Data Enable
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
reg  					qMSpiCsUnit;
//
wire 	[7:0]			wMRdUnit;

SPIUnit #(
	.pBusAdrsBit		(pBusAdrsBit),
	.pDivClk			(lpDivClk),
	.pUfiBusWidth		(pUfiBusWidth)
) SPI_UNIT (
	.ioSpiSck			(ioSpiSck),
	.ioSpiMiso			(ioSpiMiso),
	.ioSpiMosi			(ioSpiMosi),
	.ioSpiWp			(ioSpiWp),
	.ioSpiHold			(ioSpiHold),
	.oSpiConfigCs		(oSpiConfigCs),
	.ioSpiCs			(ioSpiCs),
	.iMSSel				(iMSSel),
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
	.iMSPICs			(qMSpiCsUnit),
	.oMRd				(wMRdUnit),
	// Interrupt
	.oMSpiIntr			(oMSpiIntr),
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
wire 					wMSpiCsCsr;
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
	.oSUsiREd			(oSUsiREd),
	.iSUsiWd			(iSUsiWd),
	.iSUsiAdrs			(iSUsiAdrs),
	.iSUsiWCke			(iSUsiWCke),
	// Csr Output
	.oSPIEn				(wSPIEnCsr),
	.oSPIDiv			(wSPIDivCsr),
	.oMWd				(wMWdCsr),
	.oMSpiCs			(wMSpiCsCsr),
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
	qMSpiCsUnit			<= wMSpiCsCsr;
	qMRdCsr				<= wMRdUnit;
end

endmodule