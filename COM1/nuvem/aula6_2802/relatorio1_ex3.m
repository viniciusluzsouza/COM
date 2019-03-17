clear all;
close all;
clc;

% 1. Gerar um vetor representando um ru?do com distribui??o
% normal utilizando a fun??o 'randn' do matlab. Gere 1 segundo
% de ru?do considerando um tempo de amostragem de 1/10k.
fs = 10e3;
ts = 1/fs;
ruido = randn(1, 10000);

% 2. Plotar o histograma do ru?do para observar a distribui??o
% Gaussiana. Utilizar a fun??o 'histogram'
figure(1)
hist(ruido, 100)

% 3. Plotar o ru?do no dom?nio do tempo e da frequ?ncia
t = [0:ts:1-ts];
f = [-fs/2:1:(fs/2)-1];
figure(2)
subplot(211)
plot(t, ruido)
subplot(212)
fft_ruido = fftshift(fft(ruido)/length(ruido));
plot(f, abs(fft_ruido))

% 4. Utilizando a fun??o 'xcorr', plote a fun??o de autocorrela??o
% do ru?do.
xcorr(ruido);

% 5. Utilizando a fun??o 'filtro=fir1(50,(1000*2)/fs)', realize uma
% opera??o de filtragem passa baixa do ru?do. Para visualizar a
% resposta em frequ?ncia do filtro projetado, utilize a fun??o
% 'freqz'.


% 6. Plote, no dom?nio do tempo e da frequ?ncia, a sa?da do filtro
% e o histograma do sinal filtrado

