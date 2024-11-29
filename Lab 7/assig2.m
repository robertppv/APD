function assig2(input,output,gain)

centerF=[31.5,63,125,250,500,1000,2000,4000,8000,16000];
Q=1.43;
[y, fs] = audioread(input);
N = length(y);
newy = zeros(size(y));
f = (0-N/2:N/2-1) * (fs / N);



for i = 1:length(centerF)
    if i == 1
        cF = centerF(1) * (1 / (2 * Q) + sqrt(1 + 1 / (4 * Q * Q)));
        [b, a] = fir1(50, cF / (fs), 'low');
    elseif i == length(centerF)

        cF = centerF(end) * (-1 / (2 * Q) + sqrt(1 + 1 / (4 * Q * Q)));
        [b, a] = fir1(50, cF / (fs ), 'high');
    else

        cF1 = centerF(i) * (-1 / (2 * Q) + sqrt(1 + 1 / (4 * Q * Q)));
        cF2 = centerF(i) * (1 / (2 * Q) + sqrt(1 + 1 / (4 * Q * Q)));
        [b, a] = fir1(50, [cF1, cF2] / (fs), 'bandpass');
    end


    linearGain = 10^(gain(i) / 20);
    if(size(y,2)==2)
        filteredSignal1 = filter(b, a, y(:,1));
        newy(:,1) = newy + linearGain * filteredSignal1;
        filteredSignal2 = filter(b, a, y(:,2));
        newy(:,2) = newy + linearGain * filteredSignal2;
    else
        filteredSignal = filter(b, a, y);
        newy = newy + linearGain * filteredSignal;
    end





end


audiowrite(output, newy, fs);



figure;
subplot(2,1,1);
inputMag = abs(fftshift(fft(y)));
plot(f, inputMag);
title('Magnitude Spectrum of Input Signal');
xlabel('Frequency (Hz)');
ylabel('Magnitude');


subplot(2,1,2);
outputMag = abs(fftshift(fft(newy)));
plot(f, outputMag);
title('Magnitude Spectrum of Processed Signal');
xlabel('Frequency (Hz)');
ylabel('Magnitude');



end
