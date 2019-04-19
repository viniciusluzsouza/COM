clear all
close all


[y_in,Fs_in] = audioread('cartoon-birds-2.wav');
deltaF = (length(y_in)/Fs_in-(1/Fs_in));
t = [0:1/Fs_in:deltaF];

plot(t,y_in')
Y = fft(y_in);

f = [-Fs_in/2:1/deltaF:Fs_in/2];

figure(2)
plot(f,transpose(abs(fftshift(Y))));