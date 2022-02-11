t=0:0.01:3;
fs=1/0.01;
fd=fs/300;
signal1=sin(2*pi*10*t);
figure(1)
plot(t,signal1)

y=fft(signal1);
power=abs(y).^2
figure(3)
plot(power)
n=length(y);
freq=linspace(0,fs/2,floor(n/2))
power=abs(y(1:floor(n/2))).^2 
figure(2)
plot(power)