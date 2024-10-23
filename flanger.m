function flanger(input, output, maxcircularBuff, mincircularBuff, modValue)
    [y, Fs] = audioread(input);
    numSamples = size(y, 1); 
    
    circularBuffer = zeros(maxcircularBuff, 2);
    bufferIndex = uint32(1); 
    newy = zeros(numSamples, 2);
    
    flangerRate=0.5;
    modulation = (sin(2 * pi * flangerRate * (1:numSamples) / Fs) + 1) / 2;
    modulation = modulation * (maxcircularBuff - mincircularBuff) + mincircularBuff;

    for n = 1:numSamples
        currentSampleLeft = y(n, 1);
        currentSampleRight = y(n, 2);

        delaySamples = uint32(modulation(n));

        readIndex = mod(bufferIndex - delaySamples - 1, maxcircularBuff) + 1;

        delayedSampleLeft = circularBuffer(readIndex, 1);
        delayedSampleRight = circularBuffer(readIndex, 2);

        outputSampleLeft = currentSampleLeft + modValue * delayedSampleLeft;
        outputSampleRight = currentSampleRight + modValue * delayedSampleRight;

        newy(n, 1) = outputSampleLeft;
        newy(n, 2) = outputSampleRight;

        circularBuffer(bufferIndex, 1) = currentSampleLeft ; 
        circularBuffer(bufferIndex, 2) = currentSampleRight;

        bufferIndex = mod(bufferIndex, maxcircularBuff) + 1;
    end

    audiowrite(output, newy, Fs);

    figure;
    subplot(2, 1, 1);
    plot( y);
    title('Input');
    xlabel('Samples Number');
    ylabel('Amplitude');

    subplot(2, 1, 2);
    plot(newy);
    title('Output');
    xlabel('Samples Number');
    ylabel('Amplitude');
end
