clear all;
clc;
close all;

fa = 100e3;
f1 = 1e3;
f2 = 3*f1;
f3 = 5*f1;
t = [0:1/fa:5*(1/1e3)];
f = [-fa/2:200:fa/2];

x1_t = 6*sin(2*pi*t*f1);
x2_t = 2*sin(2*pi*t*f2);
x3_t = 4*sin(2*pi*t*f3);
s_t = x1_t + x2_t + x3_t;
S_f = fft(s_t)/length(s_t);
S_f_shift = fftshift(S_f);

figure(1)
subplot(511)
plot(t, x1_t)
xlim([0 3/f1])
ylim([-6 6])
title('Sinal 1 - 6*sin(2*pi*t*1000)')
xlabel('Tempo [s]')
ylabel('Amplitude [V]')

subplot(512)
plot(t, x2_t)
xlim([0 3/f1])
title('Sinal 2 - 2*sin(2*pi*t*3000)')
xlabel('Tempo [s]')
ylabel('Amplitude [V]')

subplot(513)
plot(t, x3_t)
xlim([0 3/f1])
title('Sinal 3 - 4*sin(2*pi*t*5000)')
xlabel('Tempo [s]')
ylabel('Amplitude [V]')

subplot(514)
plot(t, s_t)
xlim([0 3/f1])
title('Sinal S - Soma dos sinais anteriores')
xlabel('Tempo [s]')
ylabel('Amplitude [V]')

subplot(515)
plot(f, abs(S_f_shift)); xlim([-6e3 6e3])
title('Sinal S - Soma dos sinais anteriores')
xlabel('Frequência [Hz]')
ylabel('Amplitude [V]')

% Calculo da norma (media do vetor)
% Do ponto de vista geometrico, a norma ao quadrado representa energia do 
% sinal, que dividido pelo tempo, tempos potencia.
(norm(s_t)^2)/length(s_t)

figure(2)
pwelch(s_t, [], [], [], fa)

% outro exercicio:
% filtro_pb = [zeros(1, 9500) ones(1, 1001) zeros(1, 9500)];
% sinal_out = abs(X_f_shift).*filtro_pb;
