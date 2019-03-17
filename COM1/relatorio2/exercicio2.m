close all;
clear all;
clc;

Am = 1; % Amplitude sinal
fm = 1e3; % Frequencia do sinal
fa = 1000e3; % Frequencia de amostragem
t = [0:1/fa:10*(1/fm)];
f = [-fa/2:100:fa/2];
f_cut = 500; % Frequencia de corte - 500 Hz

% • Gerar 3 sinais (cosenos) nas frequências 1k, 2k e 3k
m1_t = Am*cos(2*pi*fm*t);
m2_t = Am*cos(2*pi*fm*2*t);
m3_t = Am*cos(2*pi*fm*3*t);

% • Realizar a multiplexação dos sinais para as frequências 10k,
% 12k e 14k para a transmissão em um canal de comunicação
m_t = m1_t.*cos(2*pi*10e3*t) + m2_t.*cos(2*pi*12e3*t) + m3_t.*cos(2*pi*14e3*t);

% • Recuperar os sinais originais
b1_t = m_t.*cos(2*pi*9e3*t);
b2_t = m_t.*cos(2*pi*14e3*t);
b3_t = m_t.*cos(2*pi*17e3*t);
filtro_PB = fir1(100, 0.00001);
r1_t = filter(filtro_PB, 1, b1_t);
r2_t = filter(filtro_PB, 1, b2_t);
r3_t = filter(filtro_PB, 1, b3_t);


% Plots
M1_f = fftshift(fft(m1_t)/length(m1_t));
M2_f = fftshift(fft(m2_t)/length(m2_t));
M3_f = fftshift(fft(m3_t)/length(m3_t));
M_f = fftshift(fft(m_t)/length(m_t));

B1_f = fftshift(fft(b1_t)/length(b1_t));
B2_f = fftshift(fft(b2_t)/length(b2_t));
B3_f = fftshift(fft(b3_t)/length(b3_t));

R1_f = fftshift(fft(r1_t)/length(r1_t));
R2_f = fftshift(fft(r2_t)/length(r2_t));
R3_f = fftshift(fft(r3_t)/length(r3_t));

figure(1)
subplot(411)
plot(f, abs(M1_f))
xlim([0 4*fm])
subplot(412)
plot(f, abs(M2_f))
xlim([0 4*fm])
subplot(413)
plot(f, abs(M3_f))
xlim([0 4*fm])
subplot(414)
plot(f, abs(M_f))
xlim([0 20*fm])

figure(2)
subplot(311)
plot(f, abs(B1_f))
xlim([-10*fm 10*fm])
subplot(312)
plot(f, abs(B2_f))
xlim([-10*fm 10*fm])
subplot(313)
plot(f, abs(B3_f))
xlim([-10*fm 10*fm])


figure(3)
subplot(311)
plot(t, r1_t)
subplot(312)
plot(f, abs(R1_f))
xlim([-10*fm 10*fm])
% subplot(312)
% plot(f, abs(R2_f))
% xlim([-10*fm 10*fm])
% subplot(313)
% plot(f, abs(R3_f))
% xlim([-10*fm 10*fm])


figure(4)
freqz(filtro_PB)