close all;
clear all;
clc;

N = 20;
M = 16;
fc = 10e3;
wc = 2*pi*fc;

info = randi([0 M-1], [1 100]);
info_format = rectpulse(info, N);
passo = (2*length(info)/fc)/(length(info)*N);
t = [0:passo:(2*length(info)/fc)-passo];

info_mod = qammod(info_format, M);

info_mod_real = real(info_mod);
info_mod_imag = imag(info_mod);

sinal_real_format = cos(wc*t).*info_mod_real;
sinal_imag_format = sin(wc*t).*info_mod_imag;
sinal_tx = sinal_real_format - sinal_imag_format;

figure(1)
subplot(411)
plot(t, abs(info_mod))
title('Sinal Informacao 16-QAM')
xlabel('tempo (s)'); ylabel('Amplitude (V)');
xlim([0 3e-3]);
subplot(412)
plot(t, sinal_real_format)
title('Sinal em Fase')
xlabel('tempo (s)'); ylabel('Amplitude (V)');
xlim([0 3e-3]);
subplot(413)
plot(t, sinal_imag_format)
title('Sinal em Quadratura')
xlabel('tempo (s)'); ylabel('Amplitude (V)');
xlim([0 3e-3]);
subplot(414)
plot(t, sinal_tx)
title('Sinal Modulado com Seno e Cosseno')
xlabel('tempo (s)'); ylabel('Amplitude (V)');
xlim([0 3e-3]);

figure(2)
subplot(211)
plot(t, abs(info_mod))
title('Sinal Informacao 16-QAM')
xlabel('tempo (s)'); ylabel('Amplitude (V)');
xlim([0 3e-3]);
subplot(212)
plot(t, sinal_tx)
title('Sinal Modulado com Seno e Cosseno')
xlabel('tempo (s)'); ylabel('Amplitude (V)');
xlim([0 3e-3]);

scatterplot(info_mod)
