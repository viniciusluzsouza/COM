clear all
close all
clc

M = 2; % numero de simbolos da transmissao 
N = 1000; % fator de superamostragem
A = 3; % amplitude pulso
var_n = 0.1; % variancia
Rb = 1000; % taxa de bits por segundo
passo_t = 1/(N*Rb);
filtro_nrz = ones(1, N); % filtro NRZ

info = randi([0 M-1], 1, 10);
% super amostragem usada pra simular o sinal transmitido (continuo)
info_up = upsample(info, N); 
tx = filter(filtro_nrz, 1, info_up)*(2*A)-A; % *(2*A)-A pra ficar entre -A e +A
t = [0:passo_t:(length(info)/Rb) - passo_t];

% no ruido, multiplicar pelo desvio padrao muda a variancia
ruido = sqrt(var_n)*randn(1, length(tx)); % ruido para cada amostra
rx = tx + ruido;

figure(1)
subplot(211)
plot(t, tx)
ylim([-1.2*A 1.2*A])
subplot(212)
plot(t, rx)