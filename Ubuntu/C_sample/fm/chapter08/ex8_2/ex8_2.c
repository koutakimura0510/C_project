#include <stdio.h>
#include <stdlib.h>
#include "wave.h"

int main(void)
{
  MONO_PCM pcm;
  int n, m, t0;
  double f0, gain;
  
  pcm.fs = 44100; /* �W�{�����g�� */
  pcm.bits = 16; /* �ʎq�����x */
  pcm.length = pcm.fs * 1; /* ���f�[�^�̒��� */
  pcm.s = calloc(pcm.length, sizeof(double)); /* ���f�[�^ */
  
  f0 = 500.0; /* ��{���g�� */
  
  /* ��`�g */
  t0 = pcm.fs / f0; /* ��{���� */
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
      m = 0;
    }
  }
  
  gain = 0.1; /* �Q�C�� */
  
  for (n = 0; n < pcm.length; n++)
  {
    pcm.s[n] *= gain;
  }
  
  wave_write_16bit_mono(&pcm, "ex8_2.wav");
  
  free(pcm.s);
  
  return 0;
}
