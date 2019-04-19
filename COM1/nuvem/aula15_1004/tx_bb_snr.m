clear all
close all
clc

M = 2; % numero de simbolos da transmissao 
N = 100; % fator de superamostragem
A = 1; % amplitude pulso
Rb = 1000; % taxa de bits por segundo
passo_t = 1/(N*Rb);
Fs = N*Rb;
N_ordem = 50;
f_cut = 1.5e3;
filtro_nrz = ones(1, N); % filtro NRZ
limiar_nrz = 0;

info = randi([0 M-1], 1, 10000);
% super amostragem usada pra simular o sinal transmitido (continuo)
info_up = upsample(info, N);
t = [0:passo_t:(length(info)/Rb) - passo_t];
filtro_PB = fir1(N_ordem, (f_cut*2)/Fs);

for SNR = 0:5
    tx = filter(filtro_nrz, 1, info_up)*(2*A)-A; % *(2*A)-A pra ficar entre -A e +A
    rx = awgn(tx, SNR);
    
    rx_filtrado = filter(filtro_PB, 1, rx);
    % t_rec = ones(1, Rb);
    % t_rec_s = upsample(t_rec, N, (N/2)-1);
    % z_t = rx.*t_rec_s;
    z_T = rx_filtrado(N/2+(N_ordem/2):N:end);
    info_hat = z_T > limiar_nrz;
    num_erro = sum(xor(info, info_hat)); % comparando os erros de bit
    taxa_erro(SNR + 1) = num_erro/length(info);
end
SNR_vec = [0:5];
semilogy(SNR_vec, taxa_erro)
xlabel('SNR [dB]')
ylabel('BER')
title('Desempenho da sinalizacao NRZ')
hold on

figure(2)
subplot(211)
plot(t, rx)
xlim([0 10/Rb])
subplot(212)
plot(t, rx_filtrado)
xlim([0 10/Rb])
taxa_erro(6)