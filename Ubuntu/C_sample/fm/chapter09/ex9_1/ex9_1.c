#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include "wave.h"

int main(void)
{
  MONO_PCM pcm;
  int n, m, t0;
  double vco, *vca, gain, am, fm;
  
  pcm.fs = 44100; /* �W�{�����g�� */
  pcm.bits = 16; /* �ʎq�����x */
  pcm.length = pcm.fs * 2; /* ���f�[�^�̒��� */
  pcm.s = calloc(pcm.length, sizeof(double)); /* ���f�[�^ */
  
  vco = 500.0; /* ��{���g�� */
  
  /* �m�R�M���g */
  t0 = pcm.fs / vco; /* ��{���� */
  m = 0;
  for (n = 0; n < pcm.length; n++)
  {
    pcm.s[n] = 1.0 - 2.0 * m / t0;
    
    m++;
    if (m >= t0)
    {
      m = 0;
    }
  }
  
  vca = calloc(pcm.length, sizeof(double));
  
  /* ���ԃG���x���[�v */
  vca[0] = 1.0;
  am = 0.2; /* LFO�̐U�� */
  fm = 2.0; /* LFO�̎��g�� */
  /* LFO */
  for (n = 0; n < pcm.length; n++)
  {
    vca[n] = vca[0] + am * sin(2.0 * M_PI * fm * n / pcm.fs);
  }
  
  gain = 0.1; /* �Q�C�� */
  
  for (n = 0; n < pcm.length; n++)
  {
    pcm.s[n] *= vca[n] * gain;
  }
  
  wave_write_16bit_mono(&pcm, "ex9_1.wav");
  
  free(pcm.s);
  free(vca);
  
  return 0;
}
