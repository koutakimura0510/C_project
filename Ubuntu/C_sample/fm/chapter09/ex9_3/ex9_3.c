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
  
  pcm0.fs = 44100; /* 標本化周波数 */
  pcm0.bits = 16; /* 量子化精度 */
  pcm0.length = pcm0.fs * 2; /* 音データの長さ */
  pcm0.s = calloc(pcm0.length, sizeof(double)); /* 音データ */
  
  vco = 500.0; /* 基本周波数 */
  
  /* ノコギリ波 */
  t0 = pcm0.fs / vco; /* 基本周期 */
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
  
  /* 時間エンベロープ */
  vcf[0] = 1000.0; /* Hz */
  am = 800.0; /* LFOの振幅 */
  fm = 2.0; /* LFOの周波数 */
  /* LFO */
  for (n = 0; n < pcm0.length; n++)
  {
    vcf[n] = vcf[0] + am * sin(2.0 * M_PI * fm * n / pcm0.fs);
  }
  
  Q = 5.0; /* レゾナンス */
  I = 2; /* 遅延器の数 */
  J = 2; /* 遅延器の数 */
  
  pcm1.fs = pcm0.fs; /* 標本化周波数 */
  pcm1.bits = pcm0.bits; /* 量子化精度 */
  pcm1.length = pcm0.length; /* 音データの長さ */
  pcm1.s = calloc(pcm1.length, sizeof(double)); /* 音データ */
  
  /* フィルタリング */
  for (n = 0; n < pcm1.length; n++)
  {
    IIR_LPF(vcf[n] / pcm1.fs, Q, a, b); /* IIRフィルタの設計 */
    
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
  
  gain = 0.1; /* ゲイン */
  
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
