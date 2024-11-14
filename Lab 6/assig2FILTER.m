function assig2FILTER()
    F1 = 3000; 
    F2 = 4500; 
    Fs = 12000;  
    t = 0:1/Fs:1-1/Fs; 
    x = cos(2*pi*F1*t) + cos(2*pi*F2*t);


    figure;
    subplot(2,2,1);
    plot(t, x);
    title('Input');
    xlabel('Time (s)');
    ylabel('Amplitude');

    
    X = fft(x);
    nX=fftshift(X);
    magnitudeX = abs(nX);
    f = (-length(X)/2:length(X)/2-1)*(Fs/length(X)); 
    subplot(2,2,2);
    plot(f, magnitudeX);
    title('Input Magnitude');
    xlabel('Frequency');
    ylabel('Magnitude');
    b = fir1(50, 3500/(Fs/2), 'high');
    y = filter(b, 1, x);
    subplot(2,2,3);
    plot(t, y);
    title('Output');
    xlabel('Time (s)');
    ylabel('Amplitude');

  
    Y = fft(y);
    nY=fftshift(Y);
    magnitudeY = abs(nY);

    subplot(2,2,4);
    plot(f, magnitudeY);
    title('Output Magnitude');
    xlabel('Frequency ');
    ylabel('Magnitude');
 
end
