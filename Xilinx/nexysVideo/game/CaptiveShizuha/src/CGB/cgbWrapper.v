//----------------------------------------------------------
// Create  2022/4/5
// Author  koutakimura
// Editor  VSCode ver1.62.7
// Build   Vivado20.2
// Borad   Nexys Video
// -
// Latency --
// -
// CLK Generate Block
// クロックの生成を行うブロック
// 
//----------------------------------------------------------
module cgbWrapper (
    input           iCLK,           // system clk
    input           iRST,           // Active High
    output          oRST,           // Active High
    output          oTCLK,
    output          oPCLK,
    output          oBCLK
);


//----------------------------------------------------------
// Input Clk Buffer
//----------------------------------------------------------
wire wClkIbuf;

IBUF # (
    .IBUF_LOW_PWR ("FALSE"),
    .IOSTANDARD   ("DEFAULT")
) IBUF_ICLK (    
    .O (wClkIbuf),
    .I (iCLK)
);


//----------------------------------------------------------
// VOC Settings
//----------------------------------------------------------
localparam      lpBandWidth      = "OPTIMIZED"; // Rst Active High
localparam      lpStartWait      = "FALSE";     // Delay DONE until PLL Locks, ("TRUE"/"FALSE")
localparam real lpClkIn1Period   = 10.000;      // 100[MHz]
localparam      lpClkIn1Div      = 1;           // 100[MHz] / 1 = 100[MHz]

// VOC 分周回路設定
// Sped Grade 1 = (600 ~ 1200MHz)
localparam real lpClkOutMult     = 10.000;      // 100MHz  * 10 = 1000[MHz]
localparam real lpClk0OutDivF    = 40.000;      // 1000MHz / 40 =   25[MHz]
localparam      lpClk1OutDiv     = 4;           // 1000MHz /  4 =  250[MHz]
localparam      lpClk2OutDiv     = 10;          // 1000MHz / 10 =  100[MHz]
localparam      lpClk3OutDiv     = 10;          // <Reserved>
localparam      lpClk4OutDiv     = 10;          // <Reserved>
localparam      lpClk5OutDiv     = 10;          // <Reserved>

wire wLock;                     assign oRST = (~wLock);
wire wClkOutFb, wClkInFb;
wire [6:0] wClkOut;
wire [8:0] wunused;

MMCME2_BASE # (
    // 入力クロック (Div 1 ~ 56)
    .CLKIN1_PERIOD        (lpClkIn1Period),
    .DIVCLK_DIVIDE        (lpClkIn1Div),

    // コントロール設定
    .BANDWIDTH            (lpBandWidth),
    .CLKOUT4_CASCADE      ("FALSE"),
    .STARTUP_WAIT         (lpStartWait),

    // Ref In Jitter (0.000 ~ 0.999)
    .REF_JITTER1          (0.0), 

    // 逓倍 (2.000 ~ 64.000)
    .CLKFBOUT_MULT_F      (lpClkOutMult),

    // (1.000 ~ 128.000)
    .CLKOUT0_DIVIDE_F     (lpClk0OutDivF),

    // 分周 (1 ~ 128)
    .CLKOUT1_DIVIDE       (lpClk1OutDiv),
    .CLKOUT2_DIVIDE       (lpClk2OutDiv),
    .CLKOUT3_DIVIDE       (lpClk3OutDiv),
    .CLKOUT4_DIVIDE       (lpClk4OutDiv),
    .CLKOUT5_DIVIDE       (lpClk5OutDiv),

    // 位相調整 (-360.000 ~ 360.000)
    .CLKFBOUT_PHASE       (0.000),
    .CLKOUT0_PHASE        (0.000),
    .CLKOUT1_PHASE        (0.000),
    .CLKOUT2_PHASE        (0.000),
    .CLKOUT3_PHASE        (0.000),
    .CLKOUT4_PHASE        (0.000),
    .CLKOUT5_PHASE        (0.000),

    // Duty比 (0.001 ~ 0.999)
    .CLKOUT0_DUTY_CYCLE   (0.500),
    .CLKOUT1_DUTY_CYCLE   (0.500),
    .CLKOUT2_DUTY_CYCLE   (0.500),
    .CLKOUT3_DUTY_CYCLE   (0.500),
    .CLKOUT4_DUTY_CYCLE   (0.500),
    .CLKOUT5_DUTY_CYCLE   (0.500)
) MMCME2_BASE_CLK_GEN (
    .CLKOUT0             (wClkOut[0]),      // 1-bit output
    .CLKOUT1             (wClkOut[1]),      // 1-bit output
    .CLKOUT2             (wClkOut[2]),      // 1-bit output
    .CLKOUT3             (wClkOut[3]),      // 1-bit output
    .CLKOUT4             (wClkOut[4]),      // 1-bit output
    .CLKOUT5             (wClkOut[5]),      // 1-bit output
    .CLKOUT6             (wClkOut[6]),      // 1-bit output
    .CLKFBOUT            (wClkOutFb),       // 1-bit output FeedBack

    // Bと付く部分は反転出力
    .CLKFBOUTB           (wunused[0]),
    .CLKOUT0B            (wunused[1]),
    .CLKOUT1B            (wunused[2]),
    .CLKOUT2B            (wunused[3]),
    .CLKOUT3B            (wunused[4]),
    .CLKFBIN             (wClkInFb),        // 1-bit input  BUFG Clk
    .CLKIN1              (wClkIbuf),        // 1-bit input  IBUF Clk
    .LOCKED              (wLock),           // 1-bit output IBUF Clk
    .PWRDWN              (1'b0),            // 1-bit input  Power Down
    .RST                 (iRST)
);

//----------------------------------------------------------
// iCLK は IBUF 経由後、FeedBack経由してBUFG通すような図がデータシートに記載してあったのでそうしている
// 
// PCLK 25  MHz Pixel
// TCLK 250 MHz TMDS
// BCLK 100 MHz Base
//----------------------------------------------------------
wire wTCLK;                     assign oTCLK = wTCLK;
wire wPCLK;                     assign oPCLK = wPCLK;
wire wBCLK;                     assign oBCLK = wBCLK;

BUFG BUFG_ICLK (    .O (wClkInFb),  .I (wClkOutFb)  );
BUFG BUFG_PCLK (    .O (wPCLK),     .I (wClkOut[0]) );
BUFG BUFG_TCLK (    .O (wTCLK),     .I (wClkOut[1]) );
BUFG BUFG_BCLK (    .O (wBCLK),     .I (wClkOut[2]) );

endmodule