function assig3(x, fs)
    N = length(x);
    t = (0:N-1) / fs;     
    X = fft(x);
    f = (0:N-1) * (fs / N);  
    
    figure;
    subplot(3, 1, 1);
    plot(t, x);
    title('Amplitude ');
    xlabel('Time (s)');
    ylabel('Amplitude');
    

   
    magnitude = abs(X) / N; 
    subplot(3, 1, 2);
    plot(f, magnitude);  
    title('Magnitude');
    xlabel('Frequency');
    ylabel('X(f)');
    


    subplot(3, 1, 3);
    spectrogram(x);
    title('Spectrogram');
 
end
