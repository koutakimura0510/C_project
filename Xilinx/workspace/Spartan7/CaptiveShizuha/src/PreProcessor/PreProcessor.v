//----------------------------------------------------------
// Create 2022/4/21
// Author koutakimura
// -
// ホスト前処理ブロック
//----------------------------------------------------------
module PreProcesser #(
    parameter       pHdisplay       = 640,
    parameter       pHback          =  48,
    parameter       pHfront         =  16,
    parameter       pHsync          =  96,
    parameter       pVdisplay       = 480,
    parameter       pVtop           =  31,
    parameter       pVbottom        =  11,
    parameter       pVsync          =   2,
    parameter       pPixelDebug     = "off"
)(
    input           iClk,
    output          oTmdsClk,       // Tmds Clk
    output          oPixelClk,      // Pixel Clk
    output          oSysClk,       // Sys Clk
    output          oRst,           // Active High Sync Reset
    output          oVde,
    output          oFe,
    output          oFvde,
    output          oHsync,
    output          oVsync
);


//----------------------------------------------------------
// System Reset Gen
//----------------------------------------------------------
wire wClkRst;

rstGen #(
    .pRstFallTime   (100)
) SYSTEM_RST (
    .iClk           (iClk),
    .oRst           (wClkRst),
);


//----------------------------------------------------------
// Clock Generate Block
// PixelClk 25  MHz
// TmdsClk  250 MHz
// SysClk   100 MHz
//----------------------------------------------------------
wire wTmdsClk, wPixelClk, wSysClk;      assign {oTmdsClk, oPixelClk, oSysClk} = {wTmdsClk, wPixelClk, wSysClk};
wire wSysRst;                           assign oRst = wSysRst;

cgbWrapper CGB (
    .iClk       (iClk),
    .iRst       (wClkRst),
    .oRst       (wSysRst),
    .oTmdsClk   (wTmdsClk),
    .oPixelClk  (wPixelClk),
    .oSysClk    (wSysClk)
);


//----------------------------------------------------------
// Display Timing Block 
//----------------------------------------------------------
wire wVde, wFe, wFvde, wHsync, wVsync;

assign oVde     = wVde;
assign oFe      = wFe;
assign oFvde    = wFvde;
assign oHsync   = wHsync;
assign oVsync   = wVsync;

dtbWrapper #(
    .pHdisplay  (pHdisplay),
    .pHback     (pHback),
    .pHfront    (pHfront),
    .pHsync     (pHsync),
    .pVdisplay  (pVdisplay),
    .pVtop      (pVtop),
    .pVbottom   (pVbottom),
    .pVsync     (pVsync)
) DTP (
    .iClk       (wPixelClk),
    .iRst       (wSysRst),
    .oVde       (wVde),
    .oFe        (wFe),
    .oFvde      (wFvde),
    .oHsync     (wHsync),
    .oVsync     (wVsync)
);

endmodule