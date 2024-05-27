#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include "wave.h"
#include "sinc.h"

int main(void)
{
  MONO_PCM pcm0, pcm1;
  int n, m, N, ta, tb;
  double t, pitch;
  
  wave_read_16bit_mono(&pcm0, "sine_500hz.wav");
  
  pitch = 2.0; /* ���̍�����2�{�ɂ��� */
  
  pcm1.fs = pcm0.fs; /* �W�{�����g�� */
  pcm1.bits = pcm0.bits; /* �ʎq�����x */
  pcm1.length = (int)(pcm0.length / pitch); /* ���f�[�^�̒��� */
  pcm1.s = calloc(pcm1.length, sizeof(double)); /* ���f�[�^ */
  
  N = 128; /* �n�j���O���̃T�C�Y */
  
  for (n = 0; n < pcm1.length; n++)
  {
    t = pitch * n;
    
    ta = (int)t;
    
    if (t == ta)
    {
      tb = ta;
    }
    else
    {
      tb = ta + 1;
    }
    
    for (m = tb - N / 2; m <= ta + N / 2; m++)
    {
      if (m >= 0 && m < pcm0.length)
      {
        pcm1.s[n] += pcm0.s[m] * sinc(M_PI * (t - m)) * (0.5 + 0.5 * cos(2.0 * M_PI * (t - m) / (N * 2 + 1)));
      }
    }
  }
  
  wave_write_16bit_mono(&pcm1, "ex11_3.wav");
  
  free(pcm0.s);
  free(pcm1.s);
  
  return 0;
}
