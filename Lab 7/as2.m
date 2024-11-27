center_freqs = [31.5, 63, 125, 250, 500, 1000, 2000, 4000, 8000, 16000];
fs = 44100*2;
Q = 1.414;

lower_cutoffs = zeros(size(center_freqs));
upper_cutoffs = zeros(size(center_freqs));

for i = 1: length(center_freqs)

lower_cutoffs(i) = center_freqs(i) * (-1/(2*Q) + sqrt(1 + 1/(4*Q^2)));
upper_cutoffs(i) = center_freqs(i) * (1/(2*Q) + sqrt(1 + 1/(4*Q^2)));
end


lowpass_cutoff = upper_cutoffs(1);
highpass_cutoff = lower_cutoffs(end);
lowpass_cutoff_norm = lowpass_cutoff / (fs / 2);
highpass_cutoff_norm = highpass_cutoff / (fs / 2);

lower_cutoffs_norm = lower_cutoffs / (fs / 2);
upper_cutoffs_norm = upper_cutoffs / (fs / 2);


nfft =1024; 
f = linspace(0, fs/2, nfft/2+1); % freq axis
filters = zeros(length(center_freqs)+2, length(f));
% lowpass filter
[b_lp, a_lp] =fir1(50, lowpass_cutoff_norm, 'low');
[H_lp, ~] = freqz(b_lp, a_lp , nfft, fs);
filters(1, :) = abs(H_lp(1: length(f)));



% highpass filter
[b_hp, a_hp] = fir1(50, highpass_cutoff_norm, 'high');
[H_hp, ~] = freqz(b_hp, a_hp, nfft, fs);
filters(end, : )=abs(H_hp(1:length(f)));

for i = 1: length(center_freqs)

[b, a] = fir1(50, [lower_cutoffs_norm(i), upper_cutoffs_norm(i)], 'bandpass');

[H, ~] = freqz(b, a, nfft, fs);

filters(i+1, :) = abs(H(1:length(f)));

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