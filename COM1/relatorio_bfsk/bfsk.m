clear all;
close all;
clc;

ordemFiltros = 100;
L = 10;
N = 100;
M = 2;
fc = 10e3;
info = randi([0 M-1], [1 L]);
passo = (2*length(info)/fc)/(length(info)*N);
info_format = rectpulse(info, N);
t = [0:passo:(2*length(info)/fc)-passo];
s_t_fsk = cos(2*pi*fc*t.*(info_format+1)); % FSK
s_f_fsk = fftshift(fft(s_t_fsk)/length(s_t_fsk));
fa = 1/passo;
f = [-fa/2:fa/1000:fa/2-1];

% Sinal transmitido 
figure(1)
subplot(211)
plot(t, info_format)
title('Sinal de Informacao');
xlabel('tempo (s)'); ylabel('Amplitude (V)');
subplot(212)
plot(t, s_t_fsk)
title('Sinal Modulado - BFSK');
xlabel('tempo (s)'); ylabel('Amplitude (V)');

fpf_10k = fir1(ordemFiltros, ([5e3 15e3]*2)/fa);
fpf_20k = fir1(ordemFiltros, ([15e3 25e3]*2)/fa);
info_10k = filter(fpf_10k, 1, s_t_fsk);
info_20k = filter(fpf_20k, 1, s_t_fsk);

figure(2)
subplot(211)
plot(t, info_10k)
title('Sinal Frequencia 1 (10 KHz)');
xlabel('tempo (s)'); ylabel('Amplitude (V)');
subplot(212)
plot(t, info_20k)
title('Sinal Frequencia 2 (20 KHz)');
xlabel('tempo (s)'); ylabel('Amplitude (V)');

info_10k_abs = abs(info_10k);
info_20k_abs = abs(info_20k);

figure(3)
subplot(211)
plot(t, info_10k_abs)
title('Sinal Frequencia 1 Absoluto (10 KHz)');
xlabel('tempo (s)'); ylabel('Amplitude (V)');
subplot(212)
plot(t, info_20k_abs)
title('Sinal Frequencia 2 Absoluto (20 KHz)');
xlabel('tempo (s)'); ylabel('Amplitude (V)');

fpb_10k = fir1(ordemFiltros, (5e3*2)/fa);
fpb_20k = fir1(ordemFiltros, (10e3*2)/fa);
info_out_10k = filter(fpb_10k, 1, info_10k_abs);
info_out_20k = filter(fpb_20k, 1, info_20k_abs);

figure(4)
subplot(211)
plot(t, info_out_10k)
title('Sinal Frequencia 1 Envoltoria (10 KHz)');
xlabel('tempo (s)'); ylabel('Amplitude (V)');
subplot(212)
plot(t, info_out_20k)
title('Sinal Frequencia 2 Envoltoria (20 KHz)');
xlabel('tempo (s)'); ylabel('Amplitude (V)');
