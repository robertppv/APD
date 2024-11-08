function assig2FILTER()
Fs = 12000;  
F1 = 3000;    
F2 = 4500;     
         
t = 0:1/Fs:1-1/Fs;
x = cos(2*pi*F1*t) + cos(2*pi*F2*t);
figure;
subplot(2, 2, 1);
plot(t, x);
title('Input');
xlabel('Time (s)');
ylabel('Amplitude');



X = fft(x);
N=length(X);
f = (0:N-1) * Fs / N;
magnitude=abs(X);
subplot(2, 2, 2);
plot(f, magnitude);
title('Magnitude of Input');
xlabel('Frequency ');
ylabel('|X(f)|');



Wn = (F1 + F2) / (2 * Fs); 
n = 50;         
b = fir1(n, Wn, 'high'); 


y = filter(b,1, x);


subplot(2, 2, 3);
plot(t, y);
title('Output');
xlabel('Time (s)');
ylabel('Amplitude');
grid on;


Y_f = fft(y);
subplot(2, 2, 4);
magnitude=abs(Y_f);
plot(f, magnitude);
title('Magnitude of Output');
xlabel('Frequency ');
ylabel('|Y(f)|');

end
