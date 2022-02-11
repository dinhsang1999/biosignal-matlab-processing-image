load sunspot.dat
year = sunspot(:,1);
relNumber = sunspot(:,2);
figure(2)
plot(year,relNumber);
t = linspace(min(year),max(year),length(year));
SUNSPOTNUMBER = sin(2*pi*t);
y = fft(SUNSPOTNUMBER);
y(1) = [];
n = length(y);
power = abs(y(1:floor(n/2))).^2; 
fs=max(year)*2;
figure (1)
subplot(2,1,1)
plot(t,SUNSPOTNUMBER)
xlim([1749 2016])
subplot(2,1,2)
plot(period,power);
xlim([0 50])
xlabel('years/cycles')
ylabel('Power')