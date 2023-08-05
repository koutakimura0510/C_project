//////////////////////////////////////////////////////////////////////////////////
//  READ_WIDTH | BRAM_SIZE | READ Depth  | RDADDR Width |            |          //
// WRITE_WIDTH |           | WRITE Depth | WRADDR Width |  WE Width  | RAM_MODE //
// ============|===========|=============|==============|============|==========//
//       1     |  "10Kb"   |     8192    |    13-bit    |    1-bit   |   SDP    //
//       2     |  "10Kb"   |     4096    |    12-bit    |    1-bit   |   SDP    //
//     3-5     |  "10Kb"   |     2048    |    11-bit    |    1-bit   |   SDP    //
//     5-10    |  "10Kb"   |     1024    |    10-bit    |    1-bit   |   SDP    //
//    11-20    |  "10Kb"   |      512    |     9-bit    |    2-bit   |   SDP    //
//////////////////////////////////////////////////////////////////////////////////

module TrionSDPBRAM #(
parameter pDataWidth	= 16,
parameter pAddrWidth	= 16,
parameter pClkDomainAsync = "no"
)(
input [pDataWidth-1:0]	iWd,	// Write Data
input [pAddrWidth-1:0]	iWa,	// Write Adrs
input					iWe,	// Write Enable
output[pDataWidth-1:0]	oRd,	// Read Data
input [pAddrWidth-1:0]	iRa,	// Read Adrs
input 					iRe,	// Read Enable
input					iRCLK,
input					iWCLK
);

localparam lpClkDomainAsync = pClkDomainAsync == "yes" ? "READ_UNKNOWN" : "READ_FIRST";

EFX_RAM_5K #(
	// Polarity 0:ActiveLow, 1:Active High
	.WCLK_POLARITY(1'b1),		.WCLKE_POLARITY(1'b1),
	.WE_POLARITY(1'b1),
	.RCLK_POLARITY(1'b1),	 	.RE_POLARITY(1'b1),
	// Data Width
	.READ_WIDTH(pDataWidth), 		.WRITE_WIDTH(pDataWidth),
	// Output register enable
	.OUTPUT_REG(1'b0),
	// write mode
	.WRITE_MODE(lpClkDomainAsync),
	// 256-bit INIT string
	.INIT_0 (256'h0000000000000000000000000000000000000000000000000000000000000000),
	.INIT_1 (256'h0000000000000000000000000000000000000000000000000000000000000000),
	.INIT_2 (256'h0000000000000000000000000000000000000000000000000000000000000000),
	.INIT_3 (256'h0000000000000000000000000000000000000000000000000000000000000000),
	.INIT_4 (256'h0000000000000000000000000000000000000000000000000000000000000000),
	.INIT_5 (256'h0000000000000000000000000000000000000000000000000000000000000000),
	.INIT_6 (256'h0000000000000000000000000000000000000000000000000000000000000000),
	.INIT_7 (256'h0000000000000000000000000000000000000000000000000000000000000000),
	.INIT_8 (256'h0000000000000000000000000000000000000000000000000000000000000000),
	.INIT_9 (256'h0000000000000000000000000000000000000000000000000000000000000000),
	.INIT_A (256'h0000000000000000000000000000000000000000000000000000000000000000),
	.INIT_B (256'h0000000000000000000000000000000000000000000000000000000000000000),
	.INIT_C (256'h0000000000000000000000000000000000000000000000000000000000000000),
	.INIT_D (256'h0000000000000000000000000000000000000000000000000000000000000000),
	.INIT_E (256'h0000000000000000000000000000000000000000000000000000000000000000),
	.INIT_F (256'h0000000000000000000000000000000000000000000000000000000000000000),
	.INIT_10 (256'h0000000000000000000000000000000000000000000000000000000000000000),
	.INIT_11 (256'h0000000000000000000000000000000000000000000000000000000000000000),
	.INIT_12 (256'h0000000000000000000000000000000000000000000000000000000000000000),
	.INIT_13 (256'h0000000000000000000000000000000000000000000000000000000000000000)
) EFX_RAM_5K (
	.RDATA(oRd), 	// read data output
	.RADDR(iRa), 	// read address input
	.RCLK(iRCLK), 	// read clk
	.RE(iRe),		// read enable
	.WDATA(iWd), 	// write data input
	.WADDR(iWa), 	// write address input
	.WCLK(iWCLK), 	// write clk
	.WE(iWe),		// 1-bit write enable
	.WCLKE(iWe) 	// write clk enable
);

endmodule