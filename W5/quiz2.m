fs = 1000;
Ts = 1/fs;
t = 0:Ts:10-Ts;
ecgsignal = repmat(ecg1,1,10);
fn = 50;
An = 50;
noise = An*sin(2*pi.*t.*fn);
signnoise = noise + ecgsignal;
figure(1)
subplot(2,1,1)
plot(t,ecgsignal)
subplot(2,1,2)
plot(t,signnoise)
ftsn = fft(signnoise);
n = length(ftsn);
pwr = abs(ftsn(1:floor(n/2))).^2;
fd = linspace(1,fs/2,floor(n/2));
[b a] = butter(5,50/(1000/2))
y = filter(b,a,signnoise);
ftft = fft(y);
m = length(ftft);
power = abs(ftft(1:floor(m/2))).^2;
freq = linspace(1,fs/2,floor(m/2));
figure(2)
subplot(2,1,1)
plot(fd,pwr)
subplot(2,1,2)
plot(freq,power)