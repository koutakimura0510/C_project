#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include "wave.h"

int main(void)
{
  MONO_PCM pcm;
  int n;
  double ac, fc, am, fm, ratio, gain;
  
  pcm.fs = 44100; /* W{»üg */
  pcm.bits = 16; /* Êq»¸x */
  pcm.length = pcm.fs * 1; /* ¹f[^Ì·³ */
  pcm.s = calloc(pcm.length, sizeof(double)); /* ¹f[^ */
  
  ac = 1.0; /* LAU */
  fc = 500.0; /* LAüg */
  
  am = 1.0; /* W[^U */
  ratio = 1.0; /* ügä */
  fm = fc * ratio; /* W[^üg */
  
  /* FM¹¹ */
  for (n = 0; n < pcm.length; n++)
  {
    pcm.s[n] = ac * sin(2.0 * M_PI * fc * n / pcm.fs
             + am * sin(2.0 * M_PI * fm * n / pcm.fs));
  }
  
  gain = 0.1; /* QC */
  
  for (n = 0; n < pcm.length; n++)
  {
    pcm.s[n] *= gain;
  }
  
  wave_write_16bit_mono(&pcm, "ex10_1.wav");
  
  free(pcm.s);
  
  return 0;
}
