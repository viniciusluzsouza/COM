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
sinal_tx = real(info_mod.*exp(j*wc*t));

figure(1)
subplot(211)
plot(t, abs(info_mod))
title('Sinal Informacao 16-QAM')
xlabel('tempo (s)'); ylabel('Amplitude (V)');
xlim([0 3e-3]);
subplot(212)
plot(t, sinal_tx)
title('Sinal Modulado com Exponencial')
xlabel('tempo (s)'); ylabel('Amplitude (V)');
xlim([0 3e-3]);

scatterplot(info_mod)