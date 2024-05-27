#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include "wave.h"
#include "iir_filter.h"

int main(void)
{
  MONO_PCM pcm0, pcm1;
  int n, m, t0, I, J;
  double vco, *vcf, gain, am, fm, Q, a[3], b[3];
  
  pcm0.fs = 44100; /* �W�{�����g�� */
  pcm0.bits = 16; /* �ʎq�����x */
  pcm0.length = pcm0.fs * 2; /* ���f�[�^�̒��� */
  pcm0.s = calloc(pcm0.length, sizeof(double)); /* ���f�[�^ */
  
  vco = 500.0; /* ��{���g�� */
  
  /* �m�R�M���g */
  t0 = pcm0.fs / vco; /* ��{���� */
  m = 0;
  for (n = 0; n < pcm0.length; n++)
  {
    pcm0.s[n] = 1.0 - 2.0 * m / t0;
    
    m++;
    if (m >= t0)
    {
      m = 0;
    }
  }
  
  vcf = calloc(pcm0.length, sizeof(double));
  
  /* ���ԃG���x���[�v */
  vcf[0] = 1000.0; /* Hz */
  am = 800.0; /* LFO�̐U�� */
  fm = 2.0; /* LFO�̎��g�� */
  /* LFO */
  for (n = 0; n < pcm0.length; n++)
  {
    vcf[n] = vcf[0] + am * sin(2.0 * M_PI * fm * n / pcm0.fs);
  }
  
  Q = 5.0; /* ���]�i���X */
  I = 2; /* �x����̐� */
  J = 2; /* �x����̐� */
  
  pcm1.fs = pcm0.fs; /* �W�{�����g�� */
  pcm1.bits = pcm0.bits; /* �ʎq�����x */
  pcm1.length = pcm0.length; /* ���f�[�^�̒��� */
  pcm1.s = calloc(pcm1.length, sizeof(double)); /* ���f�[�^ */
  
  /* �t�B���^�����O */
  for (n = 0; n < pcm1.length; n++)
  {
    IIR_LPF(vcf[n] / pcm1.fs, Q, a, b); /* IIR�t�B���^�̐݌v */
    
    for (m = 0; m <= J; m++)
    {
      if (n - m >= 0)
      {
        pcm1.s[n] += b[m] * pcm0.s[n - m];
      }
    }
    for (m = 1; m <= I; m++)
    {
      if (n - m >= 0)
      {
        pcm1.s[n] += -a[m] * pcm1.s[n - m];
      }
    }
  }
  
  gain = 0.1; /* �Q�C�� */
  
  for (n = 0; n < pcm1.length; n++)
  {
    pcm1.s[n] *= gain;
  }
  
  wave_write_16bit_mono(&pcm1, "ex9_3.wav");
  
  free(pcm0.s);
  free(pcm1.s);
  free(vcf);
  
  return 0;
}
