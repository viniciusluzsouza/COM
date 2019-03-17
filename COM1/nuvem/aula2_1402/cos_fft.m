clear all;
clc;
close all;

A = 10;
fa = 20e3;
f1 = 1e3;
t = [0:1/fa:10*(1/f1)]
f = [-fa/2:100:fa/2];
f_aux = [0:100:fa];

x_t = cos(2*pi*t*f1);
X_f = fft(x_t)/length(x_t);
X_f_shift = fftshift(X_f);

figure(1)
subplot(311)
plot(t, x_t)
subplot(312)
plot(f_aux, abs(X_f))
subplot(313)
plot(f, abs(X_f_shift))