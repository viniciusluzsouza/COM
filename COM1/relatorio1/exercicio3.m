clear all;
clc;
close all;

% 1. Gerar um vetor representando um ruído com distribuição
% normal utilizando a função 'randn' do matlab. Gere 1 segundo
% de ruído considerando um tempo de amostragem de 1/10k.
fs = 10e3;
ts = 1/fs;
ruido = randn(1, fs);


% 2. Plotar o histograma do ruído para observar a distribuição
% Gaussiana. Utilizar a função 'histogram'
figure(1)
subplot(311)
hist(ruido, 100)
xlim([-5 5])
title('Distribuição do ruído')
xlabel('n')
ylabel('R(n)')

% 3. Plotar o ruído no domínio do tempo e da frequência
t = [0:ts:1-ts];
f = [-fs/2:1:(fs/2)-1];
subplot(312)
plot(t, ruido)
title('Ruido no domínio do tempo')
xlabel('t [s]')
ylabel('R(s)')

subplot(313)
fft_ruido = fftshift(fft(ruido)/length(ruido));
plot(f, abs(fft_ruido))
title('Ruido no domínio da frequência')
xlabel('f [Hz]')
ylabel('R(s)')

% 4. Utilizando a função 'xcorr', plote a função de autocorrelação
% do ruído.
figure(2)
t_autocorr = [-1:ts:1-(2*ts)];
autocorr_ruido = xcorr(ruido);
plot(t_autocorr, autocorr_ruido)
title('Autocorrelação do ruido')


% 5. Utilizando a função 'filtro=fir1(50,(1000*2)/fs)', realize uma
% operação de filtragem passa baixa do ruído. Para visualizar a
% resposta em frequência do filtro projetado, utilize a função
% 'freqz'.
figure(3)
filtro = fir1(50,(1000*2)/fs);
freqz(filtro)

% 6. Plote, no domínio do tempo e da frequência, a saída do filtro
% e o histograma do sinal filtrado
y_t = conv(ruido, filtro);
y_f = fftshift(fft(y_t)/length(y_t));

figure(4)
subplot(311)
hist(y_t, 100)
xlim([-5 5])
title('Distribuição do ruído após filtragem')
xlabel('n')
ylabel('R(n)')

subplot(312)
plot(t, y_t(1:end-50))
title('Ruido no domínio do tempo após filtragem')
xlabel('t [s]')
ylabel('R(s)')

subplot(313)
plot(f, abs(y_f(1:end-50)))
xlim([-2e3 2e3])
title('Ruido no domínio da frequência após filtragem')
xlabel('f [Hz]')
ylabel('R(s)')

