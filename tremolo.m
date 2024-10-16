function   tremolo(input,ampl,freq,output)
[y,Fs]=audioread(input);
Fc=freq/Fs;
newy=zeros(size(y));

for i=1:length(y)
    mod(i)=1+ampl*sin(2 * pi * Fc * i);
    newy(i,1)= y(i,1)*mod(i);
    newy(i,2)=y(i,2)*mod(i);
end
audiowrite(output,newy,Fs);

figure;
    subplot(3,1,1);
    plot(y(1:1000));
    title('Input Wave');
    xlabel('Sample Number');
    ylabel('Amplitude');
    
    subplot(3,1,2);
    plot(newy(1:1000));
    title('Output Wave ');
    xlabel('Sample Number');
    ylabel('Amplitude');
    
    subplot(3,1,3);
    plot(mod(1:1000));
    title('Carrier Signal');
    xlabel('Sample Number');
    ylabel('Amplitude');

     figure;
    subplot(2,1,1);
   spectrogram(y(:,1));
    title('Input Signal Chanel 1');
    xlabel('Time');
    ylabel('Frequency');
    
    subplot(2,1,2);
    spectrogram(newy(:,1));
    title('Output Signal');
    xlabel('Time');
    ylabel('Frequency');

end
    