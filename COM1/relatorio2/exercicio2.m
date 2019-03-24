close all;
clear all;
clc;

Am = 1; % Amplitude sinal
fm = 1e3; % Frequencia do sinal
fa = 50e3; % Frequencia de amostragem
t = [0:1/fa:10*(1/fm)];
f = [-fa/2:100:fa/2];
f_cut = 500; % Frequencia de corte - 500 Hz

% • Gerar 3 sinais (cosenos) nas frequências 1k, 2k e 3k
m1_t = Am*cos(2*pi*fm*t);
m2_t = Am*cos(2*pi*fm*2*t);
m3_t = Am*cos(2*pi*fm*3*t);

% • Realizar a multiplexação dos sinais para as frequências 10k,
% 12k e 14k para a transmissão em um canal de comunicação
m1_t_multiplex = m1_t.*cos(2*pi*9e3*t);
m2_t_multiplex = m2_t.*cos(2*pi*10e3*t);
m3_t_multiplex = m3_t.*cos(2*pi*11e3*t);
m_t_somado = m1_t_multiplex + m2_t_multiplex + m3_t_multiplex;
M_f_somado = fftshift(fft(m_t_somado)/length(m_t_somado));
filtro_PA = [zeros(1, 341) ones(1, 160)];

S_f = M_f_somado.*filtro_PA;
s_t = ifft(ifftshift(S_f));

% • Recuperar os sinais originais
r1_t = s_t.*cos(2*pi*9e3*t);
r2_t = s_t.*cos(2*pi*10e3*t);
r3_t = s_t.*cos(2*pi*11e3*t);
R1_f = fftshift(fft(r1_t)/length(r1_t));
R2_f = fftshift(fft(r2_t)/length(r2_t));
R3_f = fftshift(fft(r3_t)/length(r3_t));
filtro_pb_1k = [zeros(1, 251) ones(1, 19) zeros(1, 231)];
filtro_pf_1a3k = [zeros(1, 261) ones(1, 19) zeros(1, 221)];
filtro_pf_2a4k = [zeros(1, 271) ones(1, 19) zeros(1, 211)];

rec1_f = R1_f.*filtro_pb_1k;
rec2_f = R2_f.*filtro_pf_1a3k;
rec3_f = R3_f.*filtro_pf_2a4k;
rec1_t = ifft(ifftshift(rec1_f));
rec2_t = ifft(ifftshift(rec2_f));
rec3_t = ifft(ifftshift(rec3_f));

% Plots
M1_f = fftshift(fft(m1_t)/length(m1_t));
M2_f = fftshift(fft(m2_t)/length(m2_t));
M3_f = fftshift(fft(m3_t)/length(m3_t));

m1_f_multiplex = fftshift(fft(m1_t_multiplex)/length(m1_t_multiplex));
m2_f_multiplex = fftshift(fft(m2_t_multiplex)/length(m2_t_multiplex));
m3_f_multiplex = fftshift(fft(m3_t_multiplex)/length(m3_t_multiplex));

figure(1)
subplot(3,2,1)
plot(t, m1_t)
title('cos(2*pi*1000*t)')
xlabel('Tempo [s]')
ylabel('Amplitude [V]')
subplot(3,2,2)
plot(f, abs(M1_f))
xlim([-4*fm 4*fm])
title('cos(2*pi*1000*t)')
xlabel('Frequência [Hz]')
ylabel('Amplitude [V]')

subplot(3,2,3)
plot(t, m2_t)
title('cos(2*pi*2000*t)')
xlabel('Tempo [s]')
ylabel('Amplitude [V]')
subplot(3,2,4)
plot(f, abs(M2_f))
xlim([-4*fm 4*fm])
title('cos(2*pi*2000*t)')
xlabel('Frequência [Hz]')
ylabel('Amplitude [V]')

subplot(3,2,5)
plot(t, m3_t)
title('cos(2*pi*3000*t)')
xlabel('Tempo [s]')
ylabel('Amplitude [V]')
subplot(3,2,6)
plot(f, abs(M3_f))
xlim([-4*fm 4*fm])
title('cos(2*pi*3000*t)')
xlabel('Frequência [Hz]')
ylabel('Amplitude [V]')

figure(2)
subplot(311)
plot(f, abs(m1_f_multiplex))
title('cos(2*pi*1000*t)*cos(2*pi*9000*t)')
xlabel('Frequência [Hz]')
ylabel('Amplitude [V]')
subplot(312)
plot(f, abs(m2_f_multiplex))
title('cos(2*pi*2000*t)*cos(2*pi*10000*t)')
xlabel('Frequência [Hz]')
ylabel('Amplitude [V]')
subplot(313)
plot(f, abs(m3_f_multiplex))
title('cos(2*pi*3000*t)*cos(2*pi*11000*t)')
xlabel('Frequência [Hz]')
ylabel('Amplitude [V]')

figure(3)
subplot(311)
plot(f, abs(M_f_somado))
title('Sinais multiplexados')
xlabel('Frequência [Hz]')
ylabel('Amplitude [V]')
subplot(312)
plot(f, filtro_PA)
title('Filtro PA 9 KHz (ideal)')
xlabel('Frequência [Hz]')
ylabel('Amplitude [V]')
subplot(313)
plot(f, abs(S_f))
title('Sinal transmitido S(f)')
xlabel('Frequência [Hz]')
ylabel('Amplitude [V]')

figure(4)
subplot(3,2,1)
plot(f, abs(R1_f))
title('S(f)*cos(2*pi*9000*t)')
xlabel('Frequência [Hz]')
ylabel('Amplitude [V]')
subplot(3,2,2)
plot(f, abs(filtro_pb_1k))
title('Filtro PB 1 KHz (ideal)')
xlabel('Frequência [Hz]')
ylabel('Amplitude [V]')

subplot(3,2,3)
plot(f, abs(R2_f))
title('S(f)*cos(2*pi*10000*t)')
xlabel('Frequência [Hz]')
ylabel('Amplitude [V]')
subplot(3,2,4)
plot(f, abs(filtro_pf_1a3k))
title('Filtro PF 1 a 3 KHz (ideal)')
xlabel('Frequência [Hz]')
ylabel('Amplitude [V]')

subplot(3,2,5)
plot(f, abs(R3_f))
title('S(f)*cos(2*pi*1000*t)')
xlabel('Frequência [Hz]')
ylabel('Amplitude [V]')
subplot(3,2,6)
plot(f, abs(filtro_pf_2a4k))
title('Filtro PF 2 a 4 KHz (ideal)')
xlabel('Frequência [Hz]')
ylabel('Amplitude [V]')


figure(5)
subplot(3,2,1)
plot(t, rec1_t)
title('Sinal demodulado - cos(2*pi*1000*t)')
xlabel('Tempo [s]')
ylabel('Amplitude [V]')
subplot(3,2,2)
plot(f, abs(rec1_f))
title('Sinal demodulado - cos(2*pi*1000*t)')
xlabel('Frequência [Hz]')
ylabel('Amplitude [V]')

subplot(3,2,3)
plot(t, rec2_t)
title('Sinal demodulado - cos(2*pi*2000*t)')
xlabel('Tempo [s]')
ylabel('Amplitude [V]')
subplot(3,2,4)
plot(f, abs(rec2_f))
title('Sinal demodulado - cos(2*pi*2000*t)')
xlabel('Frequência [Hz]')
ylabel('Amplitude [V]')


subplot(3,2,5)
plot(t, rec3_t)
title('Sinal demodulado - cos(2*pi*3000*t)')
xlabel('Tempo [s]')
ylabel('Amplitude [V]')
subplot(3,2,6)
plot(f, abs(rec3_f))
title('Sinal demodulado - cos(2*pi*3000*t)')
xlabel('Frequência [Hz]')
ylabel('Amplitude [V]')

% teste_t = cos(2*pi*10e3*t) + cos(2*pi*12e3*t) + cos(2*pi*14e3*t);
% teste_f = fftshift(fft(teste_t)/length(teste_t));
% filtro_teste = [zeros(1, 250) ones(1, 251)];
% teste_f = teste_f.*filtro_teste;
% teste_t = ifft(ifftshift(teste_f));
% 
% saida = cos(2*pi*9e3*t).*teste_t;
% saida_f = fftshift(fft(saida)/length(saida));
% 
% figure(5)
% plot(f, abs(saida_f))