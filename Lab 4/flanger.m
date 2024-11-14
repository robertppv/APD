function flanger(input, output, maxcircularBuff, mincircularBuff, modValue)
[y, Fs] = audioread(input);
samples = size(y, 1);
channels=size(y,2);

bufferIndex = uint32(1);

flangerRate=0.5;
if(channels==2)
    circularBuffer = zeros(maxcircularBuff, 2);
    newy = zeros(samples, 2);
    for n = 1:samples
        modulation = (sin(2 * pi * flangerRate * n/Fs) + 1)/2;
        delaySamples = uint32(modulation);
        readIndex = mod(bufferIndex - delaySamples - 1, maxcircularBuff) + 1;
        newy(n, 1) = y(n, 1) + modValue *circularBuffer(readIndex, 1);
        newy(n, 2) =y(n, 2) + modValue * circularBuffer(readIndex, 2);
        circularBuffer(bufferIndex, 1) = y(n, 1) ;
        circularBuffer(bufferIndex, 2) = y(n, 2);
        bufferIndex = mod(bufferIndex, maxcircularBuff) + 1;
    end
else
    circularBuffer = zeros(maxcircularBuff, 1);
    newy = zeros(samples, 1);
    for n = 1:samples
        modulation = sin(2 * pi * flangerRate * n/Fs) + 1;
        modulation = modulation * (maxcircularBuff - mincircularBuff) + mincircularBuff;
        delaySamples = uint32(modulation);
        readIndex = mod(bufferIndex - delaySamples - 1, maxcircularBuff) + 1;
        newy(n, 1) = y(n, 1) + modValue *circularBuffer(readIndex, 1);
        circularBuffer(bufferIndex, 1) = y(n, 1) ;
        bufferIndex = mod(bufferIndex, maxcircularBuff) + 1;
    end
end


audiowrite(output, newy, Fs);

end
