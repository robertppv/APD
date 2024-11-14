function assig2()
    fs = 500;
    t = 0:1/fs:1-1/fs;
    

    x = 15 * sin(2 * pi * 10 * t - pi/4) + 20 * sin(2 * pi * 30 * t) +35 * sin(2 * pi * 70 * t + 3*pi/4);
        
       
    X = fft(x);
    N=length(X);
    f = (-N/2:N/2-1) * (fs / N);

    newX = fftshift(X);

    magnitude = abs(newX);
    phase = angle(newX);
    
    phase(magnitude < 10^(-5)) = 0;

    figure;

    subplot(3, 1, 1);
    plot(f, magnitude);
    title('Magnitude ');
    xlabel('Frequency');
    ylabel('Magnitude');

    subplot(3, 1, 2);
    plot(f, phase);
    title('Phase ');
    xlabel('Frequency ');
    ylabel('Phase ');

    subplot(3,1,3)
    plot(f,x);
    xlabel('Time');
    ylabel('Amplitudine');
    

end
