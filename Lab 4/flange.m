function flange(input, output, maxBufferSize, minBufferSize, bufferSizeControl)
    % Read the audio file
    [y, Fs] = audioread(input);
    samples = length(y);
    numChannels = size(y, 2);
    gain=0.5;
    circularBuffer = zeros(maxBufferSize, numChannels);
    outputSignal = zeros(samples, numChannels);
    
    
   
    for n = 1:samples
      
        modulatedDelay = round((bufferSizeControl - minBufferSize) * (1 + sin(0.5 / Fs * 2 * pi * n)) + minBufferSize);
        bufferIndex = mod(n - modulatedDelay - 1, maxBufferSize) + 1;

        if numChannels == 2
        
            outputSignal(n, 1) = y(n, 1) +  gain*circularBuffer(bufferIndex, 1);
            outputSignal(n, 2) =  y(n, 2) +  gain*circularBuffer(bufferIndex, 2);
            
            % Update circular buffer with current sample
            circularBuffer(bufferIndex, 1) = y(n, 1);
            circularBuffer(bufferIndex, 2) = y(n, 2);
        else
            % Mono Processing
            outputSignal(n) =  y(n) + circularBuffer(bufferIndex);
            circularBuffer(bufferIndex) = y(n);
        end
    end

    % Write the output audio file
    audiowrite(output, outputSignal, Fs);
end
