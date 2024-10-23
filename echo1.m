function echo1(input, output, circularBuffSize)
    [y, Fs] = audioread(input);
    Samples = length(y);
    circularBuffer = zeros(circularBuffSize, 2); 
    bufferIndex = uint32(1); 
    newy = zeros(Samples, 1);
    gain = 0.5;
    feedbackgain=0.7;
    for n = 1:Samples
        currentSample1 = y(n,1); 
        currentSample2 = y(n,2); 
        echoSample1 = circularBuffer(bufferIndex, 1);
        echoSample2 = circularBuffer(bufferIndex, 2);
        outputSample1 = currentSample1 + gain * echoSample1;  
        outputSample2 = currentSample2 + gain * echoSample2;    
        newy(n,1) = outputSample1;        
        newy(n,2) = outputSample2; 
        circularBuffer(bufferIndex, 1) = currentSample1 + feedbackgain * echoSample1;
        circularBuffer(bufferIndex, 2) = currentSample2 + feedbackgain * echoSample2;
        bufferIndex = mod(bufferIndex, circularBuffSize) + 1;
    end

    audiowrite(output, newy, Fs);

    figure;
    subplot(2, 1, 1);
    plot(y);
    title('Input');
    xlabel('Samples Number');
    ylabel('Amplitude');

    subplot(2, 1, 2);
    plot(newy);
    title('Output');
    xlabel('Samples Number');
    ylabel('Amplitude');
end
