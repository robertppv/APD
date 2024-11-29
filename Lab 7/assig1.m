centerF=[31.5,63,125,250,500,1000,2000,4000,8000,16000];
Q=1.5;
fs=44100;

sumresp=zeros(1024,1);

figure 
subplot(2,1,1);
hold on;
title('Frequency response of individual filters');
xlabel('Normalized Frequency');
ylabel('Magnitude');

for i=1:length(centerF)
    if(i==1)
        cF=centerF(1)*(1/(2*Q) + sqrt(1+1/(4*Q*Q)));
        [b,a]=fir1(50,cF/(fs/2),'low');
        [H,f]=freqz(b,a,1024,fs);
        plot(f/fs,abs(H));
        sumresp=sumresp+abs(H);
    else
        if(i==length(centerF))
            cF=centerF(10)*(-1/(2*Q) + sqrt(1+1/(4*Q*Q)));
            [b,a]=fir1(50,cF/(fs/2),'high');
            [H,f]=freqz(b,a,1024,fs);
            plot(f/fs,abs(H));
            sumresp=sumresp+abs(H);
        else
            cF1=centerF(i)*(-1/(2*Q) + sqrt(1+1/(4*Q*Q)));
            cF2=centerF(i)*(1/(2*Q) + sqrt(1+1/(4*Q*Q)));
            [b,a]=fir1(50,[cF1 ,cF2]/(fs/2),'bandpass');
            [H,f]=freqz(b,a,1024,fs);
            plot(f/fs,abs(H));
            sumresp=sumresp+abs(H);
        end
    end
end

subplot(2,1,2);
plot(f/fs,20*log10(sumresp));
title('Frequency response of sum of filters');
xlabel('Normalized Frequency');
ylabel('20log10(Magnitude)');





