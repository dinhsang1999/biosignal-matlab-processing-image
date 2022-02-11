load ('209m.mat'); % this loads the signal to val matrix
ESignal = (val-0)/200; %where 0 is the base and 200 is the gain
Fs=360; %where Fs is the sampling frequency provided in the data set
t = (0:length(ESignal)-1)/Fs; % time is 1/f, therefore the time is length sample / Fs
plot(t,ESignal);
xlabel('time (seconds)');
ylabel('Electrical Activity (mV)');
title('ECG Activity sampled at 360Hz');
% applying high pass filter
h=fir1(1000,1/360*2,'high');
ESignal_Filter = filter(h,1,ESignal);
plot(t,ESignal_Filter);
xlabel('time (seconds)');
ylabel('Electrical Activity (mV)');
title('Applying a High-pass filter ');
%squaring the signal
desq=(ESignal_Filter.^2);
figure(1);
plot(t,desq);
xlabel('time (seconds)');
ylabel('Electrical Activity (mV)');
title('Squaring the Signals ');
threshold =0.8;
figure(2);
findpeaks(desq,t,'MinPeakProminence',threshold);
xlabel('time (seconds)');
ylabel('Electrical Activity (mV)');
title('Squaring the Signals ');
[a b] = findpeaks(desq,t,'MinPeakProminence',threshold);
peakdistance = diff(b)
avg = mean(peakdistance)
Heartrate = 60/avg
if Heartrate <60
    disp(' The paitent have Bradycardia Desease');
else disp ('The paitient have normal heart');
end;