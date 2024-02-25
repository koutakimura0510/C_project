/**-----------------------------------------------------------------------------
 * 24-02-05 v1.00: new release
 * 
 *-----------------------------------------------------------------------------*/
module MemoryAccessTester #(
	parameter pRamDqWidth = 16
)(
	// Test Port to Ram Port
	output	[pRamDqWidth-1:0] 	oTestDq,
	output						oTestCs,
	output						oTestClk,
	output						oTestOe,
	input	[pRamDqWidth-1:0] 	iTestRd,
	input						iTestRe,
	// Control, Status
	output						oTestEn,
	output						oTestErr,
	output						oTestDone,
	input						iTestEn,
	// Mcu Memory Side
	input	[pRamDqWidth-1:0]	iMemWd,
	input						iMemWdOe,
	input	[7:0]				iMemWa,
	input						iMemWe,
	output	[pRamDqWidth-1:0]	oMemRd,
	input	[7:0]				iMemRa,
	// CLK Reset
    input  						iRST,
    input  						iCLK
);


/**----------------------------------------------------------------------------
 外部 HyperRam のテストアクセスを行う
 MCU 動作手順を下記に示す。
 
  [write pattern]
  ・iRST Assert
  ・iMemW Froup で Memroy にデータ書き込み
  ・Enable Assert
  ・Done Assert
  ・iRST Negate
  
  [read pattern]
  ・iRST Assert
  ・iMemW Froup で Memroy にデータ書き込み
  ・Enable Assert
  ・Done Assert
  ・iRST Negate
  
 *---------------------------------------------------------------------------*/
reg  [pRamDqWidth-1:0]	rTestDq;					assign oTestDq	 = rTestDq;
reg  					rTestCs;					assign oTestCs	 = rTestCs;
reg  					rTestClk;					assign oTestClk	 = rTestClk;
reg  					rTestOe;					assign oTestOe	 = rTestOe;
reg  					rTestEn;					assign oTestEn	 = rTestEn;
//
reg						rTestDone;					assign oTestDone = rTestDone;
reg						qTestDoneCke;
reg  [pRamDqWidth-1:0]	qTestDq;
reg						qTestOe;
reg						qTestCke,	qTestClkCke;
reg						qTestRun;

always @(posedge iCLK)
begin
	if (iRST) 				rTestDq <=  16'd0;
	else if (qTestCke) 		rTestDq <=  qTestDq;
	else 					rTestDq <=  rTestDq;
	
	if (iRST) 				rTestCs <= 1'b1;
	else if (qTestRun) 		rTestCs <= 1'b0;
	else 					rTestCs <= 1'b1;
	
	if (iRST) 				rTestOe <= 1'b0;		// default read
	else 					rTestOe <= qTestOe;
	
	if (iRST) 				rTestEn <= 1'b0;
	else if (qTestRun) 		rTestEn <= 1'b1;
	else 					rTestEn <= 1'b0;
	
	if (iRST) 				rTestClk <=  1'b0;
	else if (qTestClkCke)	rTestClk <= ~rTestClk;
	else 					rTestClk <=  rTestClk;
	
	if (iRST) 				rTestDone <= 1'b0;
	else if (qTestDoneCke)	rTestDone <= 1'b1;
	else 					rTestDone <= rTestDone;
end

always @*
begin
	qTestCke 		<= iTestEn & rTestClk;
	qTestRun		<= iTestEn & (~rTestDone);
	qTestClkCke		<= ~rTestCs;
end

/**----------------------------------------------------------------------------
 * Mem Write Side
 *---------------------------------------------------------------------------*/
reg [pRamDqWidth-1:0]	rWMem	[0:255];
reg 					rWMemOe [0:255];
reg [pRamDqWidth-1:0]	rWMemRd;
reg 					rWMemRdOe;
reg [7:0] 				rWMemRa;
reg						qWMemRaCke;

always @(posedge iCLK)
begin
	if (iMemWe) 	rWMem[iMemWa] 	<= iMemWd;
	rWMemRd	<= rWMem[rWMemRa];
	
	if (iMemWe) 	rWMemOe[iMemWa] <= iMemWdOe;
	rWMemRdOe	<= rWMemOe[rWMemRa];
	
	if (iRST)				rWMemRa <= 8'd0;
	else if (qWMemRaCke)	rWMemRa <= rWMemRa + 1'b1;
	else 					rWMemRa <= rWMemRa;
	
end

always @*
begin
	qTestDq			<= rWMemRd;
	qTestOe			<= rWMemRdOe;
	qWMemRaCke		<= (~rTestCs) & (~rTestClk);
	qTestDoneCke	<= rWMemRa == 8'hff;
end


/**----------------------------------------------------------------------------
 * Mem Read Side
 *---------------------------------------------------------------------------*/
reg [pRamDqWidth:0]		rRMem [0:255];
reg [pRamDqWidth-1:0]	rRMemRd;						assign oMemRd = rRMemRd;
reg	[7:0]				rRMemWa;

always @(posedge iCLK)
begin
	if (iTestRe) rRMem[rRMemWa] <= iTestRd;
	rRMemRd	<= rRMem[iMemRa];
	
	if (iRST)			rRMemWa <= 8'd0;
	else if (iTestRe)	rRMemWa <= rRMemWa + 1'b1;
	else				rRMemWa <= rRMemWa;
end

assign oTestErr	 = 1'b0;	// 24-02-23 現状使用しない

endmodule