clc
load data.mat

% Decode sound to Morse
[inputSignal, fs] = audioread('morseCode1.wav'); % Load wave file


% Threshold the signal to binary
threshold = 0.5; % Adjust as needed
binarySignal = inputSignal > threshold;

% Process binary signal into Morse code
mCode = ''; % Initialize Morse code string
highDurations = [];
lowDurations = [];
currentValue = binarySignal(1);
counter = 0;

for i = 1:length(binarySignal)
    if binarySignal(i) == currentValue
        counter = counter + 1;
    else
        if currentValue == 1
            highDurations = [highDurations, counter];
            if counter < fs * 0.1
                mCode = [mCode, '.'];
            elseif counter < fs * 0.3
                mCode = [mCode, '-'];
            end
        else
            lowDurations = [lowDurations, counter];
            if counter > fs * 0.7
                mCode = [mCode, ' / ']; % Space between words
            elseif counter > fs * 0.3
                mCode = [mCode, ' ']; % Space between letters
            end
        end
        currentValue = binarySignal(i);
        counter = 1;
    end
end

% Add the last segment
if currentValue == 1
    highDurations = [highDurations, counter];
    if counter < fs * 0.1
        mCode = [mCode, '.'];
    elseif counter < fs * 0.3
        mCode = [mCode, '-'];
    end
end

% Plot the waveform
figure;
subplot(2, 1, 1);
plot(inputSignal);
title('Waveform of Morse Code Signal');
xlabel('Sample Number');
ylabel('Amplitude');

subplot(2, 1, 2);
plot(binarySignal(1:fs)); % Plot first second of binary signal
title('Binary Representation of Morse Code');
xlabel('Sample Number');
ylabel('Amplitude');

% Decode Morse to text (do not change this part!!!)
%mCode = '-.. ... .--. .-.. .- -... ... ';
deco = [];
mCode = [mCode ' ']; % mCode is an array containing the Morse characters to be decoded to text
lCode = [];

for j = 1:length(mCode)
    if (strcmp(mCode(j), ' ') || strcmp(mCode(j), '/'))
        for i = double('a'):double('z')
            letter = getfield(morse, char(i));
            if strcmp(lCode, letter)
                deco = [deco char(i)];
            end
        end
        for i = 0:9
            numb = getfield(morse, ['nr', num2str(i)]);
            if strcmp(lCode, numb)
                deco = [deco, num2str(i)];
            end
        end
        lCode = [];
    else
        lCode = [lCode mCode(j)];
    end
    if strcmp(mCode(j), '/')
        deco = [deco ' '];
    end
end

fprintf('Decode : %s \n', deco);
