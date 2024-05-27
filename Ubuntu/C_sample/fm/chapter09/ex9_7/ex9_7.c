#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include "wave.h"
#include "adsr.h"
#include "iir_filter.h"

int main(void)
{
  MONO_PCM pcm0, pcm1;
  int n, m, t0, I, J, A, D, R, gate, duration;
  double *vco, *vcf, *vca, gain, offset, depth, S, Q, a[3], b[3];
  
  pcm0.fs = 44100; /* �W�{�����g�� */
  pcm0.bits = 16; /* �ʎq�����x */
  pcm0.length = pcm0.fs * 1; /* ���f�[�^�̒��� */
  pcm0.s = calloc(pcm0.length, sizeof(double)); /* ���f�[�^ */
  
  vco = calloc(pcm0.length, sizeof(double)); /* ��{���g�� */
  gate = pcm0.fs * 1;
  duration = pcm0.fs * 1;
  A = 0;
  D = pcm0.fs * 0.4;
  S = 0.0;
  R = pcm0.fs * 0.4;
  ADSR(vco, A, D, S, R, gate, duration);
  
  offset = 40.0; /* ���ԃG���x���[�v�̃I�t�Z�b�g */
  depth = 120.0; /* ���ԃG���x���[�v�̃f�v�X */
  for (n = 0; n < pcm0.length; n++)
  {
    vco[n] = offset + vco[n] * depth;
  }
  
  /* �O�p�g */
  t0 = pcm0.fs / vco[0]; /* ��{���� */
  m = 0;
  for (n = 0; n < pcm0.length; n++)
  {
    if (m < t0 / 2.0)
    {
      pcm0.s[n] = -1.0 + 4.0 * m / t0;
    }
    else
    {
      pcm0.s[n] = 3.0 - 4.0 * m / t0;
    }
    
    m++;
    if (m >= t0)
    {
      t0 = pcm0.fs / vco[n]; /* ��{���� */
      m = 0;
    }
  }
  
  vcf = calloc(pcm0.length, sizeof(double));  /* �Ւf���g�� */
  gate = pcm0.fs * 1;
  duration = pcm0.fs * 1;
  A = 0;
  D = pcm0.fs * 0.4;
  S = 0.0;
  R = pcm0.fs * 0.4;
  ADSR(vcf, A, D, S, R, gate, duration);
  
  offset = 80.0; /* ���ԃG���x���[�v�̃I�t�Z�b�g */
  depth = 240.0; /* ���ԃG���x���[�v�̃f�v�X */
  for (n = 0; n < pcm0.length; n++)
  {
    vcf[n] = offset + vcf[n] * depth;
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
  
  vca = calloc(pcm1.length, sizeof(double)); /* �U�� */
  gate = pcm1.fs * 1;
  duration = pcm1.fs * 1;
  A = 0;
  D = pcm1.fs * 0.4;
  S = 0.0;
  R = pcm1.fs * 0.4;
  ADSR(vca, A, D, S, R, gate, duration);
  
  gain = 0.9; /* �Q�C�� */
  
  for (n = 0; n < pcm1.length; n++)
  {
    pcm1.s[n] *= vca[n] * gain;
  }
  
  /* �t�F�[�h���� */
  for (n = 0; n < pcm1.fs * 0.01; n++)
  {
    pcm1.s[n] *= (double)n / (pcm1.fs * 0.01);
    pcm1.s[pcm1.length - n - 1] *= (double)n / (pcm1.fs * 0.01);
  }
  
  wave_write_16bit_mono(&pcm1, "ex9_7.wav");
  
  free(pcm0.s);
  free(pcm1.s);
  free(vco);
  free(vca);
  
  return 0;
}
