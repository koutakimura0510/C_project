#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include "wave.h"
#include "window_function.h"
#include "sinc.h"
#include "fir_filter.h"
#include "fft.h"

int main(void)
{
  MONO_PCM pcm0, pcm1;
  int n, m, k, J, L, N, offset, frame, number_of_frame;
  double *x_real, *x_imag, *y_real, *y_imag, *b_real, *b_imag;
  double fe, delta, *b, *w;
  
  wave_read_16bit_mono(&pcm0, "sine_500hz_3500hz.wav");
  
  pcm1.fs = pcm0.fs; /* �W�{�����g�� */
  pcm1.bits = pcm0.bits; /* �ʎq�����x */
  pcm1.length = pcm0.length; /* ���f�[�^�̒��� */
  pcm1.s = calloc(pcm1.length, sizeof(double)); /* ���f�[�^ */
  
  fe = 1000.0 / pcm0.fs; /* �G�b�W���g�� */
  delta = 1000.0 / pcm0.fs; /* �J�ڑш敝 */
  
  J = (int)(3.1 / delta + 0.5) - 1; /* �x����̐� */
  if (J % 2 == 1)
  {
    J++; /* J+1����ɂȂ�悤�ɒ������� */
  }
  
  b = calloc((J + 1), sizeof(double));
  w = calloc((J + 1), sizeof(double));
  
  Hanning_window(w, (J + 1)); /* �n�j���O�� */
  
  FIR_LPF(fe, J, b, w); /* FIR�t�B���^�̐݌v */
  
  L = 128; /* �t���[���̒��� */
  N = 256; /* DFT�̃T�C�Y */
  
  x_real = calloc(N, sizeof(double));
  x_imag = calloc(N, sizeof(double));
  y_real = calloc(N, sizeof(double));
  y_imag = calloc(N, sizeof(double));
  b_real = calloc(N, sizeof(double));
  b_imag = calloc(N, sizeof(double));
  
  number_of_frame = pcm0.length / L; /* �t���[���̐� */
  
  for (frame = 0; frame < number_of_frame; frame++)
  {
    offset = L * frame;
    
    /* X(k) */
    for (n = 0; n < N; n++)
    {
      x_real[n] = 0.0;
      x_imag[n] = 0.0;
    }
    for (n = 0; n < L; n++)
    {
      x_real[n] = pcm0.s[offset + n];
    }
    FFT(x_real, x_imag, N);
    
    /* B(k) */
    for (m = 0; m < N; m++)
    {
      b_real[m] = 0.0;
      b_imag[m] = 0.0;
    }
    for (m = 0; m <= J; m++)
    {
      b_real[m] = b[m];
    }
    FFT(b_real, b_imag, N);
    
    /* �t�B���^�����O */
    for (k = 0; k < N; k++)
    {
      y_real[k] = x_real[k] * b_real[k] - x_imag[k] * b_imag[k];
      y_imag[k] = x_imag[k] * b_real[k] + x_real[k] * b_imag[k];
    }
    IFFT(y_real, y_imag, N);
    
    /* �I�[�o�[���b�v�A�h */
    for (n = 0; n < N; n++)
    {
      if (offset + n < pcm1.length)
      {
        pcm1.s[offset + n] += y_real[n];
      }
    }
  }
  
  wave_write_16bit_mono(&pcm1, "ex6_3.wav"); 
  
  free(pcm0.s);
  free(pcm1.s);
  free(x_real);
  free(x_imag);
  free(y_real);
  free(y_imag);
  free(b_real);
  free(b_imag);
  free(b);
  free(w);
  
  return 0;
}
