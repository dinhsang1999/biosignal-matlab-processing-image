Y = fft(signalNoise);
%get rid of DC component
Y(1) = [];
n = length(Y);
power = abs(Y).^2;
%get rid of the mirror
n = length(Y);
power = abs(Y(1:floor(n/2))).^2;
%generate frequency axis
freq=linspace(1,fs/2,floor(n/2))
%plot(power)
figure(4)
%subplot(4,1,4)
plot(freq,power)
xlabel('frequency')
title('Periodogram')

a=[1 -.2 .8];
b=[.2 .5];
y=filter(b,a,signalNoise);
figure(5)
plot(y)
xlabel('frequency')
title('Periodogram')

Y = fft(y);
%get rid of DC component
Y(1) = [];
n = length(Y);
power = abs(Y).^2;
%get rid of the mirror
n = length(Y);
power = abs(Y(1:floor(n/2))).^2;
%generate frequency axis
freq=linspace(1,fs/2,floor(n/2));
%plot(power)
figure(6)
%subplot(4,1,4)
plot(freq,power)
xlabel('frequency')
title('Periodogram')
