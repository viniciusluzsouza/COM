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
m = 0.5; % Fator de modulacao
Ao = Am/m;

% • Realizar um processo de modulação AM DSB e AM DSB-SC
c_t = Ac*cos(2*pi*fc*t);
m_t = Am*sin(2*pi*fm*t);
s_t_dsb_sc = c_t.*m_t; % sinal modulado em dsb sc


% • Para o caso da modulação AM DSB-SC, realizar o processo
% de demodulação utilizando a função 'fir1'
r_t_dsb_sc = s_t_dsb_sc.*c_t; % sinal demodulado
filtro_PB = fir1(n, (f_cut*2)/fa)';
info_dsb_sc = filter(filtro_PB, 1, r_t_dsb_sc);

% Plots para DSB SC
figure(1)
subplot(511)
plot(t, m_t)
title('Sinal de Informação - m(t)=sin(2*pi*1000*t)')
xlabel('Tempo [s]')
ylabel('Amplitude [V]')

subplot(512)
plot(t, c_t)
title('Portadora - c(t)=cos(2*pi*50000*t)')
xlabel('Tempo [s]')
ylabel('Amplitude [V]')

subplot(513)
plot(t, s_t_dsb_sc)
title('Sinal Modulado - s(t)')
xlabel('Tempo [s]')
ylabel('Amplitude [V]')

subplot(514)
plot(t, r_t_dsb_sc)
title('Sinal Demodulado - r(t)')
xlabel('Tempo [s]')
ylabel('Amplitude [V]')

subplot(515)
plot(t, info_dsb_sc);
title('Sinal Demodulado e filtrado (informação)')
xlabel('Tempo [s]')
ylabel('Amplitude [V]')


% • Para o caso da modulaçao AM DSB, variar o 'fator de
% modulação' (0.25; 0.5; 0.75 e 1 e 1.5) e observar os efeitos no
% sinal modulado
figure(2)
m = 0.25; Ao = Am/m
s_t_dsb = (m_t + Ao).*c_t; % sinal modulado em dsb
subplot(511)
plot(t, s_t_dsb)
title(['Sinal Modulado - m=0.25 A0=', num2str(Ao)])
xlabel('Tempo [s]')
ylabel('Amplitude [V]')

m = 0.5; Ao = Am/m
s_t_dsb = (m_t + Ao).*c_t;
subplot(512)
plot(t, s_t_dsb)
title(['Sinal Modulado - m=0.5 A0=', num2str(Ao)])
xlabel('Tempo [s]')
ylabel('Amplitude [V]')

m = 0.75; Ao = Am/m
s_t_dsb = (m_t + Ao).*c_t;
subplot(513)
plot(t, s_t_dsb)
title(['Sinal Modulado - m=0.75 A0=', num2str(Ao)])
xlabel('Tempo [s]')
ylabel('Amplitude [V]')

m = 1; Ao = Am/m
s_t_dsb = (m_t + Ao).*c_t;
subplot(514)
plot(t, s_t_dsb)
title(['Sinal Modulado - m=1 A0=', num2str(Ao)])
xlabel('Tempo [s]')
ylabel('Amplitude [V]')

m = 1.5; Ao = Am/m
s_t_dsb = (m_t + Ao).*c_t;
subplot(515)
plot(t, s_t_dsb)
title(['Sinal Modulado - m=1.5 A0=', num2str(Ao)])
xlabel('Tempo [s]')
ylabel('Amplitude [V]')

% figure(3)
% subplot(211)
% plot(t, m_t)
% subplot(212)
% plot(t, c_t)
