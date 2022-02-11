load('101noise.mat') %get val from pacemaker  rhytm, 1x3600
%gain = 200
val = signalNoise/200; %mV
data = val(1,1:3600); %get data at row 1, 3600 column
fs = 360; %360Hz
time_axis = (1:length(data))/fs; %10s 3600/360=10s
figure(1)
subplot(3,1,1); %2 row 1 column
plot(time_axis,data); %show ECG signal
xlabel('time')
ylabel('mvoltage')
title('ECG data')
change=fft(data); %furio transform
length_change=length(change);
change(1)=[];
power1=abs(change(1:floor(length_change/2))).^2;
power2=abs(change(1:floor(length_change/2))).^2;
fred=linspace(0,fs/2,floor(length_change/2));
subplot(3,1,2);
plot(fred,power2);

xlabel('Frequency: Heart Cycle/sec')
ylabel('Power spectrum density')
subplot(3,1,3);
plot(fred,power1);

xlabel('Frequency: Heart Cycle/sec')
ylabel('Power spectrum density')

numsPeaks=12;
fprintf('heart rate: %f bpm ', numsPeaks*6);

maxfreq = fs/2;                   
freq = (1:length_change/2)/(length_change/2)*maxfreq;

figure(2)
period = 1./freq;
subplot(2,1,1);
plot(period,power1);

 %zoom in on max power
xlabel('Second/Heart Cycle')
ylabel('PSD')







