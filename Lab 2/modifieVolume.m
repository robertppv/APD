function modifieVolume(input,db,output)
[y,Fs]=audioread(input);
newy=y*10^(db/20);
audiowrite(output,newy,Fs);
subplot(2,1,1);
plot(y,'r');
title('Original');
subplot(2,1,2);
plot(newy,'b');
title('Modified');
end