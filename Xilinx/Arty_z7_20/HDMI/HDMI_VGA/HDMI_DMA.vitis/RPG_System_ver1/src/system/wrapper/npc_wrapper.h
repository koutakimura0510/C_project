/**
 * Create 2021/09/20
 * Author koutakimura
 * Editor VSCode ver1.57.1
 * Build  Vitis20.2
 * Borad  ArtyZ7-20
 * -
 * @brief npcの描画データを管理するラッパーファイル
 */
#ifndef npc_wrapper_h   /* prevent circular inclusions */
#define npc_wrapper_h   /* by using protection macros */


/**
 * @brief  npcのアニメーション処理に使用するデータを管理する構造体
 * 
 * @note   分かりにくそうなメンバの詳細を記述するよ。
 * 
 * dram_indexに(x, y)の初期位置の合計値を保存するよ。
 * map_pos[x or y][]に現在の1マス辺りの行動値を保存するよ。
 * NPCの行動パターンデータベースから移動量の最大値を取得して最大値を超えないように移動するよ。
 * 最大値がx(-2, 2):y(-3, 3)だったら初期位置から、
 * 左に2マス：右に2マス：上に3マス：下に3マスだけ移動できるよ。
 * dir_timeの時間で移動量の処理を行うことになるね。
 * 
 * pixel_adjust
 * NPCの座標更新時にpixel移動の処理を入れないと、1マスを瞬間移動したようになってしまう。
 * そのため進んだ方向とは逆数の値を保存し、pixel数を移動量分加算または減算しなければならない。
 * 右 = -32
 * 左 = 32
 * 上 = 32
 * 下 = -32
 * 
 * @param  map_npcid マップが保持するNPCの連番を保存
 * @param  id npc自身が持つIDを保存
 * @param  map_pos[] NPCのx,y座標の移動量を保存、[0][]=xの移動量を保存。[1][]=yの移動量を保存
 * @param  pixel_adjust[] アニメーション時の移動座標を管理
 * @param  dram_index マップデータのNPCの初期座標を保存
 * @param  mapchip_id 描画を行うマップチップのIDを保存
 * @param  cut_pos マップチップの切り取り箇所を保存
 * @param  dir NPCの現在の向きを保存
 * @param  cut_dir 向きに応じた切り取り座標を保存
 * @param  anime_time マップチップ切り替え時間を保存
 * @param  dir_time 行動パターンを実行する時間を保存
 * @param  active_state 現在のNPCの状態を管理
 * @param  number 現在のマップに描画するNPCの最大数を保存
 * @retval None
 */
typedef struct npc_wrapper
{
    uint32_t map_npcid[NPC_MAX_DRAW_NUM];
    uint32_t id[NPC_MAX_DRAW_NUM];
    int8_t   map_pos[NPC_INDEX_NUMBER][NPC_MAX_DRAW_NUM];
    int32_t  move_weight[NPC_MAX_DRAW_NUM];
    uint32_t dram_index[NPC_MAX_DRAW_NUM];
    uint8_t  mapchip_id[NPC_MAX_DRAW_NUM];
    uint8_t  cut_pos[NPC_MAX_DRAW_NUM];
    uint8_t  dir[NPC_MAX_DRAW_NUM];
    uint8_t  cut_dir[NPC_MAX_DRAW_NUM];
    uint32_t anime_time[NPC_MAX_DRAW_NUM];
    uint32_t dir_time[NPC_MAX_DRAW_NUM];
    int32_t  xpos[NPC_MAX_DRAW_NUM];
    int32_t  ypos[NPC_MAX_DRAW_NUM];
    uint8_t  active_state[NPC_MAX_DRAW_NUM];
    uint8_t  number;
} NpcWrapper;

#endif