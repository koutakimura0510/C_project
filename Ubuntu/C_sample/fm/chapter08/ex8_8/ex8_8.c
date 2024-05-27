#include <stdio.h>
#include <stdlib.h>
#include "wave.h"

int main(void)
{
  MONO_PCM pcm;
  int n, m, t0, pe;
  double *f0, *e, gain;
  
  pcm.fs = 44100; /* �W�{�����g�� */
  pcm.bits = 16; /* �ʎq�����x */
  pcm.length = pcm.fs * 0.6; /* ���f�[�^�̒��� */
  pcm.s = calloc(pcm.length, sizeof(double)); /* ���f�[�^ */
  
  f0 = calloc(pcm.length, sizeof(double));
  
  /* ��{���g�� */
  for (n = 0; n < pcm.fs * 0.2; n++)
  {
    f0[n] = 440.0;
  }
  for (n = pcm.fs * 0.2; n < pcm.length; n++)
  {
    f0[n] = 440.0 + (880.0 - 440.0) * (n - pcm.fs * 0.2) / (pcm.length - 1 - pcm.fs * 0.2);
  }
  
  /* ��`�g */
  t0 = pcm.fs / f0[0]; /* ��`�g�̊�{���� */
  m = 0;
  for (n = 0; n < pcm.length; n++)
  {
    if (m < t0 / 2.0)
    {
      pcm.s[n] = 1.0;
    }
    else
    {
      pcm.s[n] = -1.0;
    }
    
    m++;
    if (m >= t0)
    {
      t0 = pcm.fs /f0[n]; /* ��`�g�̊�{���� */
      m = 0;
    }
  }
  
  e = calloc(pcm.length, sizeof(double));
  
  pe = pcm.length; /* �P�������ɂ����鎞�� */
  
  /* ���ԃG���x���[�v */
  for(n = 0; n < pcm.length; n++)
  {
    e[n] = 1.0 - (double)n / pe;
  }
  
  gain = 0.1; /* �Q�C�� */
  
  for (n = 0; n < pcm.length; n++)
  {
    pcm.s[n] *= e[n] * gain;
  }
  
  wave_write_16bit_mono(&pcm, "ex8_8.wav");
  
  free(pcm.s);
  free(f0);
  free(e);
  
  return 0;
}
