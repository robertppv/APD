function [x] = IDFT(X)
N = length(X);
x = zeros(1, N);
k = 0:N-1;
k=k';
for n = 0:N-1
    wk =  2 * pi * n / N;
    x(n + 1) = sum(X .* exp(1i * k * wk));
end
x=x / N;
end