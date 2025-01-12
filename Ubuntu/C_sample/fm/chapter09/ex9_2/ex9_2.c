#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include "wave.h"

int main(void)
{
  MONO_PCM pcm;
  int n, m, t0;
  double *vco, gain, am, fm;
  
  pcm.fs = 44100; /* W{»üg */
  pcm.bits = 16; /* Êq»¸x */
  pcm.length = pcm.fs * 2; /* ¹f[^Ì·³ */
  pcm.s = calloc(pcm.length, sizeof(double)); /* ¹f[^ */
  
  vco = calloc(pcm.length, sizeof(double));
  
  /* ÔGx[v */
  vco[0] = 500.0; /* Hz */
  am = 100.0; /* LFOÌU */
  fm = 2.0; /* LFOÌüg */
  /* LFO */
  for (n = 0; n < pcm.length; n++)
  {
    vco[n] = vco[0] + am * sin(2.0 * M_PI * fm * n / pcm.fs);
  }
  
  /* mRMg */
  t0 = pcm.fs / vco[0]; /* î{üú */
  m = 0;
  for (n = 0; n < pcm.length; n++)
  {
    pcm.s[n] = 1.0 - 2.0 * m / t0;
    
    m++;
    if (m >= t0)
    {
      t0 = pcm.fs / vco[n]; /* î{üú */
      m = 0;
    }
  }
  
  gain = 0.1; /* QC */
  
  for (n = 0; n < pcm.length; n++)
  {
    pcm.s[n] *= gain;
  }
  
  wave_write_16bit_mono(&pcm, "ex9_2.wav");
  
  free(pcm.s);
  free(vco);
  
  return 0;
}
