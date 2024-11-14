function addFlanger(inputWavefilePath, outputWavefilePath, maxCircularBuffSize, minCircularBuffSize, modValue)
    % Read the input audio file (stereo)
    [inputAudio, fs] = audioread(inputWavefilePath);
    numSamples = size(inputAudio, 1); % Number of samples
    numChannels = size(inputAudio, 2); % Number of channels (should be 2 for stereo)

    if numChannels ~= 2
        error('The input audio file must be a stereo file.');
    end

    % Initialize the circular buffer for stereo channels
    circularBuffer = zeros(maxCircularBuffSize, 2); % 2D array for the circular buffer (stereo)
    bufferIndex = uint32(1); % Start the index at 1 (uint32 variable)

    % Output audio array
    outputAudio = zeros(numSamples, 2);

    % Flanger parameters
    flangerRate = 0.25; % Modulation rate in Hz (adjustable)
    feedbackGain = 0.7; % Feedback gain factor for more complex effect

    % Create a sine wave for modulation
    modulation = (sin(2 * pi * flangerRate * (1:numSamples) / fs) + 1) / 2;
    modulation = modulation * (maxCircularBuffSize - minCircularBuffSize) + minCircularBuffSize;

    % Process the audio samples using the circular buffer
    for n = 1:numSamples
        % Get the current input samples for left and right channels
        currentSampleLeft = inputAudio(n, 1);
        currentSampleRight = inputAudio(n, 2);

        % Calculate the delay time based on the modulation
        delaySamples = uint32(modulation(n));

        % Compute the read index for the circular buffer, with wrapping
        readIndex = mod(bufferIndex - delaySamples - 1, maxCircularBuffSize) + 1;

        % Read the delayed samples from the circular buffer for both channels
        delayedSampleLeft = circularBuffer(readIndex, 1);
        delayedSampleRight = circularBuffer(readIndex, 2);

        % Calculate the output samples by adding the delayed samples to the current samples
        outputSampleLeft = currentSampleLeft + modValue * delayedSampleLeft;
        outputSampleRight = currentSampleRight + modValue * delayedSampleRight;

        % Store the output samples in the output audio array
        outputAudio(n, 1) = outputSampleLeft;
        outputAudio(n, 2) = outputSampleRight;

        % Update the circular buffer with the current samples plus feedback
        circularBuffer(bufferIndex, 1) = currentSampleLeft + feedbackGain * delayedSampleLeft;
        circularBuffer(bufferIndex, 2) = currentSampleRight + feedbackGain * delayedSampleRight;

        % Increment the buffer index and wrap around if needed
        bufferIndex = mod(bufferIndex, maxCircularBuffSize) + 1;
    end

    % Write the output audio to a new file
    audiowrite(outputWavefilePath, outputAudio, fs);

    % Plot the input and output waveforms for the left and right channels
    figure;
    subplot(2, 1, 1);
    plot((1:numSamples) / fs, inputAudio(:, 1));
    title('Input Audio Waveform (Left Channel)');
    xlabel('Time (s)');
    ylabel('Amplitude');

    subplot(2, 1, 2);
    plot((1:numSamples) / fs, outputAudio(:, 1));
    title('Output Audio Waveform with Flanger (Left Channel)');
    xlabel('Time (s)');
    ylabel('Amplitude');
end
