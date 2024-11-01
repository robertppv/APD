function assig2()
    fs = 500;
    T = 1;
    t = 0:1/fs:T-1/fs;

    x = 15 * sin(2 * pi * 10 * t - pi/4) + 20 * sin(2 * pi * 30 * t) +35 * sin(2 * pi * 70 * t + 3*pi/4);
        

    X = fft(x);
    N = length(X);
    f = (-N/2:N/2-1) * (fs / N);

    newX = fftshift(X);

    magnitude = abs(newX) / N;
    phase = angle(newX);
    
    phase(magnitude < 1e-5) = 0;

    figure;

    subplot(2, 1, 1);
    plot(f, magnitude);
    title('Magnitude ');
    xlabel('Frequency');
    ylabel('|X(f)|');
    grid on;

    subplot(2, 1, 2);
    plot(f, phase);
    title('Phase ');
    xlabel('Frequency ');
    ylabel('Phase ');
    grid on;
end
