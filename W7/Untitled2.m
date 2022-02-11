%X = tf([1 0],[1 -1],.001,'Variable','z');
%figure(1)
%pzmap(X)
%figure(2)
%bode(X)

%H = tf([.2 .5],[1 -.2 .8],0.04,'Variable','z^-1');
%bode(H)
%grid on

%H = tf([.2 .5],[1 -.2 .8],0.04,'Variable','z^-1');
%[mag, phase, wout]=bode(H);
%f=wout/(2*pi);
%figure(1)
%subplot(2,1,1)
%plot(f,20*log10(mag(:,:)))
%grid on
%subplot(2,1,2)
%plot(f,(phase(:,:)))
%grid onN=512; 

N=512; 
fs=1000;
a=[1 -.2 .8];
b=[.2 .5];
H=fft(b,N)./fft(a,N);

Hm=20*log10(abs(H));
f=(1:N/2)*fs/N;
subplot(2,1,1)
plot(f,Hm(1:N/2),'k')
grid on
xlabel('frequency (Hz)')
ylabel('Magnitude,(dB)')

Ht=(angle(H)*180/pi);
f=(1:N/2)*fs/N;
subplot(2,1,2)
plot(f,Ht(1:N/2),'k')
grid on
xlabel('Frequency (Hz)')
ylabel('Phase (deg)')

x=[1,zeros(1,N-1)];
y=filter(b,a,x);

t=(1:N)/fs;
figure(3)
plot(t(1:60),y(1:60))
xlabel('time (sec)')
ylabel('Impulse Reponse')



