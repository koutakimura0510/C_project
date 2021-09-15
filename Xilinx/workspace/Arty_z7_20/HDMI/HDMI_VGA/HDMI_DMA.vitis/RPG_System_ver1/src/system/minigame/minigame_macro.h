/**
 * @brief  minigame.cで使用する定数を管理するヘッダーファイル
 * @note   
 */
#ifndef minigame_macro_h_   /* prevent circular inclusions */
#define minigame_macro_h_   /* by using protection macros */


/*
 * ミニゲームのキャラクター選択画面のキャラクターの描画箇所
 */
#define MINIGAME_UNIT_DEFAULT_YPOS 	(96)
#define MINIGAME_UNIT_DEFAULT_XPOS 	(220)
#define MINIGAME_CONFIG_UNIT_YPOS	(MINIGAME_UNIT_DEFAULT_YPOS * MAX_V_WIDTH)
#define MINIGAME_CONFIG_UNIT_XPOS	((MINIGAME_UNIT_DEFAULT_XPOS - MAPCHIP_WIDTH) << RGB_BYTE_SHIFT)


/*
 * ミニゲームのキャラクター選択画面の説明文の描画箇所
 */
#define MINIGAME_CONFIG_MSG_XPOS	(MINIGAME_UNIT_DEFAULT_XPOS)
#define MINIGAME_CONFIG_MSG_YPOS	(8 + MINIGAME_UNIT_DEFAULT_YPOS)

/*
 * ミニゲームのキャラクター選択画面のカーソルの描画箇所
 */
#define MINIGAME_CONFIG_CURSOL_XPOS ((MINIGAME_UNIT_DEFAULT_XPOS - SIZE_ICON_WIDTH) << RGB_BYTE_SHIFT)
#define MINIGAME_CONFIG_CURSOL_YPOS ((MINIGAME_UNIT_DEFAULT_YPOS + SIZE_ICON_HEIGHT_HALF) * MAX_V_WIDTH)
#define MINIGAME_CONFIG_CURSOL_POS  (MINIGAME_CONFIG_CURSOL_XPOS + MINIGAME_CONFIG_CURSOL_YPOS)


#endif