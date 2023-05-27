/*-----------------------------------------------------------------------------
 * Create  2023/5/6
 * Author  koutakimura
 * -
 * RAM IF moudle の Write/Read 処理
 * V1.0 : new Relaese
 * 
 * UfiAdrs Bit Assign
 * [31]    1'b1 Enable, 1'b0 Disable
 * [30]    1'b0 WriteCmd,  1'b1 ReadCmd
 * [28:25] Block ID
 * [24: 0] RAM Adrs
 *-----------------------------------------------------------------------------*/
module RamReadWriteArbiter #(
	parameter pUfiDqBusWidth = 16,
	parameter pUfiAdrsBusWidth = 32,
	parameter pFifoDepth = 256,
	parameter pUfiEnableBit = 32
)(
	// Bus Slave Write
	input  [pUfiDqBusWidth-1:0] iSUfiWd,
	input  [pUfiAdrsBusWidth-1:0] iSUfiAdrs,
	output oSUfiRdy,
	// Bus Slave Read
	output [pUfiDqBusWidth-1:0] oSUfiRd,
	output [pUfiAdrsBusWidth-1:0] oSUfiAdrs,
	// RAM IF Write Port
	output [pUfiDqBusWidth-1:0] oRamIfPortUnitWd,
	output [pUfiAdrsBusWidth-1:0] oRamIfPortUnitAdrs,
	// RAM IF Read Port
	input  [pUfiDqBusWidth-1:0] iRamIfPortUnitDq,
	input  iRamIfPortUnitWe,
    // CLK Reset
    input  iRST,
	input  inARST,
    input  iCLK
);


//-----------------------------------------------------------------------------
// Fifo Write
//-----------------------------------------------------------------------------
wire [1:0] wFifoWriteFull;
wire wFifoWriteEmp;
reg  qFifoWriteRe;

SyncFifoController #(
	.pFifoDepth(pFifoDepth),
	.pFifoBitWidth(pUfiDqBusWidth)
) DqWriteSyncFifoController (
	.iWd(iSUfiWd),
	.iWe(iSUfiAdrs[pUfiEnableBit-1]),
	.oFull(wFifoWriteFull[0]),
	.oRd(oRamIfPortUnitWd),
	.iRe(qFifoWriteRe),
	.oRvd(),
	.oEmp(wFifoWriteEmp),
	// CLK Reset
	.inARST(inARST),
	.iCLK(iCLK)
);

SyncFifoController #(
	.pFifoDepth(pFifoDepth),
	.pFifoBitWidth(pUfiAdrsBusWidth)
) AdrsWriteSyncFifoController (
	.iWd(iSUfiAdrs),
	.iWe(iSUfiAdrs[pUfiEnableBit-1]),
	.oFull(wFifoWriteFull[1]),
	.oRd(oRamIfPortUnitAdrs[30:0]),
	.iRe(qFifoWriteRe),
	.oRvd(oRamIfPortUnitAdrs[31]),
	.oEmp(),
	// CLK Reset
	.inARST(inARST),
	.iCLK(iCLK)
);
always @*
begin
	qFifoWriteRe <= ~wFifoWriteEmp;	// FIFOにデータがある場合は常にRAMへ出力する。
end


//-----------------------------------------------------------------------------
// Fifo Read
//-----------------------------------------------------------------------------
wire [1:0] wFifoReadFull;
wire wFifoReadEmp;
reg  qAdrsReadFifoWe, qAdrsReadFifoRe;
wire [31:0] wAdrsReadFifoRd;
wire wDqReadFifoRvd;

SyncFifoController #(
	.pFifoDepth(pFifoDepth),
	.pFifoBitWidth(pUfiDqBusWidth)
) DqReadSyncFifoController (
	.iWd(iRamIfPortUnitDq),
	.iWe(iRamIfPortUnitWe),
	.oFull(wFifoReadFull[0]),
	.oRd(oSUfiRd),
	.iRe(qAdrsReadFifoRe),
	.oRvd(wDqReadFifoRvd),
	.oEmp(wFifoReadEmp),
	// CLK Reset
	.inARST(inARST),
	.iCLK(iCLK)
);

SyncFifoController #(
	.pFifoDepth(pFifoDepth),
	.pFifoBitWidth(pUfiAdrsBusWidth)
) AdrsReadSyncFifoController (
	.iWd(iSUfiAdrs),
	.iWe(qAdrsReadFifoWe),
	.oFull(wFifoReadFull[1]),
	.oRd(wAdrsReadFifoRd),
	.iRe(qAdrsReadFifoRe),
	.oRvd(),
	.oEmp(),
	// CLK Reset
	.inARST(inARST),
	.iCLK(iCLK)
);

always @*
begin
	qAdrsReadFifoWe <= iSUfiAdrs[pUfiEnableBit-1] & iSUfiAdrs[30];
	qAdrsReadFifoRe <= ~wFifoReadEmp;
end

assign oSUfiAdrs[30:0] = wAdrsReadFifoRd[30:0];
assign oSUfiAdrs[31] = wDqReadFifoRvd;
assign oSUfiRdy = &{~wFifoReadFull[0],~wFifoReadFull[1],~wFifoWriteFull[1],~wFifoWriteFull[1]};

endmodule