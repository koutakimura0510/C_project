#include <stdio.h>
#include <stdlib.h>
#include "wave.h"

void square_wave(MONO_PCM *pcm, double f0, double gain, int offset, int duration)
{
  int n, m, t0;
  double *s;
  
  s = calloc(duration, sizeof(double));
  
  /* ��`�g */
  t0 = pcm->fs / f0; /* ��{���� */
  m = 0;
  for (n = 0; n < duration; n++)
  {
    if (m < t0 / 2.0)
    {
      s[n] = 1.0;
    }
    else
    {
      s[n] = -1.0;
    }
    
    m++;
    if (m >= t0)
    {
      m = 0;
    }
  }
  
  for (n = 0; n < duration; n++)
  {
    s[n] *= gain;
  }
  
  for (n = 0; n < duration; n++)
  {
    pcm->s[offset + n] += s[n];
  }
  
  free(s);
}

void triangle_wave(MONO_PCM *pcm, double f0, double gain, int offset, int duration)
{
  int n, m, t0;
  double *s;
  
  s = calloc(duration, sizeof(double));
  
  /* �O�p�g */
  t0 = pcm->fs / f0; /* ��{���� */
  m = 0;
  for (n = 0; n < duration; n++)
  {
    if (m < t0 / 2.0)
    {
      s[n] = -1.0 + 4.0 * m / t0;
    }
    else
    {
      s[n] = 3.0 - 4.0 * m / t0;
    }
    
    m++;
    if (m >= t0)
    {
      m = 0;
    }
  }
  
  for (n = 0; n < duration; n++)
  {
    s[n] *= gain;
  }
  
  for (n = 0; n < duration; n++)
  {
    pcm->s[offset + n] += s[n];
  }
  
  free(s);
}

void white_noise(MONO_PCM *pcm, double gain, int offset, int duration)
{
  int n;
  double *s;
  
  s = calloc(duration, sizeof(double));
  
  /* ���F�G�� */
  for (n = 0; n < duration; n++)
  {
    s[n] = (double)rand() / RAND_MAX * 2.0 - 1.0;
  }
  
  for (n = 0; n < duration; n++)
  {
    s[n] *= gain;
  }
  
  for (n = 0; n < duration; n++)
  {
    pcm->s[offset + n] += s[n];
  }
  
  free(s);
}

int main(void)
{
  MONO_PCM pcm;
  
  pcm.fs = 44100; /* �W�{�����g�� */
  pcm.bits = 16; /* �ʎq�����x */
  pcm.length = 7000 * 16; /* ���f�[�^�̒��� */
  pcm.s = calloc(pcm.length, sizeof(double)); /* ���f�[�^ */
  
  /* �����f�B�p�[�g */
  square_wave(&pcm, 659.26, 0.1, 7000 * 0, 6125); /* E5 */
  square_wave(&pcm, 659.26, 0.1, 7000 * 1, 6125); /* E5 */
  square_wave(&pcm, 659.26, 0.1, 7000 * 3, 6125); /* E5 */
  square_wave(&pcm, 523.25, 0.1, 7000 * 5, 6125); /* C5 */
  square_wave(&pcm, 659.26, 0.1, 7000 * 6, 6125); /* E5 */
  square_wave(&pcm, 783.99, 0.1, 7000 * 8, 6125); /* G5 */
  square_wave(&pcm, 392.00, 0.1, 7000 * 12, 6125); /* G4 */
  
  /* �x�[�X�p�[�g */
  triangle_wave(&pcm, 146.83, 0.2, 7000 * 0, 6125); /* D3 */
  triangle_wave(&pcm, 146.83, 0.2, 7000 * 1, 6125); /* D3 */
  triangle_wave(&pcm, 146.83, 0.2, 7000 * 3, 6125); /* D3 */
  triangle_wave(&pcm, 146.83, 0.2, 7000 * 5, 6125); /* D3 */
  triangle_wave(&pcm, 146.83, 0.2, 7000 * 6, 6125); /* D3 */
  triangle_wave(&pcm, 196.00, 0.2, 7000 * 8, 6125); /* G3 */
  triangle_wave(&pcm, 196.00, 0.2, 7000 * 12, 6125); /* G3 */
  
  /* �p�[�J�b�V���� */
  white_noise(&pcm, 0.1, 7000 * 0, 4000);
  white_noise(&pcm, 0.1, 7000 * 2, 1000);
  white_noise(&pcm, 0.1, 7000 * 3, 4000);
  white_noise(&pcm, 0.1, 7000 * 5, 1000);
  white_noise(&pcm, 0.1, 7000 * 6, 4000);
  white_noise(&pcm, 0.1, 7000 * 8, 4000);
  white_noise(&pcm, 0.1, 7000 * 11, 4000);
  white_noise(&pcm, 0.1, 7000 * 13, 1000);
  white_noise(&pcm, 0.1, 7000 * 14, 1000);
  white_noise(&pcm, 0.1, 7000 * 15, 1000);
  
  wave_write_16bit_mono(&pcm, "ex8_6.wav");
  
  free(pcm.s);
  
  return 0;
}
