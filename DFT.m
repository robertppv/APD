function [X] = DFT(x)
    N = length(x);
    X = zeros(N, 1);
    n = 0:N-1;
    for k = 0:N-1
        wk = 2*pi*k/N;
        X(k+1) = sum(x.*exp(-1i*n*wk));
    end
end