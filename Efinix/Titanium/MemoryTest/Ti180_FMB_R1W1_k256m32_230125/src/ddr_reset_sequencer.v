/////////////////////////////////////////////////////////////////////////////
//
// Copyright (C) 2013-2019 Efinix Inc. All rights reserved.
//
// Description:
//
// Efinix soft logic DDR system reset controller
//
// The Trion DDR controller block, (instantiated in the Interface Designer),
// has three input pins for reset control.  (when I2C calibration not enabled)
//
//     Master Reset (active low)
//     Sequencer Reset (active high)
//     Sequencer Start (active high)
//
// This Verilog module generates outputs that can directly
// connect to these pins, given a single reset signal and a clock.
//
// The module also generates a "done" status signal, to inform user system
// when reset + DDR-reinitialization is completed, and read/write operations
// to the DDR AXI interfaces may resume.  The user should define
// FREQ parameter to correspond to frequency of their clock signal.
//
// NOTE #1:  This reset sequencer resets and re-initializes both the DDR
//           interface of the Trion device, as well as the DDR module(s)
//           themselves.
//
// NOTE #2:  The user is not expected to pulse reset upon device configuration
//           and initial entry to user mode.  During the configuration process
//           DDR reset and initialization will be triggered automatically.  This
//           soft logic reset is only required if the user needs to reset
//           the DDR system again while maintaining the Trion device in user mode.
//
// Language:  Verilog 2001
//
// ------------------------------------------------------------------------------
// REVISION:
//  $Snapshot: $
//  $Id:$
//
// History:
// 1.0 Initial Release. 
/////////////////////////////////////////////////////////////////////////////////
module ddr_reset_sequencer #(
parameter	pStartCntBitWidth	= 8
)(
input 		i_ddr_cfg_done,		// DDR_CFG_DONE
/* Connect these three signals to DDR reset interface */
output 		o_ddr_axi_rstn,		// Master Reset
output 		o_ddr_cfg_reset,	// Sequencer Reset
output 		o_ddr_cfg_start,	// Sequencer Start
output 		o_ddr_cfg_done,		// Done status
// common
input 		inRST,
input 		iCLK				// user clock
);



//-----------------------------------------------------------------------------
// CFG Aequenser RESET, START
//-----------------------------------------------------------------------------
localparam 
	lpReset = 2'd0,
	lpStart = 2'd1,
	lpDone 	= 2'd2;

reg r_ddr_axi_rstn;							assign o_ddr_axi_rstn 		= r_ddr_axi_rstn;
reg r_ddr_cfg_seq_rst;						assign o_ddr_cfg_reset		= r_ddr_cfg_seq_rst;
reg r_ddr_cfg_seq_start;					assign o_ddr_cfg_start		= r_ddr_cfg_seq_start;
reg r_ddr_init_done;						assign o_ddr_cfg_done 		= r_ddr_init_done;
//
reg [1:0] rs;
reg [pStartCntBitWidth-1:0] rSeqCnt;
reg rSeqMaxCke;

initial
begin
	r_ddr_axi_rstn		<= 1'b0;
	r_ddr_cfg_seq_rst	<= 1'b1;
	r_ddr_cfg_seq_start	<= 1'b0;
end

always @(posedge iCLK, negedge inRST)
begin
	if (!inRST)
	begin
		rs      			<= lpReset;
		rSeqCnt 			<= {pStartCntBitWidth{1'b0}};
		r_ddr_axi_rstn		<= 1'b0;
		r_ddr_cfg_seq_rst	<= 1'b1;
		r_ddr_cfg_seq_start	<= 1'b0;
		r_ddr_init_done		<= 1'b0;
	end
	else
	begin
		case ( rs )
			lpReset:
			begin
				rs      			<= (rSeqMaxCke) ? lpStart : lpReset;
				rSeqCnt 			<= (rSeqMaxCke) ? {pStartCntBitWidth{1'b0}} : rSeqCnt + 1'b1;
				r_ddr_axi_rstn		<= 1'b0;
				r_ddr_cfg_seq_rst	<= 1'b0;
				r_ddr_cfg_seq_start	<= 1'b0;
				r_ddr_init_done		<= 1'b0;
			end

			lpStart:
			begin
				rs 					<= (i_ddr_cfg_done) ? lpDone : lpStart;
				rSeqCnt 			<= rSeqCnt;
				r_ddr_axi_rstn		<= 1'b0;
				r_ddr_cfg_seq_rst	<= 1'b0;
				r_ddr_cfg_seq_start	<= 1'b1;
				r_ddr_init_done		<= 1'b0;
			end

			lpDone:
			begin
				rs 					<= rs;
				rSeqCnt 			<= rSeqCnt;
				r_ddr_axi_rstn		<= 1'b1;
				r_ddr_cfg_seq_rst	<= 1'b0;
				r_ddr_cfg_seq_start	<= 1'b1;
				r_ddr_init_done		<= 1'b1;
			end

			default:
			begin
				rs      			<= lpReset;
				rSeqCnt 			<= {pStartCntBitWidth{1'b0}};
				r_ddr_axi_rstn		<= 1'b0;
				r_ddr_cfg_seq_rst	<= 1'b1;
				r_ddr_cfg_seq_start	<= 1'b0;
				r_ddr_init_done		<= 1'b0;
			end
		endcase
	end
end

always @*
begin
	rSeqMaxCke <= (rSeqCnt == {pStartCntBitWidth{1'b1}});
end
endmodule