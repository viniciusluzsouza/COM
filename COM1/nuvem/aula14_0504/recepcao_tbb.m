clear all
close all
clc

M = 2; % numero de simbolos da transmissao 
N = 500; % fator de superamostragem
% A = 5; % amplitude pulso
var_n = 1; % variancia
Rb = 10; % taxa de bits por segundo
passo_t = 1/(N*Rb);
filtro_nrz = ones(1, N); % filtro NRZ
limiar_nrz = 0;

info = randi([0 M-1], 1, 10000);
% super amostragem usada pra simular o sinal transmitido (continuo)
info_up = upsample(info, N);
t = [0:passo_t:(length(info)/Rb) - passo_t];


A_ind = 0;
for A = 0.5:0.2:5
    A_ind = A_ind + 1;
    tx = filter(filtro_nrz, 1, info_up)*(2*A)-A; % *(2*A)-A pra ficar entre -A e +A
    ruido = sqrt(var_n)*randn(1, length(tx)); % ruido para cada amostra
    rx = tx + ruido;

    % t_rec = ones(1, Rb);
    % t_rec_s = upsample(t_rec, N, (N/2)-1);
    % z_t = rx.*t_rec_s;
    z_T = rx(N/2:N:end);
    info_hat = z_T > limiar_nrz;
    num_erro = sum(xor(info, info_hat)); % comparando os erros de bit
    taxa_erro(A_ind) = num_erro/length(info);
end
A_vec = ([1:A_ind]*5)/A_ind;
semilogy(A_vec, taxa_erro)



% figure(1)
% subplot(211)
% plot(t, tx)
% ylim([-1.2*A 1.2*A])
% subplot(212)
% plot(t, rx)