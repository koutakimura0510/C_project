/* Copyright(C) 2017 Cobac.Net All Rights Reserved. */
/* chapter: ��9��                            */
/* project: capture                          */
/* outline: �L���v�`����H�̃e�X�g�v���O���� */

#include "system.h"
#include "altera_avalon_pio_regs.h"

#include "ov7725.h"

#define DISPADDR PIO_0_BASE
#define CLRV_DON PIO_1_BASE
#define VBLANK   PIO_2_BASE

#define CAPADDR  PIO_3_BASE
#define CLRC_CON PIO_4_BASE
#define CBLANK   PIO_5_BASE

#define ON_BIT  0x01
#define CLR_BIT 0x02

#define SCCBREG  SCCB_0_BASE
#define SCCBSTAT (SCCB_0_BASE + 0x02)
#define SCCBBUSY 1

/* VBLANK�҂� */
void wait_vblank(void) {
    IOWR_ALTERA_AVALON_PIO_SET_BITS(CLRV_DON, CLR_BIT);
    IOWR_ALTERA_AVALON_PIO_CLEAR_BITS(CLRV_DON, CLR_BIT);
    while (IORD_ALTERA_AVALON_PIO_DATA(VBLANK)==0);
}

/* CBLANK�҂� */
void wait_cblank(void) {
    IOWR_ALTERA_AVALON_PIO_SET_BITS(CLRC_CON, CLR_BIT);
    IOWR_ALTERA_AVALON_PIO_CLEAR_BITS(CLRC_CON, CLR_BIT);
    while (IORD_ALTERA_AVALON_PIO_DATA(CBLANK)==0);
}

/* SCCB�o�R�ŃJ�����̐ݒ背�W�X�^�ɏ������� */
void sccb_write( int data )
{
    while ((IORD_16DIRECT(SCCBSTAT, 0) & SCCBBUSY) != 0);
    IOWR_16DIRECT(SCCBREG, 0, data);
}

/* �Z���T�[�`�b�vOV7725�̏����� */
void ov7725_init( void )
{
    int i=0;
    int data=init_data[0];

    while ( data!=0xffff ) {
        sccb_write( data );
        data = init_data[++i];
    }
    while ((IORD_ALTERA_AVALON_PIO_DATA(SCCBSTAT) & SCCBBUSY) != 0);
}

int main()
{
	ov7725_init();

    /* �\��ON */
    wait_vblank();
    IOWR_ALTERA_AVALON_PIO_DATA(DISPADDR, 0x02000000);
    IOWR_ALTERA_AVALON_PIO_SET_BITS(CLRV_DON, ON_BIT);

    /* �L���v�`��ON */
    wait_cblank();
    IOWR_ALTERA_AVALON_PIO_DATA(CAPADDR, 0x02000000);
    IOWR_ALTERA_AVALON_PIO_SET_BITS(CLRC_CON, ON_BIT);

    return 0;
}
