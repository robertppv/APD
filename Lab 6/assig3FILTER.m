function assig3FILTER(input,output)
[y,Fs]=audioread(input);

X = fft(y);
nX=fftshift(X);
magnitudeX = abs(nX);
N=length(X);

figure
f = (-N/2:N/2-1)*(Fs/N);
subplot(2,1,1);
plot(f, magnitudeX);
title('Input Magnitude');
xlabel('Frequency');
ylabel('Magnitude');

Den=[1,1.385640646055102,0.640000000000000];
Num=[-9.190982084682560e-04,0];

Y=filter(Num,Den,y);
newY=fft(Y);
nY=fftshift(newY);
magnitudeY=abs(nY);

subplot(2,1,2);
plot(f, magnitudeY);
title('Output Magnitude');
xlabel('Frequency');
ylabel('Magnitude');

audiowrite(output,Y,Fs);

end

