/*
 * Create 2021/12/30
 * Author koutakimura
 * Editor VSCode ver1.62.7
 * Build  Vivado20.2
 * Borad  Nexys Video
 * -
 * DDR3メモリ制御 トップモジュール
 * 256 Meg x 16
 * Bank 0~7
 * Row  32768
 * Col  1024
 */
module ddr3Controller #(
    parameter pDramAddrWidth = 29,
    parameter pDramDataWidth = 128,
    parameter pDramMaskWidth = 16,
    parameter pDramDebug     = "off"
)(
    inout  [15:0]               ioDDR3_DQ,
    inout  [ 1:0]               ioDDR3_DQS_N,
    inout  [ 1:0]               ioDDR3_DQS_P,
    output [14:0]               oDDR3_ADDR,
    output [ 2:0]               oDDR3_BA,
    output                      oDDR3_RAS,
    output                      oDDR3_CAS,
    output                      oDDR3_WE,
    output                      oDDR3_RESET,
    output                      oDDR3_CLK_P,
    output                      oDDR3_CLK_N,
    output                      oDDR3_CKE,
    output [ 1:0]               oDDR3_DM,
    output                      oDDR3_ODT,
    input                       iWEnable,           // user write enable data書き込み時 high
    input                       iREnable,           // user read enable data読み込み時high
    input  [pDramDataWidth-1:0] iWdData,            // write data
    input  [pDramAddrWidth-1:0] iAddr,              // access addr 28:0固定 / 27-25:Bank / 24-10:Row / 9-0:Col
    input  [pDramMaskWidth-1:0] iMask,              // write mask
    output [pDramDataWidth-1:0] oRdData,            // read data
    output                      oRdDataValid,       // 読み込みデータ出力時High
    output                      oReady,             // 読み込み可能時High
    output                      oWdReady,           // 書き込み可能時High
    input                       iCLK,               // system clk
    input                       iRST,               // reset High
    output                      oUiCLK,
    output                      oUiRST
);


////////////////////////////////////////////////////////////
// User Interface clk
wire wCal;
wire ui_clk;                assign oUiCLK   = ui_clk;
wire ui_clk_sync_rst;       assign oUiRST   = ui_clk_sync_rst & (~wCal);


////////////////////////////////////////////////////////////
//----------------------------------------------------------
// MIG 設定の動作周波数の生成
//----------------------------------------------------------
wire o_DDR3_200mhz, o_DDR3_100mhz, locked;

clk_wiz_1 DDR3_CLK (
    .clk_out1(o_DDR3_200mhz),   .clk_out2(o_DDR3_100mhz),
    .reset(iRST),               .locked(locked),
    .clk_in1(iCLK)
);

generate
    if (pDramDebug == "on")
        migDemo MIG_DEMO (
            .iData      (iWdData),
            .oData      (oRdData),                  .oCal       (wCal),
            .iAppEN     (iWEnable | iREnable),      .iWE        (iWEnable),
            .oWRDY      (oWdReady),                 .oRDV       (oRdDataValid),
            .oRRDY      (oReady),
            .iCLK       (o_DDR3_100mhz),            .iRST       (iRST & ~locked),
            .oUiCLK     (ui_clk),                   .oUiRST     (ui_clk_sync_rst)
        );
    else
        mig_7series_0 MIG (
            //DDR3 port
            .ddr3_addr                      (oDDR3_ADDR),
            .ddr3_ba                        (oDDR3_BA),
            .ddr3_cas_n                     (oDDR3_CAS),
            .ddr3_ck_n                      (oDDR3_CLK_N),
            .ddr3_ck_p                      (oDDR3_CLK_P),
            .ddr3_cke                       (oDDR3_CKE),
            .ddr3_ras_n                     (oDDR3_RAS),
            .ddr3_reset_n                   (oDDR3_RESET),
            .ddr3_we_n                      (oDDR3_WE),
            .ddr3_dq                        (ioDDR3_DQ),
            .ddr3_dqs_n                     (ioDDR3_DQS_N),
            .ddr3_dqs_p                     (ioDDR3_DQS_P),
            .ddr3_dm                        (oDDR3_DM),
            .ddr3_odt                       (oDDR3_ODT),
            .init_calib_complete            (wCal),                 // output init_calib_complete High Out

            // Application interface ports
            .app_addr                       (iAddr),                // input [28:0]		addr[28:3] / Bank[2:0]
            .app_cmd                        (iREnable),             // input [2:0]		Write 000 / Read 001
            .app_en                         (iWEnable | iREnable),  // input			ユーザー側がapp_cmd有効時にHighにする
            .app_wdf_data                   (iWdData),              // input [127:0]	書き込みデータ 16bit x 8byte
            .app_wdf_end                    (iWEnable),             // input			下記のwrite enable信号と同期させる
            .app_wdf_wren                   (iWEnable),             // input			write enable
            .app_wdf_rdy                    (oWdReady),             // output			データ書き込み可能時High
            .app_wdf_mask                   (iMask),                // input [15:0]		各bitに1が立っていたら対応したbyteは書き込まれない
            .app_rd_data                    (oRdData),              // output [127:0]	読み込みデータ 16bit x 8byte
            .app_rd_data_end                (),                     // output			最後のデータ出力時High
            .app_rd_data_valid              (oRdDataValid),         // output			読み込みデータ出力開始時High
            .app_rdy                        (oReady),               // output			データ読み込み可能時High
            .app_sr_req                     (1'b0),                 // input			
            .app_ref_req                    (1'b0),                 // input			
            .app_zq_req                     (1'b0),                 // input			
            .app_sr_active                  (),                     // output			
            .app_ref_ack                    (),                     // output			
            .app_zq_ack                     (),                     // output			
            .ui_clk                         (ui_clk),               // output			MIGと同期のユーザーインターフェースCLK
            .ui_clk_sync_rst                (ui_clk_sync_rst),      // output			ユーザーインターフェースリセット信号
            .device_temp                    (),
            // System Clock Ports 100MHz
            .sys_clk_i                      (o_DDR3_100mhz),

            // Reference Clock Ports 200MHz rst Active Low
            .clk_ref_i                      (o_DDR3_200mhz),
            .sys_rst                        (iRST & ~locked)               // input sys_rst
        );
endgenerate

endmodule