//----------------------------------------------------------
// Create 2021/2/5
// Author koutakimura
// Editor VSCode ver1.62.7
// Build  Vivado20.2
// Borad  Nexys Video
// -
// User Interface module <-> DDR3 Memory Controller Bridge module
// 
// ユーザーインタフェースとDDR3メモリの送受信データの管理を行う。
// RW sideはそれぞれ独立していて、RWのHand.Shakeを利用し、上位モジュールがこのモジュールの動作を管理する
// RWアドレスを指定するiWAとiRAは本来であればpDramAddrWidthのサイズだが、
// モジュール内で確保しているFIFOのBitsizeが32bitなため、32bitで定義している
//----------------------------------------------------------
module ddr3Bridge #(
    parameter pDramAddrWidth = 29,
    parameter pDramDataWidth = 128,
    parameter pDramMaskWidth = 16,
    parameter pBuffDepth     = 16,          // bram length
    parameter pBitDepth      = 32           // data bit
)(
    input                   iCLK,           // system clk
    input                   iRST,           // reset High

    // DDRメモリ制御GPIO
    inout  [15:0]           ioDDR3_DQ,      // ddr portはtopモジュールから接続
    inout  [ 1:0]           ioDDR3_DQS_N,
    inout  [ 1:0]           ioDDR3_DQS_P,
    output [14:0]           oDDR3_ADDR,
    output [ 2:0]           oDDR3_BA,
    output                  oDDR3_RAS,
    output                  oDDR3_CAS,
    output                  oDDR3_WE,
    output                  oDDR3_RESET,
    output                  oDDR3_CLK_P,
    output                  oDDR3_CLK_N,
    output                  oDDR3_CKE,
    output [ 1:0]           oDDR3_DM,
    output                  oDDR3_ODT,

    // インターフェース制御信号一覧
    // write side
    input  [pBitDepth-1:0]      iWD,                // WriteData
    input  [pBitDepth-1:0]      iWA,                // Write Addr [28]:0固定 / [27-25]:Bank / [24-10]:Row / [9-3]:Col / [2:0]:0固定
    input  [pDramMaskWidth-1:0] iMask,              // write mask 1を立てることでその範囲は書き込まないようにできる 基本0
    input                       iWvalid,            // write enable信号
    output                      oWready,            // write ready Active High

    // read data side
    output [pBitDepth-1:0]      oRD,                // Pixel Read Data
    output                      oRVD,               // 有効データ出力時High Read Valid Data
    input  [pBitDepth-1:0]      iRA,                // Read Addr [28]:0固定 / [27-25]:Bank / [24-10]:Row / [9-3]:Col / [2:0]:0固定
    input                       iRvalid,            // read addr enable
    output                      oRready,            // read ready Active High

    // user clk
    output                      oUiCLK,             // user clk 100mhz
    output                      oUiRST,             // user rst Active High
    output                      oInitCalibComplete
);

////////////////////////////////////////////////////////////
wire wUiCLK;    assign oUiCLK = wUiCLK;
wire wUiRST;    assign oUiRST = wUiRST;


////////////////////////////////////////////////////////////
//----------------------------------------------------------
// read / write 切り替えステートマシン
//----------------------------------------------------------
localparam [1:0]
    lpIDOL  = 0,
    lpREAD  = 1,
    lpWRITE = 2;

wire wRready, wWready;
reg  rRready, rWready;              assign {oRready, oWready} = {rRready, rWready};
reg  [1:0] state;

always @(posedge wUiCLK)
begin
    if (wUiRST)
    begin
        {state, rRready, rWready} <= {lpIDOL, 2'b00};
    end
    else
    begin
        casex (state)
            lpIDOL:  {state, rRready, rWready} <= (wRready & wWready) ? {lpREAD, 2'b01}  : {lpIDOL, 2'b00};
            lpREAD:  {state, rRready, rWready} <= (wRready & wWready) ? {lpWRITE, 2'b10} : {lpREAD, 2'b00};
            lpWRITE: {state, rRready, rWready} <= (wRready & wWready) ? {lpREAD, 2'b01}  : {lpWRITE, 2'b00};
            default: {state, rRready, rWready} <= (wRready & wWready) ? {lpIDOL, 2'b00}  : {lpIDOL, 2'b00};
        endcase
    end
end


////////////////////////////////////////////////////////////
//----------------------------------------------------------
// DDR入力データ選択、Read優先
//----------------------------------------------------------
reg [pBitDepth-1:0] rData, rAddr;
reg [1:0] rDdrValid;

always @(posedge wUiCLK)
begin
    if (wUiRST)     {rData, rAddr} <= {32'd0, 32'd0};
    else            {rData, rAddr} <= (iRvalid) ? {32'd0, iRA} : {iWD, iWA};
end

always @(posedge wUiCLK)
begin
    if (wUiRST)     rDdrValid <= 2'b00;
    else            rDdrValid <= {iRvalid, iWvalid};
end

////////////////////////////////////////////////////////////
ddr3Controller #(
    .pDramAddrWidth     (pDramAddrWidth),
    .pDramDataWidth     (pDramDataWidth),
    .pDramMaskWidth     (pDramMaskWidth),
    .pDebug             ("on")
) DDR3_CONTROLLER (
    // DDR port                             hand shake
    .ioDDR3_DQ          (ioDDR3_DQ),        .iWEnable           (rDdrValid[0]),
    .ioDDR3_DQS_N       (ioDDR3_DQS_N),     .iREnable           (rDdrValid[1]),
    .ioDDR3_DQS_P       (ioDDR3_DQS_P),     .iWdData            ({96'd0, rData}),
    .oDDR3_ADDR         (oDDR3_ADDR),       .iAddr              (rAddr[28:0]),
    .oDDR3_BA           (oDDR3_BA),         .iMask              (iMask),
    .oDDR3_RAS          (oDDR3_RAS),        .oRdData            (oRD),
    .oDDR3_CAS          (oDDR3_CAS),        .oRdDataValid       (oRVD),
    .oDDR3_WE           (oDDR3_WE),         .oReady             (wRready),
    .oDDR3_RESET        (oDDR3_RESET),      .oWdReady           (wWready),
    .oDDR3_CLK_P        (oDDR3_CLK_P),      .oInitCalibComplete (oInitCalibComplete),
    .oDDR3_CLK_N        (oDDR3_CLK_N),
    .oDDR3_CKE          (oDDR3_CKE),
    .oDDR3_DM           (oDDR3_DM),
    .oDDR3_ODT          (oDDR3_ODT),

    // user interface clk rst
    .iCLK               (iCLK),             .iRST               (iRST),
    .oUiCLK             (wUiCLK),           .oUiRST             (wUiRST)
);

endmodule