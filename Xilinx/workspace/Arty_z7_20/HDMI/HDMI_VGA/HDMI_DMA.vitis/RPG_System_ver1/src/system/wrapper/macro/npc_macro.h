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


/**
 * @brief  NPCの向きに対するマップチップの切り取り開始座標を定義
 * @note   画像データの横幅や縦幅によって数値が変更されるため注意
 * @retval 
 */
#define NPC_DIR_EDGE    (6)
#define NPC_DIR_DOWN    (0)
#define NPC_DIR_LEFT    (6)
#define NPC_DIR_RIGHT   (12)
#define NPC_DIR_UP      (18)


/**
 * @brief  npcの座標管理構造体のインデックス番号
 * @note   
 * @retval None
 */
typedef enum
{
	NPC_INDEX_X,
	NPC_INDEX_Y,
	NPC_INDEX_NUMBER,
} NpcIndexPos;


/**
 * @brief  NPCの座標更新に使用する状態管理定数
 * @note   
 * @retval None
 */
typedef enum
{
	NPC_POS_UPDATE_LEFT,
	NPC_POS_UPDATE_RIGHT,
	NPC_POS_UPDATE_UP,
	NPC_POS_UPDATE_DOWN,
} NpcDirUpdate;


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
