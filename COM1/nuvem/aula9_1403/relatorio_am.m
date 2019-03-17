clear all
close all
clc

Ai = 1;
fm = 1e3;
fc = 50e3;
Ac = 1;
A0 = 5;
m = Ai/A0;
fa = 20*fc;
t = [0:1/fa:1];
f = [-fa/2:1:fa/2];

m_t = Ai*cos(2*pi*fm*t);
c_t = Ac*cos(2*pi*fc*t);
s_t_sc = c_t.*m_t; % sinal modulado em AM DSC SC
s_t = A0*(1 + m.*cos(2*pi*fc*t))*Ac.*cos(2*pi*fc*t);

figure(1)
subplot(211)
plot(t, s_t_sc)
xlim([0 4/500])
subplot(212)
plot(t, s_t)
xlim([0 4/500])

figure(2)
subplot(411)
fft_m_t = fftshift(fft(m_t)/length(m_t));
plot(f, abs(fft_m_t))
subplot(412)
fft_c_t = fftshift(fft(c_t)/length(c_t));
plot(f, abs(fft_c_t))
subplot(413)
fft_s_t_sc = fftshift(fft(s_t_sc)/length(s_t_sc));
plot(f, abs(fft_s_t_sc))
xlim([-4*fc 4*fc])
subplot(414)
fft_s_t = fftshift(fft(s_t)/length(s_t));
plot(f, abs(fft_s_t))