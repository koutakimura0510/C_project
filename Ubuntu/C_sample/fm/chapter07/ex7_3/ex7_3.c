#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include "wave.h"
#include "iir_filter.h"

int main(void)
{
  MONO_PCM pcm0, pcm1;
  int n, m, I, J;
  double *s, F1, F2, F3, F4, B1, B2, B3, B4, a[3], b[3];
  
  wave_read_16bit_mono(&pcm0, "pulse_train.wav");
  
  pcm1.fs = pcm0.fs; /* �W�{�����g�� */
  pcm1.bits = pcm0.bits; /* �ʎq�����x */
  pcm1.length = pcm0.length; /* ���f�[�^�̒��� */
  pcm1.s = calloc(pcm1.length, sizeof(double)); /* ���f�[�^ */
  
  s = calloc(pcm1.length, sizeof(double));
  
  F1 = 800.0; /* F1�̎��g�� */
  F2 = 1200.0; /* F2�̎��g�� */
  F3 = 2500.0; /* F3�̎��g�� */
  F4 = 3500.0; /* F4�̎��g�� */
  
  B1 = 100.0; /* F1�̑ш敝 */
  B2 = 100.0; /* F2�̑ш敝 */
  B3 = 100.0; /* F3�̑ш敝 */
  B4 = 100.0; /* F4�̑ш敝 */
  
  I = 2; /* �x����̐� */
  J = 2; /* �x����̐� */
  
  IIR_resonator(F1 / pcm0.fs, F1 / B1, a, b); /* IIR�t�B���^�̐݌v */
  IIR_filtering(pcm0.s, s, pcm0.length, a, b, I, J); /* �t�B���^�����O */
  for (n = 0; n < pcm1.length; n++)
  {
    pcm1.s[n] += s[n];
    s[n] = 0.0;
  }
  
  IIR_resonator(F2 / pcm0.fs, F2 / B2, a, b); /* IIR�t�B���^�̐݌v */
  IIR_filtering(pcm0.s, s, pcm0.length, a, b, I, J); /* �t�B���^�����O */
  for (n = 0; n < pcm1.length; n++)
  {
    pcm1.s[n] += s[n];
    s[n] = 0.0;
  }
  
  IIR_resonator(F3 / pcm0.fs, F3 / B3, a, b); /* IIR�t�B���^�̐݌v */
  IIR_filtering(pcm0.s, s, pcm0.length, a, b, I, J); /* �t�B���^�����O */
  for (n = 0; n < pcm1.length; n++)
  {
    pcm1.s[n] += s[n];
    s[n] = 0.0;
  }
  
  IIR_resonator(F4 / pcm0.fs, F4 / B4, a, b); /* IIR�t�B���^�̐݌v */
  IIR_filtering(pcm0.s, s, pcm0.length, a, b, I, J); /* �t�B���^�����O */
  for (n = 0; n < pcm1.length; n++)
  {
    pcm1.s[n] += s[n];
    s[n] = 0.0;
  }
  
  /* �f�B�G���t�@�V�X���� */
  s[0] = pcm1.s[0];
  for (n = 1; n < pcm1.length; n++)
  {
    s[n] = pcm1.s[n] + 0.98 * s[n - 1];
  }
  
  for (n = 0; n < pcm1.length; n++)
  {
    pcm1.s[n] = s[n];
  }
  
  wave_write_16bit_mono(&pcm1, "ex7_3.wav");
  
  free(pcm0.s);
  free(pcm1.s);
  free(s);
  
  return 0;
}
