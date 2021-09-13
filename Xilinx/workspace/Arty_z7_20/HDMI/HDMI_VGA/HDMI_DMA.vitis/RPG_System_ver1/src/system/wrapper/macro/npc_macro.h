/*
 * Create 2021/08/31
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
 * NPCの操作に関するデータを管理するヘッダーファイル
 */

#ifndef npc_macro_h   /* prevent circular inclusions */
#define npc_macro_h   /* by using protection macros */


/* 一つのマップのNPCの最大数 */
#define NPC_MAX_DRAW_NUM    (15)


/*!
 * \brief NPCの行動パターンを管理
 */
typedef enum
{
	NPC_PATTERN_RANDOM,		/* ランダム移動 */
	NPC_PATTERN_ROULETTE,	/* 回転移動 */
	NPC_PATTERN_STEP,		/* その場で足踏み */
	NPC_PATTERN_FAST_STEP,	/* その場で高速で足踏み */
	NPC_PATTERN_STAND,		/* 棒立ち */
} NpcPatternID;

/*!
 * \brief NPCのIDを管理
 *
 * 登場する世界に応じて下記の名前を末尾に挿入する
 * 
 * 下界 WORLD
 * 地界 GROUND
 * 天界 SKY
 * 狭間 GAP
 * 魔界 DEVIL
 */
typedef enum
{
	NPC_GUAL_1_WORLD,		/* 金髪ポニーテール */
	NPC_GUAL_2_WORLD,		/* 黒髪ポニーテール */
	NPC_ID_END,
} NpcNumberID;

#endif