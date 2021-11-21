/* Copyright(C) 2017 Cobac.Net All Rights Reserved. */
/* chapter: ��8�͉ۑ�      */
/* project: display        */
/* outline: �t�H�g�t���[�� */

#include "system.h"
#include "sys/alt_cache.h"
#include "altera_avalon_pio_regs.h"

#include "funamori.h"
#include "DE0-CV.h"
#include "DE10-Lite.h"
#include "DE1-SoC.h"

#define DISPADDR PIO_0_BASE
#define CLRV_DON PIO_1_BASE
#define VBLANK   PIO_2_BASE
#define DISPON_BIT 0x01
#define CLRVB_BIT  0x02
#define VRAM ((volatile unsigned short *) 0x02000000)
#define PICSIZE 640*480

/* VBLANK�҂� */
void wait_vblank(void) {
    IOWR_ALTERA_AVALON_PIO_SET_BITS(CLRV_DON, CLRVB_BIT);
    IOWR_ALTERA_AVALON_PIO_CLEAR_BITS(CLRV_DON, CLRVB_BIT);
    while (IORD_ALTERA_AVALON_PIO_DATA(VBLANK)==0);
}

int main()
{
    char *data[4] = {header_data, header_data1, header_data2, header_data3};
    unsigned char pic[3];
    int i, j;

    /* �w�b�_�t�@�C������VRAM�ɓǂݍ��� */
    for ( j=0; j<4; j++ ) {
        for ( i=0; i<width*height; i++ ) {
            HEADER_PIXEL(data[j], pic);
            VRAM[PICSIZE*j+i] = ((pic[0] & 0xf0) << 4) | (pic[1] & 0xf0) | (pic[2] >> 4);
        }
    }
    alt_dcache_flush_all();

    /* �\����ON */
    wait_vblank();
    IOWR_ALTERA_AVALON_PIO_DATA(DISPADDR, 0x02000000);
    IOWR_ALTERA_AVALON_PIO_SET_BITS(CLRV_DON, DISPON_BIT);

    /* 3�b���Ƃɕ\����؂�ւ� */
    j = 1;
    while(1) {
        for( i=0; i<60*3; i++ ) wait_vblank();
        IOWR_ALTERA_AVALON_PIO_DATA(DISPADDR, 0x02000000 + PICSIZE*j*2);
        j++;
        if ( j>=4 ) j=0;
    }
  return 0;
}
