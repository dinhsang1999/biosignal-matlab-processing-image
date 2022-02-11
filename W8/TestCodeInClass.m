fs = 100;               % sampling frequency
t = 0:(1/fs):(10-1/fs); % time vector
S = cos(2*pi*15*t);
n = length(S);
X = fft(S);
figure(10)
f = (0:n-1)*(fs/n);     %frequency range
power = abs(X).^2/n;    %power
subplot(2,1,1);
plot(f,power)

Y = fftshift(X);
fshift = (-n/2:n/2-1)*(fs/n); % zero-centered frequency range
powershift = abs(Y).^2/n;
subplot(2,1,2);% zero-centered power
plot(fshift,powershift)

%Create a white box
testi(500,500)=0;
testi(225:275,225:275)=1;
 
%show the original image:
figure(1)
imshow(testi)
 
%take the fft2
testifft=fft2(testi);
figure(2)
imshow(testifft)

%shift the fft2
testishift=fftshift(testifft);
figure(3)
imshow(testishift)
 
%take the real part by taking the absolute
testiabs=abs(testishift);
figure(4)
imshow(testiabs)
 
 
%from the fft we can get the original image back
testire=abs(ifft2(testishift));
figure(5)
imshow(mat2gray(testire))
