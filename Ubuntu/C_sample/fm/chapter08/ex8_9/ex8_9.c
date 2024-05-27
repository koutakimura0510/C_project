#include <stdio.h>
#include <stdlib.h>
#include "wave.h"

int main(void)
{
  MONO_PCM pcm;
  int n, m, t0;
  double *f0, gain;
  
  pcm.fs = 8000; /* �W�{�����g�� */
  pcm.bits = 16; /* �ʎq�����x */
  pcm.length = pcm.fs * 2; /* ���f�[�^�̒��� */
  pcm.s = calloc(pcm.length, sizeof(double)); /* ���f�[�^ */
  
  f0 = calloc(pcm.length, sizeof(double));
  
  /* ��{���g�� */
  f0[0] = 500.0;
  f0[pcm.length - 1] = 3500.0;
  for (n = 0; n < pcm.length; n++)
  {
    f0[n] = f0[0] + (f0[pcm.length - 1] - f0[0]) * n / (pcm.length - 1);
  }
  
  /* �m�R�M���g */
  t0 = pcm.fs / f0[0]; /* ��{���� */
  m = 0;
  for (n = 0; n < pcm.length; n++)
  {
    pcm.s[n] = 1.0 - 2.0 * m / t0;
    
    m++;
    if (m >= t0)
    {
      t0 = pcm.fs / f0[n]; /* ��{���� */
      m = 0;
    }
  }
  
  gain = 0.1; /* �Q�C�� */
  
  for (n = 0; n < pcm.length; n++)
  {
    pcm.s[n] *= gain;
  }
  
  wave_write_16bit_mono(&pcm, "ex8_9.wav");
  
  free(pcm.s);
  free(f0);
  
  return 0;
}
