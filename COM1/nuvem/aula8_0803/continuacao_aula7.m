clear all
close all
clc

n = 100;
Ac = 1;
Am = 1;
fc = 50e3;
fm = 1e3;
f_cut = 7e3;
fa = 20*fc;
t = [0:1/fa:1];

c_t = Ac*cos(2*pi*fc*t);
% m_t = Am*cos(2*pi*fm*t);
m_t = 5*sin(2*pi*500*t) + 5/3*sin(2*pi*1500*t) + sin(2*pi*2500*t) + 5/7*sin(2*pi*3500*t) + 5/9*sin(2*pi*4500*t) + 5/11*sin(2*pi*5500*t);
s_t = c_t.*m_t; % sinal modulado
r_t = s_t.*c_t; % sinal demodulado
filtro_PB = fir1(n, (f_cut*2)/fa)';
info = filter(filtro_PB, 1, r_t);

figure(1)
subplot(511)
plot(t, m_t)
xlim([0 4/500])
subplot(512)
plot(t, c_t)
xlim([0 4/500])
subplot(513)
plot(t, s_t)
xlim([0 4/500])
subplot(514)
plot(t, r_t)
xlim([0 4/500])
subplot(515)
plot(t, info)
xlim([0 4/500])

f = [-fa/2:1:fa/2];
figure(2)
subplot(511)
fft_m_t = fftshift(fft(m_t)/length(m_t));
plot(f, abs(fft_m_t))
xlim([-4*fc 4*fc])
subplot(512)
fft_c_t = fftshift(fft(c_t)/length(c_t));
plot(f, abs(fft_c_t))
xlim([-4*fc 4*fc])
subplot(513)
fft_s_t = fftshift(fft(s_t)/length(s_t));
plot(f, abs(fft_s_t))
xlim([-4*fc 4*fc])
subplot(514)
fft_r_t = fftshift(fft(r_t)/length(r_t));
plot(f, abs(fft_r_t))
xlim([-4*fc 4*fc])
subplot(515)
fft_info = fftshift(fft(info)/length(info));
plot(f, abs(fft_info))
xlim([-4*fc 4*fc])