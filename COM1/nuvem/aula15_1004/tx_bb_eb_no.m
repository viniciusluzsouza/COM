% clear all
% close all
% clc

M = 2; % numero de simbolos da transmissao 
N = 500; % fator de superamostragem
A = 1; % amplitude pulso
Eb = 1; % Energia bit
Rb = 10; % taxa de bits por segundo
passo_t = 1/(N*Rb);
filtro_nrz = ones(1, N); % filtro NRZ
limiar_nrz = 0;

info = randi([0 M-1], 1, 10000);
% super amostragem usada pra simular o sinal transmitido (continuo)
info_up = upsample(info, N);
t = [0:passo_t:(length(info)/Rb) - passo_t];

for Eb_No_dB = 0:10
    No = Eb/(10^(Eb_No_dB/10));
    ruido = sqrt(No/2)*randn(1, length(info_up)); % ruido para cada amostra
    tx = filter(filtro_nrz, 1, info_up)*(2*A)-A; % *(2*A)-A pra ficar entre -A e +A
    rx = tx + ruido;

    % t_rec = ones(1, Rb);
    % t_rec_s = upsample(t_rec, N, (N/2)-1);
    % z_t = rx.*t_rec_s;
    z_T = rx(N/2:N:end);
    info_hat = z_T > limiar_nrz;
    num_erro = sum(xor(info, info_hat)); % comparando os erros de bit
    taxa_erro(Eb_No_dB + 1) = num_erro/length(info);
end
Eb_No_vec = [0:10];
semilogy(Eb_No_vec, taxa_erro)
xlabel('Eb/No [dB]')
ylabel('BER')
title('Desempenho da sinalizacao NRZ')
hold on