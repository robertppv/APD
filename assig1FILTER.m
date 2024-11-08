function   assig1FILTER()
Fs = 2500;
Fp = 300;
Fst = 500;
Rp = 3;
Ast = 30;
h = fdesign.lowpass('Fp,Fst,Ap,Ast', Fp, Fst, Rp, Ast, Fs);

h1=design(h,'equiripple','MinPhase',true);
%t = 0:1/Fs:1-1/Fs;
%x = 15 * sin(2 * pi * 10 * t - pi/4) + 20 * sin(2 * pi * 30 * t) +35 * sin(2 * pi * 70 * t + 3*pi/4);


newX=filter(h1,x);
N=length(x);
%t = (0:N-1) / Fs;

figure;
subplot(2, 1, 1);
plot(t, x);
title('Original');
xlabel('Time (s)');
ylabel('Amplitude');

subplot(2, 1, 2);
plot(t, newX);
title('Filtered');
xlabel('Time (s)');
ylabel('Amplitude');

f = (0:N-1)*(Fs/N);
magnitudeX=abs(fft(x));
magnitudeNewX=abs(fft(newX));

figure;
subplot(2, 1, 1);
plot(f, magnitudeX);
title('Magnitude Original');
xlabel('Frequency (Hz)');
ylabel('Magnitude (dB)');

subplot(2, 1, 2);
plot(f, magnitudeNewX);
title('Magnitude Filtered');
xlabel('Frequency (Hz)');
ylabel('Magnitude (dB)');
end