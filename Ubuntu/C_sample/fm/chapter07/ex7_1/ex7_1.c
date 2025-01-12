#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include "wave.h"
#include "iir_filter.h"

int main(void)
{
  MONO_PCM pcm0, pcm1;
  int n, m, I, J;
  double *fc, Q, a[3], b[3];
  
  wave_read_16bit_mono(&pcm0, "pulse_train.wav");
  
  fc = calloc(pcm0.length, sizeof(double));
  
  /* LPFÌÕfüg */
  for (n = 0; n < pcm0.length; n++)
  {
    fc[n] = 10000.0 * exp(-5.0 * n / pcm0.length);
  }
  
  Q = 1.0 / sqrt(2); /* NIeBt@N^ */
  I = 2; /* xíÌ */
  J = 2; /* xíÌ */
  
  pcm1.fs = pcm0.fs; /* W{»üg */
  pcm1.bits = pcm0.bits; /* Êq»¸x */
  pcm1.length = pcm0.length; /* ¹f[^Ì·³ */
  pcm1.s = calloc(pcm1.length, sizeof(double)); /* ¹f[^ */
  
  for (n = 0; n < pcm1.length; n++)
  {
    IIR_LPF(fc[n] / pcm1.fs, Q, a, b); /* IIRtB^ÌÝv */
    
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
  
  wave_write_16bit_mono(&pcm1, "ex7_1.wav");
  
  free(pcm0.s);
  free(pcm1.s);
  free(fc);
  
  return 0;
}
