//----------------------------------------------------------
// Create 2021/2/19
// Author koutakimura
// Editor VSCode ver1.62.7
// Build  Vivado20.2
// Borad  Nexys Video
// -
// 共有するDDRメモリアドレスマッピング
//----------------------------------------------------------


//----------------------------------------------------------
// フレームバッファ領域
//----------------------------------------------------------
parameter DDR_FBUF_SIZE     = (640 * 480);
parameter DDR_ADDR_FBUF_1   = 32'd5000000;
parameter DDR_ADDR_FBUF_2   = 32'd10000000;
parameter DDR_ADDR_FBUF_3   = 32'd15000000;