//----------------------------------------------------------
// Create 2022/8/28
// Author koutakimura
// -
// Slave コントロール・ステータス・レジスタ
// 
// [Csr 規則]
// 自動レジスタ更新は、上位モジュールからの input port とレジスタを接続する。
// 上位モジュールへの output port は必ずレジスタ経由で出力する。
//----------------------------------------------------------
module RamCsr #(
	parameter pBlockAdrsWidth	= 8,
	parameter [pBlockAdrsWidth-1:0] pAdrsMap = 'h01,
	parameter pUsiBusWidth 		= 32,
	parameter pCsrAdrsWidth		= 8,
	parameter pCsrActiveWidth	= 8,
	parameter pRamAdrsWidth		= 19,
	parameter pRamDqWidth		= 16,
	parameter p_non_variable	= 0
)(
	// Bus Master Read
	output [pUsiBusWidth-1:0] 	oSUsiRd,
	// Bus Master Write
	input  [pUsiBusWidth-1:0] 	iSUsiWd,
	input  [pUsiBusWidth-1:0] 	iSUsiAdrs,
	// Csr Device Config
	output [7:0]				oCfgCmd,
	output						oCfgEn,
	output						oCfgRst,
	input						iCfgDone,
	// Csr Device Config
	input  [15:0] 				iHdcCapDq,
	output [15:0] 				oHdcWDq,
	output [47:0] 				oHdcCmdAdrs,
	output [ 3:0]				oHdciLatencyCnt,
	output						oHdcRwCmd,
	output						oHdcSeqEn,
	input						iHdcDone,
	// Csr Input
	input  [pRamDqWidth-1:0] 	iMemRd,
    // CLK Reset
    input  iSRST,
    input  iSCLK
);


//----------------------------------------------------------
// レジスタマップ
//----------------------------------------------------------
reg 		rHdcSeqEn;				assign oHdcSeqEn 		= rHdcSeqEn;
reg 		rHdcRwCmd;				assign oHdcRwCmd 		= rHdcRwCmd;
reg [15:0] 	rHdcWDq;				assign oHdcWDq			= rHdcWDq;
reg [47:0] 	rHdcCmdAdrs;			assign oHdcCmdAdrs		= rHdcCmdAdrs;
reg [ 3:0]	rHdcLatencyCnt;			assign oHdciLatencyCnt	= rHdcLatencyCnt;
//
reg [ 7:0]	rCfgCmd;				assign oCfgCmd			= rCfgCmd;
reg			rCfgEn;					assign oCfgEn			= rCfgEn;
reg			rCfgRst;				assign oCfgRst			= rCfgRst;
//
reg [pRamDqWidth-1:0] 	rMemRd;
reg [15:0]				rHdcCapDq;
//
reg qCsrWCke00, qCsrWCke01, qCsrWCke02, qCsrWCke03, qCsrWCke04, qCsrWCke05;
reg qCsrWCke10, qCsrWCke11;
//
always @(posedge iSCLK)
begin
	if (iSRST)
	begin
		rHdcSeqEn		<= 1'b0;
		rHdcRwCmd		<= 1'b0;
		rHdcWDq			<= 16'd0;
		rHdcCmdAdrs		<= 48'd0;
		rHdcLatencyCnt	<= 4'd0;
		rMemRd			<= {pRamDqWidth{1'b0}};
		rHdcCapDq		<= 16'd0;
		//
		rCfgCmd			<= 8'd35;
		rCfgEn			<= 1'b0;
		rCfgRst			<= 1'b1;
	end
	else
	begin
		rHdcSeqEn			<= iHdcDone	  ? 1'b0 		  : qCsrWCke01 ? iSUsiWd[ 0:0] : rHdcSeqEn;
		rHdcRwCmd			<= qCsrWCke01 ? iSUsiWd[ 4:4] : rHdcRwCmd;
		rHdcWDq				<= qCsrWCke02 ? iSUsiWd[15:0] : rHdcWDq;
		rHdcCmdAdrs[31: 0]	<= qCsrWCke03 ? iSUsiWd[31:0] : rHdcCmdAdrs[31: 0];
		rHdcCmdAdrs[47:32]	<= qCsrWCke04 ? iSUsiWd[15:0] : rHdcCmdAdrs[47:32];
		rHdcLatencyCnt		<= qCsrWCke05 ? iSUsiWd[ 3:0] : rHdcLatencyCnt;
		rMemRd				<= iMemRd;
		rHdcCapDq			<= iHdcDone   ? iHdcCapDq	  : rHdcCapDq;
		//
		rCfgCmd				<= qCsrWCke10 ? iSUsiWd[ 7:0] : rCfgCmd;
		rCfgEn				<= qCsrWCke11 ? iSUsiWd[ 0:0] : rCfgEn;
		rCfgRst				<= qCsrWCke11 ? iSUsiWd[ 1:1] : rCfgRst;
	end
end

always @*
begin
	qCsrWCke00 <= iSUsiAdrs[30] & (iSUsiAdrs[pBlockAdrsWidth + pCsrAdrsWidth - 1:0] == {pAdrsMap, 16'h0000});
	qCsrWCke01 <= iSUsiAdrs[30] & (iSUsiAdrs[pBlockAdrsWidth + pCsrAdrsWidth - 1:0] == {pAdrsMap, 16'h0001});
	qCsrWCke02 <= iSUsiAdrs[30] & (iSUsiAdrs[pBlockAdrsWidth + pCsrAdrsWidth - 1:0] == {pAdrsMap, 16'h0002});
	qCsrWCke03 <= iSUsiAdrs[30] & (iSUsiAdrs[pBlockAdrsWidth + pCsrAdrsWidth - 1:0] == {pAdrsMap, 16'h0003});
	qCsrWCke04 <= iSUsiAdrs[30] & (iSUsiAdrs[pBlockAdrsWidth + pCsrAdrsWidth - 1:0] == {pAdrsMap, 16'h0004});
	qCsrWCke05 <= iSUsiAdrs[30] & (iSUsiAdrs[pBlockAdrsWidth + pCsrAdrsWidth - 1:0] == {pAdrsMap, 16'h0005});
	//
	qCsrWCke10 <= iSUsiAdrs[30] & (iSUsiAdrs[pBlockAdrsWidth + pCsrAdrsWidth - 1:0] == {pAdrsMap, 16'h0010});
	qCsrWCke11 <= iSUsiAdrs[30] & (iSUsiAdrs[pBlockAdrsWidth + pCsrAdrsWidth - 1:0] == {pAdrsMap, 16'h0011});
end

//----------------------------------------------------------
// Csr Read
//----------------------------------------------------------
reg [pUsiBusWidth-1:0] rSUsiRd;			assign oSUsiRd = rSUsiRd;

always @(posedge iSCLK)
begin
	// {{(32 - パラメータ名	){1'b0}}, レジスタ名} -> パラメータ可変に対応し 0 で埋められるように設定
	case (iSUsiAdrs[pCsrActiveWidth-1:0])
		// 'h00:	 rSUsiRd <= {{(32 - 1	){1'b0}}, rRamRst};
		'h01:	 rSUsiRd <= {{(32 - 2	){1'b0}}, rHdcRwCmd,	rHdcSeqEn};
		'h02:	 rSUsiRd <= {{(32 - 16	){1'b0}}, rHdcWDq};
		'h03:	 rSUsiRd <= {					  rHdcCmdAdrs[31:0]};
		'h04:	 rSUsiRd <= {{(32 - 16	){1'b0}}, rHdcCmdAdrs[47:32]};
		'h05:	 rSUsiRd <= {{(32 - 28	){1'b0}}, rHdcLatencyCnt};
		'h10:	 rSUsiRd <= {{(32 - 24	){1'b0}}, rCfgCmd};
		'h11:	 rSUsiRd <= {{(32 - 30	){1'b0}}, rCfgRst, rCfgEn};
		'h40:	 rSUsiRd <= {{(32 - pRamDqWidth	){1'b0}}, iMemRd};
		'h41:	 rSUsiRd <= {{(32 - 16	){1'b0}}, rHdcCapDq};
		'h50:	 rSUsiRd <= {{(32 - 31	){1'b0}}, iCfgDone};
		default: rSUsiRd <= iSUsiWd;
	endcase
end

endmodule