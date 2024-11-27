center_freqs = [31.5, 63, 125, 250, 500, 1000, 2000, 4000, 8000, 16000];
fs = 44100;
Q = 1.414;

lower_cutoffs = zeros(size(center_freqs));
upper_cutoffs = zeros(size(center_freqs));
f = linspace(0, fs/2, 1024/2+1); 
filters = zeros(length(center_freqs), length(f));

for i = 1: length(center_freqs)

    lower_cutoffs(i) = center_freqs(i) * (-1/(2*Q) + sqrt(1 + 1/(4*Q^2)));
    upper_cutoffs(i) = center_freqs(i) * (1/(2*Q) + sqrt(1 + 1/(4*Q^2)));

    if(i==1)
        lowpass_cutoff_norm = upper_cutoffs(1) / (fs / 2);
        b =fir1(50, lowpass_cutoff_norm, 'low');
        [H, ~] = freqz(b, 1, 1024, fs);
        filters(1, :) = abs(H(1: length(f)));
    else if(i==length(center_freqs))
            highpass_cutoff_norm = lower_cutoffs(i) / (fs / 2);
            b = fir1(50, highpass_cutoff_norm, 'high');
            [H, ~] = freqz(b, 1, 1024, fs);
            filters(end, : )=abs(H(1:length(f)));
    else
        lower_cutoffs_norm = lower_cutoffs(i) / (fs / 2);
        upper_cutoffs_norm = upper_cutoffs(i) / (fs / 2);
        b = fir1(50, [lower_cutoffs_norm, upper_cutoffs_norm], 'bandpass');
        [H, ~] = freqz(b, 1, 1024, fs);
        filters(i, :) = abs(H(1:length(f)));
    end
    end

end

subplot(2, 1, 1);

plot(f/(fs/2), filters');

xlabel('Normalized Frequency');

ylabel (' Magnitude');

title ('Frequency response of individual filters');

combined_response = sum(filters, 1);

subplot(2, 1, 2);

plot(f/(fs/2), combined_response);

xlabel(' Normalized Frequency ');

ylabel('Mag');

title( 'Frequency response of sum of filters');