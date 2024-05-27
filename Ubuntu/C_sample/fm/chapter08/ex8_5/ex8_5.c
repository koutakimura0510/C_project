#include <stdio.h>
#include <stdlib.h>
#include "wave.h"

int main(void)
{
  MONO_PCM pcm;
  int n, m, te;
  double *e, gain;
  
  pcm.fs = 44100; /* �W�{�����g�� */
  pcm.bits = 16; /* �ʎq�����x */
  pcm.length = pcm.fs * 8; /* ���f�[�^�̒��� */
  pcm.s = calloc(pcm.length, sizeof(double)); /* ���f�[�^ */
  
  /* ���F�G�� */
  for (n = 0; n < pcm.length; n++)
  {
    pcm.s[n] = (double)rand() / RAND_MAX * 2.0 - 1.0;
  }
  
  e = calloc(pcm.length, sizeof(double));
  
  te = pcm.fs * 2; /* �P�������܂��͒P�������ɂ����鎞�� */
  
  /* ���ԃG���x���[�v */
  m = 0;
  for (n = 0; n < pcm.length; n++)
  {
    if (m < te)
    {
      e[n] = (double)m / te;
    }
    else
    {
      e[n] = 1.0 - ((double)m - te) / te;
    }
    
    m++;
    if (m >= te * 2)
    {
      m = 0;
    }
  }
  
  gain = 0.1; /* �Q�C�� */
  
  for (n = 0; n < pcm.length; n++)
  {
    pcm.s[n] *= e[n] * gain;
  }
  
  wave_write_16bit_mono(&pcm, "ex8_5.wav");
  
  free(pcm.s);
  free(e);
  
  return 0;
}
