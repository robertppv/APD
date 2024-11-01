function assig3(x, fs)
    N = length(x);
    t = (0:N-1) / fs;     
    X = fft(x);
    f = (0:N-1) * (fs / N);  
    
    figure;
    subplot(3, 1, 1);
    plot(t, x);
    title('Amplitude of the Signal');
    xlabel('Time (s)');
    ylabel('Amplitude');
    grid on;

   
    magnitude = abs(X) / N; 
    subplot(3, 1, 2);
    plot(f(1:N/2), magnitude(1:N/2));  
    title('Magnitude Spectrum');
    xlabel('Frequency (Hz)');
    ylabel('|X(f)|');
    grid on;


    subplot(3, 1, 3);
    spectrogram(x);
    title('Spectrogram');
 
end
