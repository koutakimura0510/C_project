//----------------------------------------------------------
// Create 2022/9/12
// Author koutakimura
// -
// System Clk と Memory Clk の クロック変換用途
// 
//----------------------------------------------------------
module RAMDualClkFifo #(
	parameter						pDualClkFifoDepth 	= 256,
	parameter						pRamDqWidth			= 8,
	parameter						pRamAdrsWidth		= 19
)(
	input 	[pRamDqWidth-1:0]		iWd,
	input	[pRamAdrsWidth-1:0]		iAdrs,
	input 							iCmd,
	input 							iWEd,
	output 							oFull,
	//
	output 	[pRamDqWidth-1:0]		oWd,
	output	[pRamAdrsWidth-1:0]		oAdrs,
	output							oCmd,
	input 							iREd,
	output 							oEmp,
	output 							oRVd,
    // Internal Port
    input							iRst,
	input 							iSysClk,
    input							iMemClk
);


//-----------------------------------------------------------------------------
// FIFO の制御信号は、各FIFO が同じタイミングで動作することを
// 前提とするため一つのみ使用する。
//-----------------------------------------------------------------------------
fifoDualControllerGray #(
	.pBuffDepth	(pDualClkFifoDepth),
	.pBitWidth	(pRamDqWidth)
) RamDualClkFifoWd (
	.iWD		(iWd),
	.iWE		(iWEd),
	.oFLL		(oFull),
	.oRD		(oWd),
	.iRE		(iREd),
	.oRVD		(oRVd),
	.oEMP		(oEmp),
	.iSrcRst	(iRst),
	.iDstRst	(iRst),
	.iSrcClk	(iSysClk),
	.iDstClk	(iMemClk)
);

fifoDualControllerGray #(
	.pBuffDepth	(pDualClkFifoDepth),
	.pBitWidth	(pRamAdrsWidth)
) RamDualClkFifoAdrs (
	.iWD		(iAdrs),
	.iWE		(iWEd),
	.oFLL		(),
	.oRD		(oAdrs),
	.iRE		(iREd),
	.oRVD		(),
	.oEMP		(),
	.iSrcRst	(iRst),
	.iDstRst	(iRst),
	.iSrcClk	(iSysClk),
	.iDstClk	(iMemClk)
);

fifoDualControllerGray #(
	.pBuffDepth	(pDualClkFifoDepth),
	.pBitWidth	(1'b1)
) RamDualClkFifoCmd (
	.iWD		(iCmd),
	.iWE		(iWEd),
	.oFLL		(),
	.oRD		(oCmd),
	.iRE		(iREd),
	.oRVD		(),
	.oEMP		(),
	.iSrcRst	(iRst),
	.iDstRst	(iRst),
	.iSrcClk	(iSysClk),
	.iDstClk	(iMemClk)
);

endmodule