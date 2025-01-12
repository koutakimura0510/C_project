/*------------------------------------------------------------------------------
 * Create  2024/06/16
 * Author  Kouta Kimura
 * 
 *-----------------------------------------------------------------------------*/
#ifndef Mvideo_h
#define Mvideo_h

/**-----------------------------------------------------------------------------
 * USER MACRO
 *-----------------------------------------------------------------------------*/
// #define MTIMER_1MS
#define COLOR_GREEN		(0x00ff07E0)
#define COLOR_BLUE		(0x00ff001F)
#define COLOR_RED		(0x00ffF800)

/**-----------------------------------------------------------------------------
 * typedef struct
 *-----------------------------------------------------------------------------*/
typedef struct {
    int16_t top;
    int16_t under;
    int16_t left;
    int16_t right;
	int32_t color;
} SdlRect;

/**-----------------------------------------------------------------------------
 * プロトタイプ宣言
 *-----------------------------------------------------------------------------*/
void st7789_init(void);
void invert_draw(bool invert);
void software_draw(uint32_t color);
void rect_draw(SdlRect *rect);
void rect_init(SdlRect *rect, int16_t top, int16_t under, int16_t left, int16_t right, uint16_t color);

#endif