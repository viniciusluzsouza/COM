clear all
close all
clc

n = 100;
Ac = 1;
Am = 1;
fc = 100e3;
fm = 1e3;
f_cut = 2e3;
fa = 20*fc;
t = [0:1/fa:1];

c_t = Ac*cos(2*pi*fc*t);
m_t = Am*cos(2*pi*fm*t);
s_t = c_t.*m_t; % sinal modulado
r_t = s_t.*c_t; % sinal demodulado
filtro_PB = fir1(n, (f_cut*2)/fa)';
info = filter(filtro_PB, 1, r_t);

figure(1)
subplot(511)
plot(t, m_t)
xlim([0 2/fm])
subplot(512)
plot(t, c_t)
xlim([0 2/fm])
subplot(513)
plot(t, s_t)
xlim([0 2/fm])
subplot(514)
plot(t, r_t)
xlim([0 2/fm])
subplot(515)
plot(t, info)
xlim([0 2/fm])

