clear all
close all
clc

fa = 44100;
fm = 1e3;
Vpp = 2; % escala de tensao
k = 3; % quantidade de bits do quantizador

[y_in,Fs_in] = audioread('cartoon-birds-2.wav');
passo_q = Vpp/(2^k); % passo de quantizacao
end_t = (length(y_in)/Fs_in-(1/Fs_in)); % passo de quantizacao
t = [0:1/Fs_in:end_t];

x_n = y_in; % amostras do seno
x_quant_1 = x_n + ((Vpp/2)-(passo_q/2)); % deslocamento pra cima
x_quant_2 = x_quant_1/passo_q; % joga pro nivel de tensao
x_quant_3 = round(x_quant_2); % arredonda
aux1 = x_quant_3 == 2^k; % gera vetor de "bool" pra 8
aux2 = x_quant_3 == -1; % gera vetor de "bool" pra -1
x_quant_4 = x_quant_3 - aux1; % ajusta max ate 2^k-1
x_quant = x_quant_4 + aux2; % ajusta min em 0

x_bin_1 = de2bi(x_quant);
[linha, coluna] = size(x_bin_1);
x_bin = reshape(transpose(x_bin_1), 1, linha*coluna);

% voltando ...
x_dec_1 = reshape(x_bin, coluna, linha);
x_dec_2 = transpose(x_dec_1);
x_dec = transpose(bi2de(x_dec_2));
x_n_rec_1 = x_dec * passo_q;
x_n_rec = x_n_rec_1 - ((Vpp/2)-(passo_q/2));

figure(1)
subplot(211)
plot(t, x_n)
subplot(212)
plot(t, x_n_rec)




% para o relatorio, entregar com filtro pb
