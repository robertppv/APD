function   modifieVocals(input,db,output)
[y,Fs]=audioread(input);
v=(y(:,1)+y(:,2))/2;
newv=v*10^(db/20);
bl=y(:,1)-v;
br=y(:,2)-v;
newy(:,1)=bl+newv;
newy(:,2)=br+newv;
subplot(2,1,1);
plot(y,'r');
title('Original');
subplot(2,1,2);
plot(newy,'b');
title('Modified');
audiowrite(output,newy,Fs);

end