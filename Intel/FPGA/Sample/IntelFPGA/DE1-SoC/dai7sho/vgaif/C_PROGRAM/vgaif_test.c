/* Copyright(C) 2017 Cobac.Net All Rights Reserved.  */
/* chapter: ��7��                       */
/* project: vgaif                       */
/* outline: VGA�����\����H�̕\���e�X�g */

#include "system.h"
#include "io.h"

/* X, Y�T�C�Y */
#define XSIZE 80
#define YSIZE 50

int main()
{
    int x, y;

    /* �S�����ƑS�F��\�� */
    for ( x=0; x<XSIZE*YSIZE; x++ ) {
        IOWR_32DIRECT(VGAIF_IP_0_BASE, x*4, (x<<16)+x);
    }

    /* 1�s��ɃX�N���[�� */
    for ( y=0; y<YSIZE; y++ ) {     /* �����̍s�Ƀu���[�N�|�C���g��u���� */
        for ( x=0; x<XSIZE; x++ ){
            if ( y != YSIZE-1 ) {
                IOWR_32DIRECT(VGAIF_IP_0_BASE, (x+y*XSIZE)*4,
                    IORD_32DIRECT(VGAIF_IP_0_BASE, (x+(y+1)*XSIZE)*4));
            }
            else
                IOWR_32DIRECT(VGAIF_IP_0_BASE, (x+y*XSIZE)*4, 0x0fff0020);
        }
    }

    /* �F�������ɕύX */
    for ( y=0; y<YSIZE; y++ ) {     /* �����̍s�Ƀu���[�N�|�C���g��u���� */
        for ( x=0; x<XSIZE; x++ ){
            IOWR_16DIRECT(VGAIF_IP_0_BASE, (x+y*XSIZE)*4+2, 0x0fff);
        }
    }

    return 0;
}
