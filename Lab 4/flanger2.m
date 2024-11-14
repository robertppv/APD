function echo1(input,output,circularBuffSize)
[y,Fs]=audioread(input);
samples = length(y);
numChannels=size(y,2);
gain=0.5;
feedbackGain=0.5;

buffIndex=uint32(1);
if(numChannels==2)
    circularBuff=zeros(circularBuffSize, 2);
    newy=zeros(samples,2);

    for n=1:samples
        newy(n,1)=y(n,1) + gain*circularBuff(buffIndex,1);
        newy(n,2)=y(n,2) + gain*circularBuff(buffIndex,2);
        circularBuff(buffIndex,1)=y(n,1) + feedbackGain * circularBuff(buffIndex,1);
        circularBuff(buffIndex,2)=y(n,2) + feedbackGain * circularBuff(buffIndex,2);
        buffIndex=mod(buffIndex,circularBuffSize)+1;
    end
else
    circularBuff=zeros(circularBuffSize, 1);
    newy=zeros(samples,1);

    for n=1:samples
        newy(n,1)=y(n,1) + gain*circularBuff(buffIndex,1) + feedbackGain * circularBuff(buffIndex,1);
        circularBuff(buffIndex,1)=y(n,1);
        buffIndex=mod(buffIndex,circularBuffSize)+1;
    end
end

audiowrite(output,newy,Fs);
end