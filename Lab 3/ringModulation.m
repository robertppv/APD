function   ringModulation(input,freq,output)
[y,Fs]=audioread(input);
samples=length(y);
t=(0:samples-1)'/Fs;
mod=sin(2 * pi * freq * t);
newy=zeros(size(y));

for i=1:samples
    newy(i)=y(i)*mod(i);
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
    spectrogram(y);
    title('Input Signal');
    xlabel('Time');
    ylabel('Frequency');
    
    subplot(2,1,2);
    spectrogram(newy);
    title('Output Signal');
    xlabel('Time');
    ylabel('Frequency');
end