//----------------------------------------------------------
// Create 2022/4/20
// Author koutakimura
// -
// フラッシュメモリの制御を行うブロック
// ブロック内の処理を分かりやすくするために、複雑なフロー処理はせずに、
// Enable 信号を受信したら、アドレスに対応したデータを Read / Write を行い、
// 書き込みの場合は データの形成が完了したら valid 信号と共に データを出力する方式にする。
// 複雑なフロー制御は 受け手側 Sys モジュールで行うようにする。
// (例えば Enable 発行後 valid 受信を完了時にアドレス更新など)
// 
//----------------------------------------------------------
module fcbWrapper #(
    parameter pClkDivsion = 400     // 分周数
)(
    // FPGA Pin
    output [1:0]    oQspiCs,        // Qspi Flash Memory chip select Low Active
    output [1:0]    oQspiSck,       // Qspi Flash Memory Clk
    inout  [1:0]    ioQspiDq0,      // SPI時 MOSI
    inout  [1:0]    ioQspiDq1,      // SPI時 MISO
    inout  [1:0]    ioQspiDq2,      // SPI時 High 固定, 書き込み保護 Low Active
    inout  [1:0]    ioQspiDq3,      // SPI時 High 固定, 書き込み停止 Low Active

    // Data Pixel Line
    output [15:0]   oPixel,         // Pixel Data ARGB 4:4:4:4 / YUV 4:2:2
    input  [23:0]   iPixelAddr,     // Flash Memory Address
    input           iPixelCke,      // Address Enable
    output          oPixelVd,       // 有効データ出力時 High


    // Data Sound Line
    output [15:0]   oSound,         // PCM 16bit 48000 Hz
    input  [23:0]   iSoundAddr,     // Flash Memory Address
    input           iSoundCke,      // Address Enable
    input           oSoundVd        // 有効データ出力時 High
);


//---------------------------------------------------------------------------
// SPI 接続
//---------------------------------------------------------------------------
wire [1:0] wQspiCs,  wQspiSck;
wire [1:0] wQspiDq0, wQspiDq1, wQspiDq2, wQspiDq3;

fmSpi FMB_SPI_PIXEL (
    .oCs            (wQspiCs  [0]),
    .oSck           (wQspiSck [0]),
    .oMosi          (wQspiDq0 [0]),
    .iMiso          (wQspiDq1 [0]),
    .oWp            (wQspiDq2 [0]),
    .oHold          (wQspiDq3 [0]),
    .oData          (oPixel),
    .iAddr          (iPixelAddr),
    .iCke           (iPixelCke),
    .oVd            (oPixelVd)
);

// fmbSpi FMB_SPI_SOUND (
//     .oCs            (wQspiCs  [1]),
//     .oSck           (wQspiSck [1]),
//     .oMosi          (wQspiDq0 [1]),
//     .iMiso          (wQspiDq1 [1]),
//     .oWp            (wQspiDq2 [1]),
//     .oHold          (wQspiDq3 [1]),
//     .oData          (oPixel),
//     .iAddr          (iPixelAddr),
//     .iCke           (iPixelCke),
//     .oVd            (oPixelVd)
// );


//---------------------------------------------------------------------------
// IOBUF
// .IO => input 端子
// .O  => I/O が入力ポート扱い (MISO)
// .I  => I/O が出力ポート扱い (MOSI)
// .T  => Tri State High Input / Low Output
//---------------------------------------------------------------------------
// Memory 0
OBUF OBUF_SPI_CS_0   (
    .O (oQspiCs   [0]),
    .I (wQspiCs   [0])
);

OBUF OBUF_SPI_SCK_0  (
    .O (oQspiSck  [0]),
    .I (wQspiSck  [0])
);

OBUF IOBUF_SPI_DQ0_0 (
    .O (ioQspiDq0 [0]),
    .I (wQspiDq0  [0])
);

IBUF IOBUF_SPI_DQ1_0 (
    .O (wQspiDq1  [0]),
    .I (ioQspiDq1 [0])
);

OBUF IOBUF_SPI_DQ2_0 (
    .O (ioQspiDq2 [0]),
    .I (wQspiDq2  [0])
);

OBUF IOBUF_SPI_DQ3_0 (
    .O (ioQspiDq3 [0]),
    .I (wQspiDq3  [0])
);

// Memory 1
OBUF OBUF_SPI_CS_1   (
    .O (oQspiCs   [1]),
    .I (wQspiCs   [1])
);

OBUF OBUF_SPI_SCK_1  (
    .O (oQspiSck  [1]),
    .I (wQspiSck  [1])
);

OBUF IOBUF_SPI_DQ0_1 (
    .O (ioQspiDq0 [1]),
    .I (wQspiDq0  [1])
);

IBUF IOBUF_SPI_DQ1_1 (
    .O (wQspiDq1  [1]),
    .I (ioQspiDq1 [1])
);

OBUF IOBUF_SPI_DQ2_1 (
    .O (ioQspiDq2 [1]),
    .I (wQspiDq2  [1])
);

OBUF IOBUF_SPI_DQ3_1 (
    .O (ioQspiDq3 [1]),
    .I (wQspiDq3  [1])
);



// wire [1:0] wOutQspiCs, wOutQspiSck;
// wire [1:0] wOutQspiDq0, wOutQspiDq1, wOutQspiDq2, wOutQspiDq3;
// wire [1:0] wInQspiDq0, wInQspiDq1, wInQspiDq2, wInQspiDq3;
// IOBUF QSPI_IOBUF_DQ0_0 (.O (wInQspiDq0[0]), .I (wOutQspiDq0[0]), .IO (ioQspiDq0[0]), .T (1'b0)  );
// IOBUF QSPI_IOBUF_DQ1_0 (.O (wInQspiDq1[0]), .I (wOutQspiDq1[0]), .IO (ioQspiDq1[0]), .T (1'b1)  );
// IOBUF QSPI_IOBUF_DQ2_0 (.O (wInQspiDq2[0]), .I (wOutQspiDq2[0]), .IO (ioQspiDq2[0]), .T (1'b0)  );
// IOBUF QSPI_IOBUF_DQ3_0 (.O (wInQspiDq3[0]), .I (wOutQspiDq3[0]), .IO (ioQspiDq3[0]), .T (1'b0)  );
// IOBUF QSPI_IOBUF_DQ0_0 (.O (wInQspiDq0[1]), .I (wOutQspiDq0[1]), .IO (ioQspiDq0[1]), .T (1'b0)  );
// IOBUF QSPI_IOBUF_DQ1_0 (.O (wInQspiDq1[1]), .I (wOutQspiDq1[1]), .IO (ioQspiDq1[1]), .T (1'b1)  );
// IOBUF QSPI_IOBUF_DQ2_0 (.O (wInQspiDq2[1]), .I (wOutQspiDq2[1]), .IO (ioQspiDq2[1]), .T (1'b0)  );
// IOBUF QSPI_IOBUF_DQ3_0 (.O (wInQspiDq3[1]), .I (wOutQspiDq3[1]), .IO (ioQspiDq3[1]), .T (1'b0)  );



endmodule