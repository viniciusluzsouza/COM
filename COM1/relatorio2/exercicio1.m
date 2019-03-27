close all;
clear all;
clc;

Ac = 1; % Amplitude portadora
Am = 1; % Amplitude sinal
fc = 20e3; % Frequencia da portadora
fm = 1e3; % Frequencia do sinal
fa = 20*fc; % Frequencia de amostragem
f_cut = 4e3; % Frequencia de corte filtro fir1
n = 100; % Ordem do filtro fir1
t = [0:1/fa:0.005];
f = [-fa/2:200:fa/2];
m = 0.5; % Fator de modulacao
Ao = Am/m;

% • Realizar um processo de modulação AM DSB e AM DSB-SC
c_t = Ac*cos(2*pi*fc*t);
m_t = Am*sin(2*pi*fm*t);
s_t_dsb_sc = c_t.*m_t; % sinal modulado em dsb sc

m_f = fftshift(fft(m_t)/length(m_t));
c_f = fftshift(fft(c_t)/length(c_t));
s_f_dsb_sc = fftshift(fft(s_t_dsb_sc)/length(s_t_dsb_sc));

% • Para o caso da modulação AM DSB-SC, realizar o processo
% de demodulação utilizando a função 'fir1'
r_t_dsb_sc = s_t_dsb_sc.*c_t; % sinal demodulado
filtro_PB = fir1(n, (f_cut*2)/fa)';
info_dsb_sc = filter(filtro_PB, 1, r_t_dsb_sc);

r_f_dsb_sc = fftshift(fft(r_t_dsb_sc)/length(r_t_dsb_sc));
info_dsb_sc_f = fftshift(fft(info_dsb_sc)/length(info_dsb_sc));

% Plots para DSB SC
figure(1)
subplot(511)
plot(t, m_t)
xlim([0 3/fm])
title('Sinal de Informação - m(t)=sin(2*pi*1000*t)')
xlabel('Tempo [s]')
ylabel('Amplitude [V]')

subplot(512)
plot(t, c_t)
xlim([0 3/fm])
title('Portadora - c(t)=cos(2*pi*20000*t)')
xlabel('Tempo [s]')
ylabel('Amplitude [V]')

subplot(513)
plot(t, s_t_dsb_sc)
xlim([0 3/fm])
title('Sinal Modulado - s(t)')
xlabel('Tempo [s]')
ylabel('Amplitude [V]')

subplot(514)
plot(t, r_t_dsb_sc)
xlim([0 3/fm])
title('Sinal Demodulado - r(t)')
xlabel('Tempo [s]')
ylabel('Amplitude [V]')

subplot(515)
plot(t, info_dsb_sc)
xlim([0 3/fm])
title('Sinal Demodulado e filtrado (informação)')
xlabel('Tempo [s]')
ylabel('Amplitude [V]')


figure(2)
subplot(511)
plot(f, abs(m_f))
xlim([-2.5*fc 2.5*fc])
title('Sinal de Informação - m(t)=sin(2*pi*1000*t)')
xlabel('Frequência [Hz]')
ylabel('Amplitude [V]')

subplot(512)
plot(f, abs(c_f))
xlim([-2.5*fc 2.5*fc])
title('Portadora - c(t)=cos(2*pi*20000*t)')
xlabel('Frequência [Hz]')
ylabel('Amplitude [V]')

subplot(513)
plot(f, abs(s_f_dsb_sc))
xlim([-2.5*fc 2.5*fc])
title('Sinal Modulado - s(t)')
xlabel('Frequência [Hz]')
ylabel('Amplitude [V]')

subplot(514)
plot(f, abs(r_f_dsb_sc))
xlim([-2.5*fc 2.5*fc])
title('Sinal Demodulado - r(t)')
xlabel('Frequência [Hz]')
ylabel('Amplitude [V]')

subplot(515)
plot(f, abs(info_dsb_sc_f))
xlim([-2.5*fc 2.5*fc])
title('Sinal Demodulado e filtrado (informação)')
xlabel('Frequência [Hz]')
ylabel('Amplitude [V]')

% • Para o caso da modulaçao AM DSB, variar o 'fator de
% modulação' (0.25; 0.5; 0.75 e 1 e 1.5) e observar os efeitos no
% sinal modulado
figure(3)
m = 0.25; Ao = Am/m;
s_t_dsb = (m_t + Ao).*c_t; % sinal modulado em dsb
s_f_dsb = fftshift(fft(s_t_dsb)/length(s_t_dsb));
subplot(5,2,1)
plot(t, s_t_dsb)
xlim([0 3/fm])
title(['Sinal Modulado - m=0.25 A0=', num2str(Ao)])
xlabel('Tempo [s]')
ylabel('Amplitude [V]')
subplot(5,2,2)
plot(f, abs(s_f_dsb))
xlim([-1.5*fc 1.5*fc])
title(['Sinal Modulado - m=0.25 A0=', num2str(Ao)])
xlabel('Frequência [Hz]')
ylabel('Amplitude [V]')


m = 0.5; Ao = Am/m;
s_t_dsb = (m_t + Ao).*c_t;
s_f_dsb = fftshift(fft(s_t_dsb)/length(s_t_dsb));
subplot(5,2,3)
plot(t, s_t_dsb)
xlim([0 3/fm])
title(['Sinal Modulado - m=0.5 A0=', num2str(Ao)])
xlabel('Tempo [s]')
ylabel('Amplitude [V]')
subplot(5,2,4)
plot(f, abs(s_f_dsb))
xlim([-1.5*fc 1.5*fc])
title(['Sinal Modulado - m=0.5 A0=', num2str(Ao)])
xlabel('Frequência [Hz]')
ylabel('Amplitude [V]')

m = 0.75; Ao = Am/m;
s_t_dsb = (m_t + Ao).*c_t;
s_f_dsb = fftshift(fft(s_t_dsb)/length(s_t_dsb));
subplot(5,2,5)
plot(t, s_t_dsb)
xlim([0 3/fm])
title(['Sinal Modulado - m=0.75 A0=', num2str(Ao)])
xlabel('Tempo [s]')
ylabel('Amplitude [V]')
subplot(5,2,6)
plot(f, abs(s_f_dsb))
xlim([-1.5*fc 1.5*fc])
title(['Sinal Modulado - m=0.75 A0=', num2str(Ao)])
xlabel('Frequência [Hz]')
ylabel('Amplitude [V]')

m = 1; Ao = Am/m;
s_t_dsb = (m_t + Ao).*c_t;
s_f_dsb = fftshift(fft(s_t_dsb)/length(s_t_dsb));
subplot(5,2,7)
plot(t, s_t_dsb)
xlim([0 3/fm])
title(['Sinal Modulado - m=1 A0=', num2str(Ao)])
xlabel('Tempo [s]')
ylabel('Amplitude [V]')
subplot(5,2,8)
plot(f, abs(s_f_dsb))
xlim([-1.5*fc 1.5*fc])
title(['Sinal Modulado - m=1 A0=', num2str(Ao)])
xlabel('Frequência [Hz]')
ylabel('Amplitude [V]')

m = 1.5; Ao = Am/m;
s_t_dsb = (m_t + Ao).*c_t;
s_f_dsb = fftshift(fft(s_t_dsb)/length(s_t_dsb));
subplot(5,2,9)
plot(t, s_t_dsb)
xlim([0 3/fm])
title(['Sinal Modulado - m=1.5 A0=', num2str(Ao)])
xlabel('Tempo [s]')
ylabel('Amplitude [V]')
subplot(5,2,10)
plot(f, abs(s_f_dsb))
xlim([-1.5*fc 1.5*fc])
title(['Sinal Modulado - m=1.5 A0=', num2str(Ao)])
xlabel('Frequência [Hz]')
ylabel('Amplitude [V]')
