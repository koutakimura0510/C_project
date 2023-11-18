/**-----------------------------------------------------------------------------
 * HyperRam Device Configration
 * https://www.infineon.com/dgdl/Infineon-AN226576_-_Getting_started_with_HYPERRAM_TM_JA-ApplicationNotes-v02_00-JA.pdf?fileId=8ac78c8c7cdc391c017d0d3995ec66e2
 * 
 * Device COnfigration Read / Write
 *
 * 23-11-14 v1.00: new release
 * 
 *-----------------------------------------------------------------------------*/
module HyperRamDeviceConfig #(
	parameter pRamAdrsWidth	= 19,
	parameter pRamDqWidth = 8
)(
	// Gpio Connect
	output[ 7:0]oMemDq,
	output		oMemDqOe,
	output		oMemRwds,
	output		oMemRwdsOe,
	output		oMemClk,
	output		oMemCs,
	// Internal Data
	input [ 7:0]iReadDq,
	input [15:0]iWDq,
	input [47:0]iCmdAdrs,
	// control / status
	input		iRwCmd,		// [0] Read, [1] Write
	input		iSeqEn,		// Sequence Start
	// Clk Reset
	input		iRST,
	input		iCKE,
	input		iCLK
);

/**----------------------------------------------------------------------------
 
 Identification Reg 0 Read		C0h, 00h, 00h, 00h, 00h, 00h
 Identification Reg 1 Read		C0h, 00h, 00h, 00h, 00h, 01h
 Configration   Reg 0 Read		C0h, 00h, 01h, 00h, 00h, 00h
 Configration   Reg 0 Write		60h, 00h, 01h, 00h, 00h, 00h
 Configration   Reg 1 Read		C0h, 00h, 01h, 00h, 00h, 01h
 Configration   Reg 1 Write		60h, 00h, 01h, 00h, 00h, 01h
 Die Manufacture Info Read		C0h, 00h, 02h, 00h, 00h, 00h - 11h

 *---------------------------------------------------------------------------*/
localparam
	lpIdol		= 3'd0,
	lpCsAssert	= 3'd1,
	lpRWDS		= 3'd2,
	lpCmdAdrs	= 3'd3,
	lpDqSeq1	= 3'd4,
	lpDqSeq2	= 3'd5,
	lpComplete	= 3'd6;

// Intenal Logic	
reg [ 2:0] 	rSt;
// Gpio Connect
reg 		rMemClk;					assign oMemClk		= rMemClk;
reg 		rMemCs;						assign oMemCs		= rMemCs;
reg [47:0] 	rMemDq;						assign oMemDq		= rMemDq[47:40];
reg 		rMemDqOe;					assign oMemDqOe		= rMemDqOe;
reg 		rMemRwds;					assign oMemRwds		= rMemRwds;
reg 		rMemRwdsOe;					assign oMemRwdsOe	= rMemRwdsOe;


/**----------------------------------------------------------------------------
 * State Machine
 *---------------------------------------------------------------------------*/
always @(negedge iCLK)
begin
	if (iRST) 	rMemClk <= 1'b0;
	else if ()	rMemClk <= ~rMemClk;
	else 		rMemClk <= 1'b0;
end

always @(negedge iCLK)
begin
	if (iRST) 	rMemClk <= 1'b0;
	else if ()	rMemClk <= ~rMemClk;
	else 		rMemClk <= 1'b0;
end
 
always @(posedge iCLK)
begin
	if (iRST)
	begin
		rSt 		<= lpIdol;
		rMemDq		<= 48'd0;
		rMemCs		<= 1'b1;
		rMemDqOe	<= 1'b0;
		rMemRwds	<= 1'b0;
		rMemRwdsOe	<= 1'b0;
	end
	else
	begin
	case (rSt)
		lpIdol:
		begin
			rSt 		<= qNectStCke ? lpCsAssert : lpIdol;
			rMemDq		<= iCmdAdrs;
			rMemCs		<= 1'b1;
			rMemDqOe	<= 1'b0;
			rMemRwds	<= 1'b0;
			rMemRwdsOe	<= 1'b0;
		end
		
		lpCsAssert:
		begin
			rSt 		<= lpRWDS;
			rMemDq		<= rMemDq;
			rMemCs 		<= 1'b0;
			rMemDqOe	<= rMemDqOe;
			rMemRwds	<= rMemRwds;
			rMemRwdsOe	<= rMemRwdsOe;
		end
		
		lpRWDS:
		begin
			rSt 		<= lpCmdAdrs;
			rMemDq		<= rMemDq;
			rMemCs 		<= rMemCs;
			rMemDqOe	<= 1'b1;
			rMemRwds	<= rMemRwds;
			rMemRwdsOe	<= 1'b1;
		end
		
		lpCmdAdrs:
		begin
			rSt 		<= qNectStCke ? lpDqSeq1 : lpCmdAdrs;
			rMemDq		<= {rMemDq[39:0],rMemDq[47:40]};
			rMemCs 		<= rMemCs;
			rMemDqOe	<= rMemDqOe;
			rMemRwds	<= rMemRwds;
			rMemRwdsOe	<= rMemRwdsOe;
		end
		
		lpDqSeq1:
		begin
			rSt 		<= lpDqSeq2;
			rMemDq[47:40]<= iWDq[15:8];
			rMemDq[39:0]<= rMemDq[39:0];
			rMemCs 		<= rMemCs;
			rMemDqOe	<= iRwCmd;
			rMemRwds	<= rMemRwds;
			rMemRwdsOe	<= iRwCmd;
		end
		
		lpDqSeq2:
		begin
			rSt 		<= lpComplete;
			rMemDq[47:40]<= iWDq[7:0];
			rMemDq[39:0]<= rMemDq[39:0];
			rMemCs 		<= rMemCs;
			rMemDqOe	<= rMemDqOe;
			rMemRwds	<= rMemRwds;
			rMemRwdsOe	<= rMemRwdsOe;
		end
		
		lpComplete:
		begin
			rSt 		<= lpIdol;
			rMemDq		<= rMemDq;
			rMemCs 		<= 1'b1;
			rMemDqOe	<= 1'b0;
			rMemRwds	<= 1'b0;
			rMemRwdsOe	<= 1'b0;
		end
		
		default:
		begin
			rSt 		<= lpIdol;
			rMemDq		<= rMemDq;
			rMemCs 		<= 1'b1;
			rMemDqOe	<= 1'b0;
			rMemRwds	<= 1'b0;
			rMemRwdsOe	<= 1'b0;
		end
	endcase
	end
end


/**----------------------------------------------------------------------------
 * ステートマシン制御ロジック & ステータス管理
 *---------------------------------------------------------------------------*/
reg [2:0] 	rCmdCnt;
reg 		qCmdCntCke;

always @(posedge iCLK)
begin
	if (iRST) 				rCmdCnt <= 3'd0;
	else if (qCmdCntCke)	rCmdCnt <= rCmdCnt + 1'b1;
	else					rCmdCnt <= 3'd0;
end

always @*
begin
	qCmdCntCke <= (rSt == lpCmdAdrs) ? 1'b1 : 1'b0;
	
	casex ({rSt, (rCmdCnt==3'd4), iSeqEn})
		{lpIdol, 	2'bx1}:	qNectStCke <= 1'b1;
		{lpCmdAdrs, 2'b1x}:	qNectStCke <= 1'b1;
		default: 			qNectStCke <= 1'b0;
  	endcase
end

endmodule