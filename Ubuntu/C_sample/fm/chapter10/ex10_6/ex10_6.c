#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include "wave.h"
#include "adsr.h"

int main(void)
{
  MONO_PCM pcm;
  int n, A, D, R, gate, duration;
  double *ac, fc, *am, fm, ratio, gain, S;
  
  pcm.fs = 44100; /* �W�{�����g�� */
  pcm.bits = 16; /* �ʎq�����x */
  pcm.length = pcm.fs * 4; /* ���f�[�^�̒��� */
  pcm.s = calloc(pcm.length, sizeof(double)); /* ���f�[�^ */
  
  ac = calloc(pcm.length, sizeof(double));
  am = calloc(pcm.length, sizeof(double));
  
  /* �L�����A�U�� */
  gate = pcm.fs * 4;
  duration = pcm.fs * 4;
  A = 0;
  D = pcm.fs * 4;
  S = 0.0;
  R = pcm.fs * 4;
  ADSR(ac, A, D, S, R, gate, duration);
  
  fc = 440.0; /* �L�����A���g�� */
  
  /* ���W�����[�^�U�� */
  gate = pcm.fs * 4;
  duration = pcm.fs * 4;
  A = 0;
  D = pcm.fs * 2;
  S = 0.0;
  R = pcm.fs * 2;
  ADSR(am, A, D, S, R, gate, duration);
  
  ratio = 3.5;
  fm = fc * ratio; /* ���W�����[�^���g�� */
  
  /* AM�ϒ� */
  for (n = 0; n < pcm.length; n++)
  {
    pcm.s[n] = ac[n] * sin(2.0 * M_PI * fc * n / pcm.fs)
             * (1.0 + am[n] * sin(2.0 * M_PI * fm * n / pcm.fs));
  }
  
  gain = 0.1; /* �Q�C�� */
  
  for (n = 0; n < pcm.length; n++)
  {
    pcm.s[n] *= gain;
  }
  
  wave_write_16bit_mono(&pcm, "ex10_6.wav");
  
  free(pcm.s);
  free(ac);
  free(am);
  
  return 0;
}
