/* Copyright(C) 2017 Cobac.Net All Rights Reserved.  */
/* chapter: ��7�͉ۑ�                      */
/* project: ps2if                          */
/* outline: �X�N���[���z�C�[���E�}�E�X�Ή� */

#include "sys/alt_stdio.h"
#include "io.h"
#include "system.h"

#define DVALID  0x01
#define EMPTY   0x02

void putdata( int data );
int getdata(void);
int seg7dec( int indata );

int main()
{
    int data1, data2, data3, data4, L, R;
    int posx=0, posy=0, posz=0, dx, dy, dz;
    int piodata=0x40404040;
    IOWR_32DIRECT(PIO_0_BASE, 0, piodata);   /* 7�Z�O�\�������ׂ�0�ɏ����� */

    putdata(0xFF);      /* ���Z�b�g�R�}���h���M */
    data1 = getdata();  /* �}�E�X��������M�i�`�F�b�N���Ȃ��j */
    data2 = getdata();
    data3 = getdata();
    // alt_printf("res1=%x %x %x\n", data1, data2, data3);

    putdata(0xF3);      /* �Z�b�g�T���v�����[�g���M */
    data1 = getdata();  /* �}�E�X��������M�i�`�F�b�N���Ȃ��j */
    putdata(0xC8);      /* �T���v�����[�g200 */
    data1 = getdata();  /* �}�E�X��������M�i�`�F�b�N���Ȃ��j */

    putdata(0xF3);      /* �Z�b�g�T���v�����[�g���M */
    data1 = getdata();  /* �}�E�X��������M�i�`�F�b�N���Ȃ��j */
    putdata(0x64);      /* �T���v�����[�g100 */
    data1 = getdata();  /* �}�E�X��������M�i�`�F�b�N���Ȃ��j */

    putdata(0xF3);      /* �Z�b�g�T���v�����[�g���M */
    data1 = getdata();  /* �}�E�X��������M�i�`�F�b�N���Ȃ��j */
    putdata(0x50);      /* �T���v�����[�g80 */
    data1 = getdata();  /* �}�E�X��������M�i�`�F�b�N���Ȃ��j */

    putdata(0xF2);      /* ID�ǂݏo�����M */
    data1 = getdata();  /* �}�E�X��������M�i�`�F�b�N���Ȃ��j */
    data1 = getdata();  /* ID��������M */
    alt_printf("ID=%x\n", data1);


    putdata(0xF4);      /* �C�l�[�u���R�}���h���M */
    data1 = getdata();  /* �}�E�X��������M�i�`�F�b�N���Ȃ��j */
    // alt_printf("res2=%x\n", data1);

    while(1) {
        /* �}�E�X����4�f�[�^��M */
        data1 = getdata();
        data2 = getdata();
        data3 = getdata();
        data4 = getdata();

        /* X�AY�̕����r�b�g�����o���A9�r�b�g�̈ړ��ʂƂ��� */
        if ( (data1 & 0x10) != 0)
            dx = data2 | 0xffffff00;
        else
            dx = data2;
        if ( (data1 & 0x20) != 0)
            dy = data3 | 0xffffff00;
        else
            dy = data3;

        /* �ړ��ʂ����݈ʒu�ɉ��Z */
        posx = posx + dx;
        posy = posy + dy;

        /* ���E�{�^���̌��o */
        L = ( (data1 & 0x01) != 0) ? 1: 0;
        R = ( (data1 & 0x02) != 0) ? 1: 0;
        // alt_printf("dx=%x dy=%x L=%x R=%x\n", dx, dy, L, R);

        /* �X�N���[���z�C�[�� */
        dz = data4;
        posz = posz + dz;


        /* �\���p�̃f�[�^���i���݈ʒu�j */
        piodata = seg7dec((posx >> 4) & 0x0f);
        piodata = (piodata <<8) | (seg7dec(posx & 0x0f)        & 0xff);
/*
        piodata = (piodata <<8) | (seg7dec((posy >> 4) & 0x0f) & 0xff);
        piodata = (piodata <<8) | (seg7dec(posy & 0x0f)        & 0xff);
*/

        piodata = (piodata <<8) | (seg7dec((posz >> 4) & 0x0f) & 0xff);
        piodata = (piodata <<8) | (seg7dec(posz & 0x0f)        & 0xff);

        /* �\���p�̃f�[�^���i���E�{�^���j */
        if ( L==1 )
            piodata |= 0x00008000;
        if ( R==1 )
            piodata |= 0x00000080;
        if ( L==1 && R==1 )
            posx = posy = posz = 0;    /* ���������ꂽ�猻�݈ʒu�����Z�b�g */

        /* PIO�ɏ�������ŕ\�� */
        IOWR_32DIRECT(PIO_0_BASE, 0, piodata);
    }
    return 0;
}

/* �}�E�X��1�o�C�g���o */
void putdata( int data )
{
    while ( (IORD_8DIRECT(PS2IF_IP_0_BASE, 0) & EMPTY)==0 );
    IOWR_8DIRECT(PS2IF_IP_0_BASE, 2, data);
}

/* �}�E�X����1�o�C�g��M */
int getdata(void)
{
    int ps2in = 0;
    while ( (ps2in & DVALID)==0 ) {
        ps2in=IORD_8DIRECT(PS2IF_IP_0_BASE, 0);
    }
    ps2in &= ~DVALID;
    IOWR_8DIRECT(PS2IF_IP_0_BASE, 0, ps2in);
    return IORD_8DIRECT(PS2IF_IP_0_BASE, 1);
}

/* 7�Z�O�����g�E�f�R�[�_ */
int seg7dec( int indata )
{
    int temp;
    switch ( indata ) {
        case 0x0: temp = 0x40; break;
        case 0x1: temp = 0x79; break;
        case 0x2: temp = 0x24; break;
        case 0x3: temp = 0x30; break;
        case 0x4: temp = 0x19; break;
        case 0x5: temp = 0x12; break;
        case 0x6: temp = 0x02; break;
        case 0x7: temp = 0x58; break;
        case 0x8: temp = 0x00; break;
        case 0x9: temp = 0x10; break;
        case 0xA: temp = 0x08; break;
        case 0xB: temp = 0x03; break;
        case 0xC: temp = 0x46; break;
        case 0xD: temp = 0x21; break;
        case 0xE: temp = 0x06; break;
        case 0xF: temp = 0x0e; break;
        default:  temp = 0x7f; break;
    }

    return temp;
}
