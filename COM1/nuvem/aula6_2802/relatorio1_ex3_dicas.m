% Exercicio 3 (dicas)

clear all;
close all;
clc;

fs = 100e3; % frequencia de amostragem
ts = 1/fs; % tempo de amostragem
fc1 = 5e3; % frequencia de corte filtro 1
fc2 = 10e3; % frequencia de corte filtro 2
n = 100; % ordem dos filtros
t = [0:ts:1-ts];

filtro1 = fir1(n, (fc1*2)/fs)';
figure(1)
freqz(filtro1)

filtro2 = fir1(n, (fc2*2)/fs)';
figure(2)
freqz(filtro2)

ruido = randn(1, 100000);
figure(3)
hist(ruido, 100)

y_1 = conv(ruido, filtro1);
y_2 = conv(ruido, filtro2);
figure(4)
subplot(311)
hist(ruido, 100)
xlim([-6 6])
subplot(312)
hist(y_1, 100)
xlim([-6 6])
subplot(313)
hist(y_2, 100)
xlim([-6 6])

figure(5)
subplot(311)
plot(t, ruido)
ylim([-5 5])
subplot(312)
plot(t, y_1(1:end-100))
ylim([-5 5])
subplot(313)
plot(t, y_2(1:end-100))
ylim([-5 5])