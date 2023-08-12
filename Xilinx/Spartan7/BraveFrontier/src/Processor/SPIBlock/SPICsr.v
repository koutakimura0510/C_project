//----------------------------------------------------------
// Create 2022/7/24
// Author koutakimura
// -
// 
// [Csr 規則]
// 自動レジスタ更新は、上位モジュールからの input port とレジスタを接続する。
// 上位モジュールへの output port は必ずレジスタ経由で出力する。
//----------------------------------------------------------
module SPICsr #(
	// variable parameter
	parameter 						pBlockAdrsMap 	= 8,
	parameter [pBlockAdrsMap-1:0] 	pAdrsMap	  	= 'h03,
	parameter						pBusAdrsBit		= 32,
	parameter 						pDivClk 		= 16
)(
    // Internal Port
	// Csr Read
	output	[31:0]					oSUsiRd,
	output 							oSUsiREd,
	// Csr Write
	input	[31:0]					iSUsiWd,
	input	[pBusAdrsBit-1:0]		iSUsiAdrs,
	input							iSUsiWCke,
	// Csr Output
	output 							oSPIEn,
	output 	[pDivClk-1:0]			oSPIDiv,
	output 	[7:0]					oMWd,
	output 							oMSpiCs,
	// Csr Input
	input  	[7:0]					iMRd,
    // CLK Reset
    input           				iSysClk,
    input           				iSysRst
);



//----------------------------------------------------------
// Csr Write
//----------------------------------------------------------
// USI/F Write
reg 					rSPIEn;				assign oSPIEn 		= rSPIEn;			// 通信開始
reg 	[pDivClk-1:0]	rSPIDiv;			assign oSPIDiv 		= rSPIDiv;			// CLK Division
reg 	[7:0]			rMWd;				assign oMWd			= rMWd;				// Send Data
reg 					rMSpiCs;			assign oMSpiCs		= rMSpiCs;			// chip select 
//
reg 	[7:0]			rMRd;
//
reg [pBusAdrsBit:0]	qCsrAdrs;

always @(posedge iSysClk)
begin
	if (iSysRst)
	begin
		rSPIEn			<= 1'b0;
		rSPIDiv			<= {pDivClk{1'b1}};
		rMWd			<= 8'd0;
		rMSpiCs			<= 1'b1;
		//
		rMRd			<= 8'd0;
	end
	else
	begin
		rSPIEn			<= (qCsrAdrs == {1'b1, pAdrsMap, 8'h00}) ? iSUsiWd[0:0] 			: rSPIEn;
		rSPIDiv			<= (qCsrAdrs == {1'b1, pAdrsMap, 8'h04}) ? iSUsiWd[pDivClk-1:0] 	: rSPIDiv;
		rMWd			<= (qCsrAdrs == {1'b1, pAdrsMap, 8'h08}) ? iSUsiWd[7:0]			 	: rMWd;
		rMSpiCs			<= (qCsrAdrs == {1'b1, pAdrsMap, 8'h0c}) ? iSUsiWd[0:0]			 	: rMSpiCs;
		rMRd			<= iMRd;
	end
end

always @*
begin
	qCsrAdrs <= {iSUsiWCke, iSUsiAdrs};
end

//----------------------------------------------------------
// Csr Read
//----------------------------------------------------------
reg [31:0]		rSUsiRd;		assign oSUsiRd = rSUsiRd;
reg 			rSUsiREd;		assign oSUsiREd = rSUsiREd;
reg 			qAdrsComp;

always @(posedge iSysClk)
begin
	if (iSysRst)
	begin
		rSUsiRd <= 'h0;
	end
	else
	begin
		case ({qAdrsComp, iSUsiAdrs[7:0]})
			'h100:		rSUsiRd <= {31'd0, rSPIEn};
			'h104:		rSUsiRd <= {{(32 - pDivClk){1'b0}}, rSPIDiv};	// パラメータ可変なので、可変に対応して0で埋めるようにした
			'h108:		rSUsiRd <= {24'd0, rMWd};
			'h10c:		rSUsiRd <= {31'd0, rMSpiCs};
			'h180:		rSUsiRd <= {24'd0, rMRd};
			default: 	rSUsiRd <= iSUsiWd;
		endcase
	end

	if (iSysRst)		rSUsiREd <= 1'b0;
	else if (qAdrsComp)	rSUsiREd <= 1'b1;
	else				rSUsiREd <= 1'b0;
end

always @*
begin
	qAdrsComp <= {iSUsiAdrs[pBlockAdrsMap + 3'd7:8] == pAdrsMap};
end

endmodule