%clear all
close all
clc

figure(1)
%criando a informa??o
subplot(421)
info = [0 1 1 0 1];
stem(info); ylim([0 6]);

subplot(422)
%multiplicando o sinal por 5, para que fique entre 0 e 5V
info_1 = info*5
stem(info_1);ylim([0 6]);

subplot(412)
%fun??o do matlab usada para superamostrar o sinal, insere amostras nulas
%entre as amostras, nesse caso acrescenta 999 amostras
info_up = upsample(info,1000);
stem(info_up);ylim([0 2]);

%cria um filtro na m?o com a mesma dimens?o da superamostragem
subplot(413)
filtro_NRZ = ones(1,1000);
stem(filtro_NRZ);ylim([0 2]);

%fazendo o uso do plot que interliga as amostras, temos a onda quadrada no tempo
subplot(414)
info_NRZ = filter(filtro_NRZ,1,info_up);
%stem(info_NRZ)
plot(info_NRZ);ylim([0 2]);