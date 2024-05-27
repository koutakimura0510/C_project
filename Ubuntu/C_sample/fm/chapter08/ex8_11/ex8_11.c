#include <stdio.h>
#include <stdlib.h>
#include "wave.h"

int main(void)
{
  MONO_PCM pcm0, pcm1;
  int n, m, t0, ratio;
  double *f0, gain;
  
  pcm0.fs = 192000; /* �W�{�����g�� */
  pcm0.bits = 16; /* �ʎq�����x */
  pcm0.length = pcm0.fs * 2; /* ���f�[�^�̒��� */
  pcm0.s = calloc(pcm0.length, sizeof(double)); /* ���f�[�^ */
  
  f0 = calloc(pcm0.length, sizeof(double));
  
  /* ��{���g�� */
  f0[0] = 500.0;
  f0[pcm0.length - 1] = 3500.0;
  for (n = 0; n < pcm0.length; n++)
  {
    f0[n] = f0[0] + (f0[pcm0.length - 1] - f0[0]) * n / (pcm0.length - 1);
  }
  
  /* �m�R�M���g */
  t0 = pcm0.fs / f0[0]; /* ��{���� */
  m = 0;
  for (n = 0; n < pcm0.length; n++)
  {
    pcm0.s[n] = 1.0 - 2.0 * m / t0;
    
    m++;
    if (m >= t0)
    {
      t0 = pcm0.fs / f0[n]; /* ��{���� */
      m = 0;
    }
  }
  
  pcm1.fs = 8000; /* �W�{�����g�� */
  pcm1.bits = 16; /* �ʎq�����x */
  pcm1.length = pcm1.fs * 2; /* ���f�[�^�̒��� */
  pcm1.s = calloc(pcm1.length, sizeof(double)); /* ���f�[�^ */
  
  ratio = pcm0.fs / pcm1.fs; /* �_�E���T���v�����O�̃��V�I */
  
  /* �f�[�^���Ԉ��� */
  for (n = 0; n < pcm1.length; n++)
  {
    pcm1.s[n] = pcm0.s[n * ratio];
  }
  
  gain = 0.1; /* �Q�C�� */
  
  for (n = 0; n < pcm1.length; n++)
  {
    pcm1.s[n] *= gain;
  }
  
  wave_write_16bit_mono(&pcm1, "ex8_11.wav");
  
  free(pcm0.s);
  free(pcm1.s);
  free(f0);
  
  return 0;
}
