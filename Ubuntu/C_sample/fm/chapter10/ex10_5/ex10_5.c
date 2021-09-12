#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include "wave.h"
#include "adsr.h"

int main(void)
{
  MONO_PCM pcm0, pcm1;
  int n, A, D, R, gate, duration;
  double *ac, fc, *am, fm, ratio, gain, S;
  
  pcm0.fs = 44100; /* �W�{�����g�� */
  pcm0.bits = 16; /* �ʎq�����x */
  pcm0.length = pcm0.fs * 4; /* ���f�[�^�̒��� */
  pcm0.s = calloc(pcm0.length, sizeof(double)); /* ���f�[�^ */
  
  pcm1.fs = pcm0.fs; /* �W�{�����g�� */
  pcm1.bits = pcm0.bits; /* �ʎq�����x */
  pcm1.length = pcm0.length; /* ���f�[�^�̒��� */
  pcm1.s = calloc(pcm1.length, sizeof(double)); /* ���f�[�^ */
  
  ac = calloc(pcm0.length, sizeof(double));
  am = calloc(pcm0.length, sizeof(double));
  
  /* �L�����A�U�� */
  gate = pcm0.fs * 4;
  duration = pcm0.fs * 4;
  A = 0;
  D = pcm0.fs * 4;
  S = 0.0;
  R = pcm0.fs * 1;
  ADSR(ac, A, D, S, R, gate, duration);
  
  fc = 440.0; /* �L�����A���g�� */
  
  /* ���W�����[�^�U�� */
  gate = pcm0.fs * 4;
  duration = pcm0.fs * 4;
  A = 0;
  D = pcm0.fs * 2;
  S = 0.0;
  R = pcm0.fs * 2;
  ADSR(am, A, D, S, R, gate, duration);
  
  ratio = 1.0;
  fm = 440.0 * ratio; /* ���W�����[�^���g�� */
  
  /* FM���� */
  for (n = 0; n < pcm0.length; n++)
  {
    pcm0.s[n] = ac[n] * sin(2.0 * M_PI * fc * n / pcm0.fs
              + am[n] * sin(2.0 * M_PI * fm * n / pcm0.fs));
  }
  
  /* �L�����A�U�� */
  gate = pcm1.fs * 4;
  duration = pcm1.fs * 4;
  A = 0;
  D = pcm1.fs * 1;
  S = 0.0;
  R = pcm1.fs * 1;
  ADSR(ac, A, D, S, R, gate, duration);
  
  fc = 440.0; /* �L�����A���g�� */
  
  /* ���W�����[�^�U�� */
  gate = pcm1.fs * 4;
  duration = pcm1.fs * 4;
  A = 0;
  D = pcm1.fs * 1;
  S = 0.0;
  R = pcm1.fs * 1;
  ADSR(am, A, D, S, R, gate, duration);
  
  ratio = 14.0;
  fm = fc * ratio; /* ���W�����[�^���g�� */
  
  /* FM���� */
  for (n = 0; n < pcm1.length; n++)
  {
    pcm1.s[n] = ac[n] * sin(2.0 * M_PI * fc * n / pcm1.fs
              + am[n] * sin(2.0 * M_PI * fm * n / pcm1.fs));
  }
  
  gain = 0.1; /* �Q�C�� */
  
  for (n = 0; n < pcm1.length; n++)
  {
    pcm1.s[n] += pcm0.s[n];
    pcm1.s[n] *= gain;
  }
  
  wave_write_16bit_mono(&pcm1, "ex10_5.wav");
  
  free(pcm0.s);
  free(pcm1.s);
  free(ac);
  free(am);
  
  return 0;
}
