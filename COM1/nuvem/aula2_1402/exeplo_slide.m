clear all;
clc;
close all;

fa = 100e3;
f1 = 100;

t = [0:1/fa:100*(1/1e3)]
f = [-fa/2:10:fa/2];
f_aux = [0:10:fa];

x_t = 10*cos(2*pi*t*f1) + cos(2*pi*t*2*f1) + 4*cos(2*pi*t*3*f1);
X_f = fft(x_t)/length(x_t);
X_f_shift = fftshift(X_f);

figure(1)
subplot(411)
plot(t, x_t)
subplot(412)
plot(f_aux, abs(X_f))
subplot(413)
plot(f, abs(X_f_shift))
subplot(414)
plot(f, angle(X_f_shift)) %% n?o funcionou