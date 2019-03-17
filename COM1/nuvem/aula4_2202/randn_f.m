x = randn(1, 1000000);
hist(x, 100); hold on;
mean(x)

x_cor = xcorr(x);
plot(x_cor)

hist(x, 100);
r = x + 5;
hist(r, 100);

n = x*10;

% variancia : var
% desvio padrao : std
subplot(211)
hist(x, 100) % varianca = 1
xlim([-30 30])
subplot(212)
hist(n, 100) % varianca = 100
xlim([-30 30])

