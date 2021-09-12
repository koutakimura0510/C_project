/*
 * Create 2021/08/13
 * Author koutakimura
 * Editor VSCode ver1.57.1
 * Build  Vitis20.2
 * Borad  ArtyZ7-20
 * -
 * IC      XC7Z020-1CLG400C
 * ROM     256KB
 * RAM     512KB
 * L1Cache 32KB
 * -
 * ロード関連の定数をまとめたヘッダーファイル
 */
#ifndef opening_macro_h   /* prevent circular inclusions */
#define opening_macro_h   /* by using protection macros */


/* カーソル移動の移動値 */
#define OPENING_CURSOL_INTERVAL     (40)

/* オープニング中のカーソルの表示開始位置 */
#define OPENING_CURSOL_DEFAULT_XPOS     (240 << RGB_BYTE_SHIFT)
#define OPENING_CURSOL_DEFAULT_YPOS     (264 * MAX_V_WIDTH)
#define OPENING_CURSOL_DEFAULT_POS      (OPENING_CURSOL_DEFAULT_YPOS + OPENING_CURSOL_DEFAULT_XPOS)
#define OPENING_CURSOL_INTERVAL_YPOS    (OPENING_CURSOL_INTERVAL * MAX_V_WIDTH)


/* ロード画面の文字描画位置 */
#define LOAD_FONT_XDRAW_POS		((VIDEO_WIDTH >> 1) - (SIZE_FONT_SJIS_WIDTH * 2))	//4文字
#define LOAD_FONT_YDRAW_POS		((VIDEO_HEIGHT >> 1) - SIZE_FONT_SJIS_HEIGHT)

/* ロード画面のロードゲージ描画位置 */
#define LOAD_GAUGE_MAX                (100)
#define LOAD_GAUGE_LINE_BOLD          (2)

/* 白枠 */
#define LOAD_GAUGE_XSTART_WHITE      ((VIDEO_WIDTH >> 1) - (LOAD_GAUGE_MAX >> 1) - LOAD_GAUGE_LINE_BOLD)
#define LOAD_GAUGE_YSTART_WHITE      (LOAD_FONT_YDRAW_POS + SIZE_FONT_SJIS_HEIGHT + SIZE_FONT_SJIS_HEIGHT)
#define LOAD_GAUGE_WIDTH_WHITE       (LOAD_GAUGE_MAX + (LOAD_GAUGE_LINE_BOLD * 2))
#define LOAD_GAUGE_HEIGHT_WHITE      (SIZE_FONT_SJIS_HEIGHT)

/* 黒枠 */
#define LOAD_GAUGE_XSTART_BLACK      (LOAD_GAUGE_XSTART_WHITE + LOAD_GAUGE_LINE_BOLD)
#define LOAD_GAUGE_YSTART_BLACK      (LOAD_GAUGE_YSTART_WHITE + LOAD_GAUGE_LINE_BOLD)
#define LOAD_GAUGE_WIDTH_BLACK       (LOAD_GAUGE_MAX)
#define LOAD_GAUGE_HEIGHT_BLACK      (LOAD_GAUGE_HEIGHT_WHITE - (LOAD_GAUGE_LINE_BOLD * 2))

/* ATBゲージ枠 */
#define LOAD_GAUGE_XSTART_ATB        (LOAD_GAUGE_XSTART_WHITE + LOAD_GAUGE_LINE_BOLD)
#define LOAD_GAUGE_YSTART_ATB        (LOAD_GAUGE_YSTART_WHITE + LOAD_GAUGE_LINE_BOLD)
#define LOAD_GAUGE_WIDTH_ATB         (LOAD_GAUGE_MAX)
#define LOAD_GAUGE_HEIGHT_ATB        (LOAD_GAUGE_HEIGHT_WHITE - (LOAD_GAUGE_LINE_BOLD * 2))


#endif
