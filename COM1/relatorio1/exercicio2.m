clear all;
clc;
close all;

fa = 100e3;
f1 = 1e3;
f2 = 3*f1;
f3 = 5*f1;
t = [0:1/fa:5*(1/1e3)];
f = [-fa/2:200:fa/2];

% 1. Gerar um sinal s(t) composto pela somatória de 3 senos com amplitudes
% de 5V, 5/3V e 1V e frequências de 1, 3 e 5 kHz, respectivamente.
x1_t = 5*sin(2*pi*t*f1);
x2_t = 5/3*sin(2*pi*t*f2);
x3_t = sin(2*pi*t*f3);
s_t = x1_t + x2_t + x3_t;

% 2. Plotar em uma figura os três cossenos e o sinal 's ' no domínio do tempo e
% da frequência
S_f = fft(s_t)/length(s_t);
S_f_shift = fftshift(S_f);

figure(1)
subplot(511)
plot(t, x1_t)
xlim([0 3/f1])
title('Sinal 1 - 5*sin(2*pi*t*1000)')
xlabel('Tempo [s]')
ylabel('Amplitude [V]')

subplot(512)
plot(t, x2_t)
xlim([0 3/f1])
title('Sinal 2 - 5/3*sin(2*pi*t*3000)')
xlabel('Tempo [s]')
ylabel('Amplitude [V]')

subplot(513)
plot(t, x3_t)
xlim([0 3/f1])
title('Sinal 3 - sin(2*pi*t*5000)')
xlabel('Tempo [s]')
ylabel('Amplitude [V]')

subplot(514)
plot(t, s_t)
xlim([0 3/f1])
title('Sinal S - Soma dos sinais anteriores')
xlabel('Tempo [s]')
ylabel('Amplitude [V]')

subplot(515)
plot(f, abs(S_f_shift))
xlim([-6e3 6e3])
title('Sinal S - Soma dos sinais anteriores')
xlabel('Frequência [Hz]')
ylabel('Amplitude [V]')

% 3. Gerar 3 filtros ideais:
% • Passa baixa (frequência de corte em 2kHz)
% • Passa alta (banda de passagem acima de 4kHz)
% • Passa faixa (banda de passagem entre 2 e 4kHz)
% filtro_pb = [zeros(1, 241) ones(1, 20) zeros(1, 240)];
% filtro_pa = [zeros(1, 271) ones(1, 230)];
% filtro_pf = [zeros(1, 261) ones(1, 10) zeros(1, 230)];
filtro_pb = [zeros(1, 241) ones(1, 20) zeros(1, 240)];
filtro_pa = [ones(1, 230) zeros(1, 41) ones(1, 230)];
filtro_pf = [zeros(1, 231) ones(1, 10) zeros(1, 20) ones(1, 10) zeros(1, 230)];


% 4. Plotar em uma figura a resposta em frequência dos 3 filtros
figure(2)
subplot(311)
plot(f, filtro_pb)
xlim([-6e3 6e3])
title('Filtro Passa Baixa - 2 kHz')
xlabel('Frequência [Hz]')
ylabel('Amplitude [V]')

subplot(312)
plot(f, filtro_pa)
xlim([-6e3 6e3])
title('Filtro Passa Alta - 4 kHz')
xlabel('Frequência [Hz]')
ylabel('Amplitude [V]')

subplot(313)
plot(f, filtro_pf)
xlim([-6e3 6e3])
title('Filtro Passa Faixa - 2 kHz a 4 kHz')
xlabel('Frequência [Hz]')
ylabel('Amplitude [V]')

% 5. Passar o sinal s(t) através dos 3 filtros e plotar as saídas, no domínio do
% tempo e da frequência, para os 3 casos
y_pb_f = abs(S_f_shift).*filtro_pb;
y_pa_f = abs(S_f_shift).*filtro_pa;
y_pf_f = abs(S_f_shift).*filtro_pf;

figure(3)
subplot(311)
plot(f, y_pb_f)
xlim([-6e3 6e3])
title('Sinal s filtrado com filtro PB')
xlabel('Frequência [Hz]')
ylabel('Amplitude [V]')

subplot(312)
plot(f, y_pa_f)
xlim([-6e3 6e3])
title('Sinal s filtrado com filtro PA')
xlabel('Frequência [Hz]')
ylabel('Amplitude [V]')

subplot(313)
plot(f, y_pf_f)
xlim([-6e3 6e3])
title('Sinal s filtrado com filtro PF')
xlabel('Frequência [Hz]')
ylabel('Amplitude [V]')

y_pb_t = ifft(ifftshift(y_pb_f));
y_pa_t = ifft(ifftshift(y_pa_f));
y_pf_t = ifft(ifftshift(y_pf_f));
figure(4)
subplot(311)
plot(t, y_pb_t)
title('Sinal s filtrado com filtro PB')
xlabel('Tempo (s)')
ylabel('Amplitude [V]')

subplot(312)
plot(t, y_pa_t)
title('Sinal s filtrado com filtro PB')
xlabel('Tempo (s)')
ylabel('Amplitude [V]')

subplot(313)
plot(t, y_pf_t)
title('Sinal s filtrado com filtro PB')
xlabel('Tempo (s)')
ylabel('Amplitude [V]')