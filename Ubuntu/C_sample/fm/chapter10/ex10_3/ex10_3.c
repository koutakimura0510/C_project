#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include "wave.h"

int main(void)
{
  MONO_PCM pcm;
  int n;
  double ac, fc, am, fm, ratio, gain;
  
  pcm.fs = 44100; /* �W�{�����g�� */
  pcm.bits = 16; /* �ʎq�����x */
  pcm.length = pcm.fs * 1; /* ���f�[�^�̒��� */
  pcm.s = calloc(pcm.length, sizeof(double)); /* ���f�[�^ */
  
  ac = 1.0; /* �L�����A�U�� */
  fc = 500.0; /* �L�����A���g�� */
  
  am = 1.0; /* ���W�����[�^�U�� */
  ratio = 3.5; /* ���g���� */
  fm = fc * ratio; /* ���W�����[�^���g�� */
  
  /* FM���� */
  for (n = 0; n < pcm.length; n++)
  {
    pcm.s[n] = ac * sin(2.0 * M_PI * fc * n / pcm.fs
             + am * sin(2.0 * M_PI * fm * n / pcm.fs));
  }
  
  gain = 0.1; /* �Q�C�� */
  
  for (n = 0; n < pcm.length; n++)
  {
    pcm.s[n] *= gain;
  }
  
  wave_write_16bit_mono(&pcm, "ex10_3.wav");
  
  free(pcm.s);
  
  return 0;
}
