//----------------------------------------------------------
// Create 2022/9/9
// Author koutakimura
// -
// Audio の管理を司るブロック
// 
//----------------------------------------------------------
module AudioTxBlock #(
	parameter 						pBlockAdrsMap 		= 8,
	parameter [pBlockAdrsMap-1:0] 	pAdrsMap	  		= 'h05,
	parameter						pBusAdrsBit			= 32,
	parameter 						pCsrAdrsWidth 		= 8,
	parameter						pCsrActiveWidth 	= 8,
	//
	parameter						pSamplingBitWidth	= 8	// 分解能
)(
	// External Port
	output							oAudioMclk,
    // Internal Port
	// Bus Slave Read
	output	[31:0]					oSUsiRd,	// Read Data
	output							oSUsiREd,	// Read Valid Assert
	// Bus Slave Write
	input	[31:0]					iSUsiWd,	// Write Data
	input	[pBusAdrsBit-1:0]		iSUsiAdrs,  // R/W Adrs
	input							iSUsiWCke,	// Write Enable
    // CLK Reset
    input           				iSysRst,
    input           				iSysClk,
    input           				iAudioRst,
	input 							iAudioClk
);


//----------------------------------------------------------
// AudioTxUnit
//----------------------------------------------------------
wire 				wAudioCkeCsr;
wire 	[ 6:0]		wAudioToneCsr;
wire 				wAudioSelCsr;
wire 	[ 7:0]		wAudioDutyCsr;

AudioTxUnit #(
	.pSamplingBitWidth	(pSamplingBitWidth)
) AudioTxUnit (
	.oAudioMclk			(oAudioMclk),
	.iAudioCke			(wAudioCkeCsr),
	.iAudioTone			(wAudioToneCsr),
	.iAudioSel			(wAudioSelCsr),
	.iAudioDuty			(wAudioDutyCsr),
	.iAudioRst			(iAudioRst),
	.iAudioClk			(iAudioClk)
);


//----------------------------------------------------------
// Csr space
//----------------------------------------------------------
AudioTxCsr #(
	.pBlockAdrsMap		(pBlockAdrsMap),
	.pAdrsMap			(pAdrsMap),
	.pBusAdrsBit		(pBusAdrsBit),
	.pCsrAdrsWidth		(pCsrAdrsWidth),
	.pCsrActiveWidth	(pCsrActiveWidth)
) AudioTxCsr (
	.oSUsiRd			(oSUsiRd),
	.oSUsiREd			(oSUsiREd),
	.iSUsiWd			(iSUsiWd),
	.iSUsiAdrs			(iSUsiAdrs),
	.iSUsiWCke			(iSUsiWCke),
	.oAudioCke			(wAudioCkeCsr),
	.oAudioTone			(wAudioToneCsr),
	.oAudioSel			(wAudioSelCsr),
	.oAudioDuty			(wAudioDutyCsr),
	.iSysRst			(iSysRst),
	.iSysClk			(iSysClk)
);

endmodule