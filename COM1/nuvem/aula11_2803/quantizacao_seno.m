clear all
close all
clc

n = 3; % niveis de quantizacao
fs = 1e3;
fa = 20*fs;
fq = 8*fs;
t = [0:1/fa:10*(1/fs)];
Am = 2;
x_t = Am*sin(2*pi*t*fs);
x_f = fftshift(fft(x_t)/length(x_t));

delta = 2*Am/(2^n);
x_t_2 = (x_t+(Am-delta))/delta;
out = round(x_t_2);
for i = 1:length(out)
    if out(i) < 0
        out(i) = 0;
    end
end
de_out = de2bi(out);
out_bin = reshape(transpose(de_out), 1, length(out)*n);

figure(1)
subplot(211)
plot(t, x_t)
subplot(212)
plot(t, out)

