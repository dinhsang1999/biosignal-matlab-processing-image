fs = 1000;
data = signal(1,1:5001);
time_axis = (1:length(data))/fs;
figure(1)
subplot(3,1,1); %2 row 1 column
plot(time_axis,data); %show ECG signal
xlim([0 5]);
change=fft(data); 
length_change=length(change);
change(1)=[];
power=abs(change(1:floor(length_change/2))).^2;
fred=linspace(0,fs/2,floor(length_change/2));

maxfreq = fs/2;                   
freq = (1:length_change/2)/(length_change/2)*maxfreq;
index = find(power == max(power));

period = 1./freq;
subplot(3,1,2);
plot(period,power);
str=int2str(freq(index));
text(period(index),max(power),str);
xlim([0 0.1]);


fprintf('frequency: %f Hz\n',freq(index));
fprintf('frequency: %f Hz\n',period(index));
