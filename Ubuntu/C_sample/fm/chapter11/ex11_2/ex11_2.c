#include <stdio.h>
#include <stdlib.h>
#include "wave.h"

int main(void)
{
  MONO_PCM pcm0, pcm1;
  int n, m, template_size, pmin, pmax, p, q, offset0, offset1;
  double rate, rmax, *x, *y, *r;
  
  wave_read_16bit_mono(&pcm0, "sine_1s.wav");
  
  rate = 0.5; /* 0.5 <= rate < 1.0 */
  
  pcm1.fs = pcm0.fs; /* �W�{�����g�� */
  pcm1.bits = pcm0.bits; /* �ʎq�����x */
  pcm1.length = (int)(pcm0.length / rate) + 1; /* ���f�[�^�̒��� */
  pcm1.s = calloc(pcm1.length, sizeof(double)); /* ���f�[�^ */
  
  template_size = (int)(pcm1.fs * 0.01); /* ���֊֐��̃T�C�Y */
  pmin = (int)(pcm1.fs * 0.005); /* �s�[�N�̒T���͈͂̉��� */
  pmax = (int)(pcm1.fs * 0.02); /* �s�[�N�̒T���͈͂̏�� */
  
  x = calloc(template_size, sizeof(double));
  y = calloc(template_size, sizeof(double));
  r = calloc((pmax + 1), sizeof(double));
  
  offset0 = 0;
  offset1 = 0;
  
  while (offset0 + pmax * 2 < pcm0.length)
  {
    for (n = 0; n < template_size; n++)
    {
      x[n] = pcm0.s[offset0 + n]; /* �{���̉��f�[�^ */
    }
    
    rmax = 0.0;
    p = pmin;
    for (m = pmin; m <= pmax; m++)
    {
      for (n = 0; n < template_size; n++)
      {
        y[n] = pcm0.s[offset0 + m + n]; /* m�T���v�����炵�����f�[�^ */
      }
      r[m] = 0.0;
      for (n = 0; n < template_size; n++)
      {
        r[m] += x[n] * y[n]; /* ���֊֐� */
      }
      if (r[m] > rmax)
      {
        rmax = r[m]; /* ���֊֐��̃s�[�N */
        p = m; /* �g�`�̎��� */
      }
    }
    
    for (n = 0; n < p; n++)
    {
      pcm1.s[offset1 + n] = pcm0.s[offset0 + n];
    }
    for (n = 0; n < p; n++)
    {
      pcm1.s[offset1 + p + n] = pcm0.s[offset0 + p + n] * (p - n) / p; /* �P�������̏d�݂Â� */
      pcm1.s[offset1 + p + n] += pcm0.s[offset0 + n] * n / p; /* �P�������̏d�݂Â� */
    }
    
    q = (int)(p * rate / (1.0 - rate) + 0.5);
    for (n = p; n < q; n++)
    {
      if (offset0 + n >= pcm0.length)
      {
        break;
      }
      pcm1.s[offset1 + p + n] = pcm0.s[offset0 + n];
    }
    
    offset0 += q; /* offset0�̍X�V */
    offset1 += p + q; /* offset1�̍X�V */
  }
  
  wave_write_16bit_mono(&pcm1, "ex11_2.wav");
  
  free(pcm0.s);
  free(pcm1.s);
  free(x);
  free(y);
  free(r);
  
  return 0;
}
