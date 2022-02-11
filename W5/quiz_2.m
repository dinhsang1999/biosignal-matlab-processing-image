load sunspot.dat
year = sunspot(:,1);
relNumber = sunspot(:,2);
figure(2)
plot(year,relNumber);
t = linspace(1749,2015,3196);
SUNSPOTNUMBER = sin(2*pi*t);
y = fft(SUNSPOTNUMBER);
y(1) = [];
n = length(y);
power = abs(y(1:floor(n/2))).^2; 
maxfreq = 1/2;                   
freq = (1:n/2)/(n/2)*maxfreq;    
period = 1./freq;
figure (1)
subplot(2,1,1)
plot(t,SUNSPOTNUMBER)
xlim([1749 2016])
subplot(2,1,2)
plot(period,power);
xlim([0 50])
xlabel('years/cycles')
ylabel('Power')