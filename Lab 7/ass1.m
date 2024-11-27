fs = 44100;
center_freqs = [31.5, 63, 125, 250, 500, 1000, 2000, 4000, 8000, 16000];
Q = 1.446;

figure;
subplot(2,1,1);
hold on;
title('Frequency response of individual filters');
xlabel('Normalized Frequency');
ylabel('Magnitude');

sum_response = zeros(1024, 1);


for i = 1:length(center_freqs)
    if(i==1)
        fc1 = center_freqs(i) *(1/(2*Q) + sqrt(1 + 1/(4*Q^2)));
        b=fir1(50,fc1/(fs/2),'low');
        [H, f] = freqz(b, 1, 1024, fs);
        plot(f / fs, abs(H));
        sum_response = sum_response + abs(H);
    else if(i == length(center_freqs))
            fc1 = center_freqs(i) *(-1/(2*Q) + sqrt(1 + 1/(4*Q^2)));
            b=fir1(50,fc1/(fs/2),'high');
            [H, f] = freqz(b, 1, 1024, fs);
            plot(f / fs, abs(H));
            sum_response = sum_response + abs(H);
    else
        fc1 = center_freqs(i) *(-1/(2*Q) + sqrt(1 + 1/(4*Q^2)));
        fc2 = center_freqs(i) *(1/(2*Q) + sqrt(1 + 1/(4*Q^2)));

       
        b = fir1(50,[fc1,fc2]/ (fs/2), 'bandpass');
        [H, w] = freqz(b, 1, 1024, fs);
        plot(f / fs, abs(H));
        sum_response = sum_response + abs(H);
    end
    end
end

subplot(2,1,2);
plot(f / fs, 20*log10(sum_response));
title('Frequency response of sum of filters');
xlabel('Normalized Frequency');
ylabel('20*log10(Magnitude)');



