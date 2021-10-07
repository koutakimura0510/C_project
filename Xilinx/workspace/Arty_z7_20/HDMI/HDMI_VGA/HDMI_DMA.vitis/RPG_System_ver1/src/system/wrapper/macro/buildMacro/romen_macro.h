/*
 * Create 2021/10/08
 * Author koutakimura
 * OS     Ubuntu LTS 20.04
 * Editor VSCode ver1.57.1
 * -
 * ロメン村のイベント定数値を管理
 */
#ifndef romen_macro_h   /* prevent circular inclusions */
#define romen_macro_h   /* by using protection macros */

/**
 * @brief  イベント管理用IDを定義
 * @note   
 * @retval None
 */
typedef enum
{
    DIRECT_ROMEN_ID_START,
    DIRECT_ROMEN_ID_EXIT = DIRECT_ROMEN_ID_START,
    DIRECT_ROMEN_ID_HOUSE1,
    DIRECT_ROMEN_ID_HOUSE2,
    DIRECT_ROMEN_ID_KANBAN1,
    DIRECT_ROMEN_ID_KANBAN3_1,
    DIRECT_ROMEN_ID_KANBAN3_2,
    DIRECT_ROMEN_ID_KANBAN4,
    DIRECT_ROMEN_ID_KANBAN5,
    DIRECT_ROMEN_ID_ITEM_SHOP,
    DIRECT_ROMEN_ID_WEPON_SHOP,
    DIRECT_ROMEN_ID_ITEM1,
    DIRECT_ROMEN_ID_ITEM2,
    DIRECT_ROMEN_ID_ITEM3,
    DIRECT_ROMEN_ID_END,
    DIRECT_ROMEN_ID_LOOM1_START = DIRECT_ROMEN_ID_END,
    DIRECT_ROMEN_ID_LOOM1 = DIRECT_ROMEN_ID_END,
    DIRECT_ROMEN_ID_LOOM1_END,
    DIRECT_ROMEN_ID_LOOM2_START = DIRECT_ROMEN_ID_LOOM1_END,
    DIRECT_ROMEN_ID_LOOM2 = DIRECT_ROMEN_ID_LOOM1_END,
    DIRECT_ROMEN_ID_LOOM2_END,
} RomenEventNumber;

#endif