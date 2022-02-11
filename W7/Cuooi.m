clc;
load('101noise.mat')
a=[1 -.2 .8];
b=[.2 .5];  
y=filter(b,a,signalNoise);
val = y/200;
data = val(1,1:3600);
fs = 360;
time_axis = (1:length(data))/fs;
y=filter(b,a,data);
plot(time_axis,y);
xlabel('time')
ylabel('mvoltage')
title('ECG data')


