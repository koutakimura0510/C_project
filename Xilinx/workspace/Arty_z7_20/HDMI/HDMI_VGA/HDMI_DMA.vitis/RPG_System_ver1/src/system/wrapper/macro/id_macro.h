/*
 * ファイル操作データベースアクセスID管理ヘッダーファイル
 */
#ifndef id_macro_h   /* prevent circular inclusions */
#define id_macro_h   /* by using protection macros */

/*
 * チャンネル指定用ID
 */
typedef enum
{
    CH0,
    CH1,
    CH2,
    CH3,
    CH4,
    CH5,
    CH_ISDONE,
} Channel;


/*
 * ファイルデータベースアクセス用ID
 */
typedef enum
{
    /* 仲間データ */
    FILE_UNIT_ID_START,
    FILE_ACCESS_HERO_CHIP,
    FILE_ACCESS_HERO_MINIGAME_CHIP,
    FILE_ACCESS_HERO_SHADOW_CHIP,
    FILE_ACCESS_HERO_BATTLE_CHIP,
    FILE_ACCESS_HERO_BATTLE_WAKU,
    FILE_UNIT_ID_END,

    /* NPCデータ */
    FILE_NPC_ID_START,
    FILE_ACCESS_NPC_WORLD,
    FILE_NPC_ID_END,

    /* エネミーデータ */
    FILE_ENEMY_ID_START,
    FILE_ACCESS_ENEMY_GURL_1,
    FILE_ACCESS_ENEMY_HIYOKO_1,
    FILE_ENEMY_ID_END,

    /* マップのチップデータ */
    FILE_CHIP_ID_START,
    FILE_ACCESS_CHIP_MINIGAME,
    FILE_ACCESS_CHIP_GEKAI,
    FILE_ACCESS_CHIP_ROMEN_VIRRAGE,
    FILE_ACCESS_MAPDATA_BLOCK1,
    FILE_CHIP_ID_END,

    /* マップの背景とオブジェクトデータ */
    FILE_WORLDMAP_ID_START,
    FILE_ACCESS_MAPDATA_MINIGAME,
    FILE_ACCESS_MAPDATA_GEKAI,
    FILE_ACCESS_MAPDATA_GEKAI_OBJECT,
    FILE_ACCESS_MAPDATA_ROMEN_VIRRAGE,
    FILE_ACCESS_MAPDATA_ROMEN_VIRRAGE_OBJECT,
    FILE_ACCESS_MAPDATA_ROMEN_HOUSE1,
    FILE_ACCESS_MAPDATA_ROMEN_HOUSE1_OBJECT,
    FILE_ACCESS_MAPDATA_ROMEN_HOUSE2,
    FILE_ACCESS_MAPDATA_ROMEN_HOUSE2_OBJECT,
    FILE_WORLDMAP_ID_END,

    /* 背景データ */
    FILE_BACK_ID_START,
    FILE_ACCESS_BACK_GRASS,
    FILE_ACCESS_BACK_YUUHI,
    FILE_ACCESS_BACK_TITLE,
    FILE_ACCESS_BACK_TITLE1,
    FILE_ACCESS_BACK_FOG,
    FILE_ACCESS_BACK_ICON,
    FILE_ACCESS_BACK_ICON2,
    FILE_BACK_ID_END,

    /* ミニゲームエフェクト */
    FILE_HIT_ID_START,
    FILE_ACCESS_HIT_EFFECT_1,
    FILE_ACCESS_HIT_EFFECT_2,
    FILE_ACCESS_HIT_EFFECT_3,
    FILE_HIT_ID_END,

    /* FONTデータ */
    FILE_FONT_ID_START,
    FILE_ACCESS_FONT_SUUZI_1,
    FILE_ACCESS_FONT_RESULT,
    FILE_ACCESS_FONT_SJIS,
    FILE_ACCESS_FONT_DAMEGE,
    FILE_ACCESS_FONT_HEAL,
    FILE_FONT_ID_END,

    /* ミニゲーム音源 */
    FILE_BGM_ID_START,
    FILE_ACCESS_BGM_JUMP,
    FILE_ACCESS_BGM_COIN,
    FILE_ACCESS_BGM_BOM,
    FILE_ACCESS_BGM_PITYN,

    /* BGM */
    FILE_ACCESS_BGM_TITLE,
    FILE_ACCESS_BGM_KAMIGAMI,
    FILE_ACCESS_BGM_MINORIKO,
    FILE_ACCESS_BGM_SIZUHA,
    FILE_ACCESS_BGM_KANAKO,
    FILE_ACCESS_BGM_KOGASA,
    FILE_ACCESS_BGM_YUUKA,
    FILE_ACCESS_BGM_REMIRIA,
    FILE_ACCESS_BGM_SATORI,
    FILE_ACCESS_BGM_TENSI,
    FILE_ACCESS_BGM_ENDING,
	FILE_ACCESS_BGM_FIELD,
	FILE_ACCESS_BGM_FIELD_GEKAI,
    FILE_ACCESS_BGM_MURA_1,
    FILE_ACCESS_BGM_BATTLE_DEFAULT,
    FILE_ACCESS_BGM_BATTLE_FANFARE,

    /* ストーリー進行に必要な音源データの開始ID */
    FILE_ACCESS_BGM_STORY_START_ID,

    /* バトルエフェクト音源 */
    FILE_ACCESS_BGM_EFFECT_MAGIC_1,

    /* ステータス */
    FILE_ACCESS_BGM_EFFECT_POWER_UP,
    FILE_ACCESS_BGM_EFFECT_POWER_DOWN,
    FILE_ACCESS_BGM_EFFECT_DEF_1,
    FILE_ACCESS_BGM_EFFECT_HEST_1,
    FILE_ACCESS_BGM_EFFECT_SLOW_1,

    /* 回復 */
    FILE_ACCESS_BGM_EFFECT_HEAL_1,
	FILE_ACCESS_BGM_EFFECT_ESNA_1,
	FILE_ACCESS_BGM_EFFECT_RISE_1,

    /* 状態異常 */
	FILE_ACCESS_BGM_EFFECT_CONFIG_1,
	FILE_ACCESS_BGM_EFFECT_POISON_1,
	FILE_ACCESS_BGM_EFFECT_PARARAI_1,

    /* 専用 */
    FILE_ACCESS_BGM_EFFECT_KANAKO_8,

    /* FF Battle音源 */
    FILE_ACCESS_BGM_BATTLE_ENCOUNT,
    FILE_ACCESS_BGM_BATTLE_TRUN,
    FILE_ACCESS_BGM_BATTLE_DAMAGE,
    FILE_ACCESS_BGM_BATTLE_KNIFE,
    FILE_ACCESS_BGM_BATTLE_SPEAR,
    FILE_ACCESS_BGM_BATTLE_PUNCH,
    FILE_ACCESS_BGM_BATTLE_MISS,
    FILE_ACCESS_BGM_BATTLE_DEFEAT1,
    FILE_ACCESS_BGM_BATTLE_DEFEAT2,
    FILE_ACCESS_BGM_BATTLE_RUN,
    FILE_ACCESS_BGM_BATTLE_BRAW_1,

    /* FF コマンド音源 */
    FILE_ACCESS_BGM_CMD_ENTER,
    FILE_ACCESS_BGM_CMD_DOOR1,
    FILE_ACCESS_BGM_CMD_DOOR2,
    FILE_ACCESS_BGM_CMD_CHEST,
    FILE_ACCESS_BGM_CMD_SWITCH,
    FILE_ACCESS_BGM_CMD_GOLD,
    FILE_ACCESS_BGM_CMD_SELECT1,
    FILE_ACCESS_BGM_CMD_SELECT2,
    FILE_ACCESS_BGM_CMD_COLLAPSE,
    FILE_ACCESS_BGM_CMD_KAIDAN,
    FILE_ACCESS_BGM_CMD_TAKARA,
    FILE_ACCESS_BGM_CMD_SUCCESS,
    FILE_ACCESS_BGM_CMD_FAIL,
    FILE_ACCESS_BGM_CMD_CANSEL,
    FILE_ACCESS_BGM_STORY_END_ID,
    FILE_BGM_ID_END,

    /* バトルエフェクトの画像データ */
    EFFECT_ID_START,
    /* 攻撃 */
    FILE_ACCESS_EFFECT_BATTLE_MAGIC_1,
    FILE_ACCESS_EFFECT_BATTLE_SLASH_1,
    FILE_ACCESS_EFFECT_BATTLE_BROW_1,

    /* ステータス操作 */
    FILE_ACCESS_EFFECT_BATTLE_POWER_UP,
    FILE_ACCESS_EFFECT_BATTLE_POWER_DOWN,
    FILE_ACCESS_EFFECT_BATTLE_POWER_DOWN_2,
    FILE_ACCESS_EFFECT_BATTLE_DEF_1,
    FILE_ACCESS_EFFECT_BATTLE_RES_1,
    FILE_ACCESS_EFFECT_BATTLE_HEST_1,
    FILE_ACCESS_EFFECT_BATTLE_SLOW_1,

    /* 回復 */
    FILE_ACCESS_EFFECT_BATTLE_HEAL_1,
    FILE_ACCESS_EFFECT_BATTLE_ESNA_1,
    FILE_ACCESS_EFFECT_BATTLE_RISE_1,

    /* 状態異常 */
    FILE_ACCESS_EFFECT_BATTLE_CONFIG_1,
    FILE_ACCESS_EFFECT_BATTLE_POISON_1,
    FILE_ACCESS_EFFECT_BATTLE_PARARAI_1,
    FILE_ACCESS_EFFECT_BATTLE_BERSEK_1,
    FILE_ACCESS_EFFECT_BATTLE_RIGENE_1,
    FILE_ACCESS_EFFECT_BATTLE_DEATH_1,

    /* ループ系 */
    FILE_ACCESS_EFFECT_BATTLE_POISON_2,
    FILE_ACCESS_EFFECT_BATTLE_CONFIG_2,
    FILE_ACCESS_EFFECT_BATTLE_PARARAI_2,
    FILE_ACCESS_EFFECT_BATTLE_BUF_2,    //オーラみたいなの
    FILE_ACCESS_EFFECT_BATTLE_BERSEK_2,
    FILE_ACCESS_EFFECT_BATTLE_REFREK_2,
    FILE_ACCESS_EFFECT_BATTLE_RIGENE_2,

    /* 専用技 */
    FILE_ACCESS_EFFECT_BATTLE_KANAKO_8,
    FILE_ACCESS_EFFECT_BATTLE_REMIRIA_7,
    EFFECT_ID_END,

    /* アイテム */
    FILE_SYSTEM_ID_START,
    FILE_ACCESS_ENEMY_PARA,
    FILE_ACCESS_ENEMY_NAME,
    FILE_ACCESS_ITEM_BATTLE,
    FILE_ACCESS_ITEM_WEAPON,
    FILE_ACCESS_ITEM_ARMOR,
    FILE_ACCESS_ITEM_AMULET,
    FILE_ACCESS_COOKING,
    FILE_ACCESS_MSG_EVENT,
    FILE_ACCESS_MSG_MINIGAME,
    FILE_ACCESS_MSG_CMD,
    FILE_ACCESS_MINI_SCORE,
    FILE_ACCESS_MAGIC_PARA,
    FILE_ACCESS_HERO_LEVEL,
    FILE_ACCESS_HERO_SKILL,
    FILE_ACCESS_ENEMY_REGION,
    FILE_ACCESS_ENEMY_FORMATION,
    FILE_ACCESS_ANIMATION_EFFECT,
    FILE_ACCESS_STATUS_CONFIG,
    FILE_ACCESS_ATK_ELEMENT,
    FILE_ACCESS_WEAPON_ELEMENT,
    FILE_ACCESS_ARMOR_ELEMENT,
    FILE_ACCESS_AMULET_ELEMENT,
    FILE_ACCESS_CONDITION,
    FILE_ACCESS_CONDITION_ANIME,
    FILE_ACCESS_SOUND,
    FILE_ACCESS_ITEM_ENCHANT,
    FILE_ACCESS_ITEM_CONDITION,
    FILE_ACCESS_NPC_MAP,
    FILE_ACCESS_NPC_PATTERN,
    FILE_ACCESS_NPC_BITMAP,
    FILE_ACCESS_SIN_TABLE,
    FILE_ACCESS_COS_TABLE,
    FILE_ACCESS_TYPE_STR,
    FILE_ACCESS_TOTAL_BYTE,
    FILE_SYSTEM_ID_END,

} ResID;

#endif
