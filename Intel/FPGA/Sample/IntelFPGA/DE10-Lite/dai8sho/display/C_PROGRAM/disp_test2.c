/* Copyright(C) 2017 Cobac.Net All Rights Reserved. */
/* chapter: ��8��                                   */
/* project: display                                 */
/* outline: �O���t�B�b�N�\����H�̃e�X�g�v���O����2 */

#include "system.h"
#include "altera_avalon_pio_regs.h"
#include "sys/alt_cache.h"

#define DISPADDR PIO_0_BASE
#define CLRV_DON PIO_1_BASE
#define VBLANK   PIO_2_BASE
#define DISPON_BIT 0x01
#define CLRVB_BIT  0x02

#define XSIZE 640
#define YSIZE 480
#define VRAM ((volatile unsigned short *) 0x02000000)

#define PAGE0 0x02000000
#define PAGE1 (0x02000000+640*480*2)

/* VBLANK�҂� */
void wait_vblank(void) {
    IOWR_ALTERA_AVALON_PIO_SET_BITS(CLRV_DON, CLRVB_BIT);
    IOWR_ALTERA_AVALON_PIO_CLEAR_BITS(CLRV_DON, CLRVB_BIT);
    while (IORD_ALTERA_AVALON_PIO_DATA(VBLANK)==0);
}

int main()
{
    int i, x, y;

    /* �y�[�W0�Ƀ^�C���͗l������ */
    for (y=0; y<YSIZE; y++) {
        for (x=0; x<XSIZE; x++) {
            VRAM[x+y*XSIZE] = ((x/80)<<11) | ((y/60)<<5) | 3;
        }
    }
    /* �y�[�W1�ɎȖ͗l������ */
    for (i=0; i<XSIZE*YSIZE; i++) {
        VRAM[i+XSIZE*YSIZE] = i;
    }
    alt_dcache_flush_all();

    /* �\��ON */
    wait_vblank();
    IOWR_ALTERA_AVALON_PIO_DATA(DISPADDR, PAGE0);
    IOWR_ALTERA_AVALON_PIO_SET_BITS(CLRV_DON, DISPON_BIT);

    /* 60�t���[�����Ƃɕ\���y�[�W��؂�ւ��� */
    while (1) {
        for (i=0; i<60; i++) wait_vblank();
        IOWR_ALTERA_AVALON_PIO_DATA(DISPADDR, PAGE1);
        for (i=0; i<60; i++) wait_vblank();
        IOWR_ALTERA_AVALON_PIO_DATA(DISPADDR, PAGE0);
    }

    return 0;
}
