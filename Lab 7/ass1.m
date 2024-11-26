fs = 44100;  
center_freqs = [31.5, 63, 125, 250, 500, 1000, 2000, 4000, 8000, 16000]; 



figure;
subplot(2,1,1);
hold on;
title('Frequency response of individual filters');
xlabel('Normalized Frequency');
ylabel('Magnitude');


sum_response = zeros(1024, 1); % 


for i = 1:length(center_freqs)
 
    fc1 = center_freqs(i) / sqrt(2); 
    fc2 = center_freqs(i) * sqrt(2);  
    
    if fc2 > fs / 2
        fc2 = fs / 2 - 1;
    end

    b = fir1(50, [fc1, fc2] / (fs/2), 'bandpass');    
    [H, f] = freqz(b, 1, 1024, fs); 
    plot(f / fs, abs(H));      
    sum_response = sum_response + abs(H);
end





subplot(2,1,2);
plot(f / fs, 20*log10(sum_response)); 
title('Frequency response of sum of filters');
xlabel('Normalized Frequency');
ylabel('20*log10(Magnitude)');



