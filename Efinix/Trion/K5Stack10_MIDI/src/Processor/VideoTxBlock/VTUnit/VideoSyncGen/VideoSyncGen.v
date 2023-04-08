//----------------------------------------------------------
// Create 2022/8/28
// Author koutakimura
// -
// 指定タイミングの Video Sync 信号を生成する
// 
//----------------------------------------------------------
module VideoSyncGen #(
	// Display Size
    parameter       				pHdisplayWidth	= 11,
    parameter       				pVdisplayWidth	= 11
)(
	// Internal Port
	//
	input	[pHdisplayWidth-1:0]	iHdisplay,
	input	[pVdisplayWidth-1:0]	iVdisplay,
	input	[pHdisplayWidth:0]		iHSyncStart,
	input	[pHdisplayWidth:0]		iHSyncEnd,
	input	[pHdisplayWidth:0]		iHSyncMax,
	input	[pVdisplayWidth:0]		iVSyncStart,
	input	[pVdisplayWidth:0]		iVSyncEnd,
	input	[pVdisplayWidth:0]		iVSyncMax,
	//
    output          				oHSync,				// horizontal area 水平同期信号
    output          				oVSync,				// vertical area 垂直同期信号
    output          				oVde,				// video data enable 描画エリア時High
    output          				oFe,				// frame end
	//
    input           				iRST,
	input 							iVideoClk
);


//----------------------------------------------------------
// 水平同期カウンター
//----------------------------------------------------------
reg rHSync;             		assign oHSync = rHSync;
reg [pHdisplayWidth:0] 	rHpos;
reg qHMaxCntCke, qHSync;

always @(posedge iVideoClk)
begin 
    if (iRST)        		rHpos <= {(pHdisplayWidth+1){1'b0}};
    else if (qHMaxCntCke)  	rHpos <= {(pHdisplayWidth+1){1'b0}};
    else                	rHpos <= rHpos + 1'b1;

    if (iRST)        		rHSync <= 1'b1;
	else if (qHSync)		rHSync <= 1'b0;
    else                	rHSync <= 1'b1;
end

always @*
begin
    qHMaxCntCke <= (rHpos == iHSyncMax);
    qHSync 		<= (iHSyncStart <= rHpos && rHpos <= iHSyncEnd);
end


//----------------------------------------------------------
// 垂直同期カウンター
//----------------------------------------------------------
reg rVSync;		                assign oVSync   = rVSync;
reg [pVdisplayWidth:0] rVpos;
reg qVMaxCntCke, qVSync;

always @(posedge iVideoClk) 
begin
	casex ({iRST, qVMaxCntCke, qHMaxCntCke})
		3'b1xx:			rVpos <= {(pVdisplayWidth+1){1'b0}};
		3'b001:			rVpos <= rVpos + 1'b1;
		3'b011:			rVpos <= {(pVdisplayWidth+1){1'b0}};
		default: 		rVpos <= rVpos;
	endcase

    if (iRST)			rVSync <= 1'b1;
	else if (qVSync)	rVSync <= 1'b0;
    else                rVSync <= 1'b1;
end

always @*
begin
    qVMaxCntCke <= (rVpos == iVSyncMax);
    qVSync		<= (iVSyncStart <= rVpos && rVpos <= iVSyncEnd);
end


//-----------------------------------------------------------------------------
// DE,FrameEnd 信号生成
//-----------------------------------------------------------------------------
reg rVde, rFe;					assign {oVde,oFe} = {rVde,rFe};
reg qVde, qFe;

always @(posedge iVideoClk) 
begin
    if (iRST)           	rVde <= 1'b0;
	else if (qVde)			rVde <= 1'b1;
    else                	rVde <= 1'b0;

    if (iRST)           	rFe <= 1'b0;
	else if (qFe)			rFe <= 1'b1;
    else                	rFe <= 1'b0;
	//
end

always @*
begin
    qVde    <= (rHpos  < iHdisplay) && (rVpos  < iVdisplay);
    qFe     <= (rHpos == iHdisplay) && (rVpos == iVdisplay);
end

endmodule