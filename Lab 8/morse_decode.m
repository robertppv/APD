clc
load data.mat

%decode sound to morse

[y, fs] = audioread('morseCode2.wav');
y=abs(y);
N=length(y);
plot(y);

WPM = 10;
time_unit = round(1/(WPM) * fs);

high = 0;
low = 0;
mCode = '';
for i = 2:time_unit:N
    if(y(i) == 0)
        if(high == 1)
            mCode = [mCode '.'];
        else
            if(high == 3)
                mCode = [mCode '-'];
            end
        end
        high = 0;
        low = low + 1;
    else
        if(low == 3)
            mCode = [mCode ' '];
        end
        if(low == 7)
            mCode = [mCode '/'];
        end
        high = high + 1;
        low = 0;
    end
end


%decode morse to text (do not change this part!!!)
%mCode = '-.. ... .--. .-.. .- -... ... ';

deco = [];
mCode = [mCode ' '];	%mCode is an array containing the morse characters to be decoded to text
lCode = [];

for j=1:length(mCode)
    if(strcmp(mCode(j),' ') || strcmp(mCode(j),'/'))
        for i=double('a'):double('z')
            letter = getfield(morse,char(i));
            if strcmp(lCode, letter)
                deco = [deco char(i)];
            end
        end
        for i=0:9
            numb = getfield(morse,['nr',num2str(i)]);
            if strcmp(lCode, numb)
                deco = [deco, num2str(i)];
            end
        end
        lCode = [];
    else
        lCode = [lCode mCode(j)];
    end
    if strcmp(mCode(j),'/')
        deco = [deco ' '];
    end
end

fprintf('Decode : %s \n', deco);