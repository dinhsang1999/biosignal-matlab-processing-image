I = imread('name.tif');

A = imnoise(I,'salt & pepper',0.3);
figure(1);
imshowpair(I,A,'montage')

K=fspecial('average',3);

[hi,vi]=size(A);
[hk,vk]=size(K);

sizeh=(hi+hk-1);
sizev=(vi+vk-1);

Af=fft2(A,sizeh,sizev);
Kf=fft2(K,sizeh,sizev);

Rf=Af.*Kf;
Rt=ifft2(Rf);
figure(2);
Rtt = uint8(Rt);
imshowpair(A,Rtt,'montage');

Rt=conv2(A,K,'same');
K1 = medfilt2(A);
figure(3);
imshowpair(A,K1,'montage');

K2 = medfilt2(K1);
figure(4);
imshowpair(A,K2,'montage');

K3 = medfilt2(K2);
figure(5);
imshowpair(A,K3,'montage');


