#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include "wave.h"
#include "sinc.h"

int main(void)
{
  MONO_PCM pcm;
  int n, N, ta, tb;
  double vco, gain, t0, t, sign, *s;
  
  pcm.fs = 44100; /* �W�{�����g�� */
  pcm.bits = 16; /* �ʎq�����x */
  pcm.length = pcm.fs * 1; /* ���f�[�^�̒��� */
  pcm.s = calloc(pcm.length, sizeof(double)); /* ���f�[�^ */
  
  vco = 500.0; /* ��{���g�� */
  
  /* �o�ɐ��p���X�� */
  t0 = pcm.fs / vco; /* ��{���� */
  t = 0.0;
  sign = 1.0;
  N = 128;
  while (t < pcm.length)
  {
    ta = (int)t;
    
    if (t == ta)
    {
      tb = ta;
    }
    else
    {
      tb = ta + 1;
    }
    
    for (n = tb - N / 2; n <= ta + N / 2; n++)
    {
      if (n >= 0 && n < pcm.length)
      {
        pcm.s[n] += sign * sinc(M_PI * (t - n)) * (0.5 + 0.5 * cos(2.0 * M_PI * (t - n) / (N * 2 + 1)));
      }
    }
    
    t += t0 / 2.0;
    sign *= -1.0;
  }
  
  s = calloc(pcm.length, sizeof(double));
  
  /* �ϕ��t�B���^ */
  s[0] = pcm.s[0] - 0.5;
  for (n = 1; n < pcm.length; n++)
  {
    s[n] = pcm.s[n] + 0.98 * s[n - 1];
  }
  
  for (n = 0; n < pcm.length; n++)
  {
    pcm.s[n] = s[n] * 2.0;
  }
  
  for (n = 0; n < pcm.length; n++)
  {
    pcm.s[n] *= 2.0 / t0;
  }
  
  /* �ϕ��t�B���^ */
  s[0] = pcm.s[0] - 0.5;
  for (n = 1; n < pcm.length; n++)
  {
    s[n] = pcm.s[n] + 0.98 * s[n - 1];
  }
  
  for (n = 0; n < pcm.length; n++)
  {
    pcm.s[n] = s[n] * 2.0;
  }
  
  gain = 0.1; /* �Q�C�� */
  
  for (n = 0; n < pcm.length; n++)
  {
    pcm.s[n] *= gain;
  }
  
  wave_write_16bit_mono(&pcm, "ex9_10.wav");
  
  free(pcm.s);
  free(s);
  
  return 0;
}
