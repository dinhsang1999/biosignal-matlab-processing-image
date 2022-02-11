testi=imread('moon.tif');
%show the original image:
figure(1)
imshow(testi)

testifft=fft2(testi);
figure(2)
imshow(testifft)
 

testishift=fftshift(testifft);
figure(3)
imshow(testishift)

testiabs=abs(testishift);
figure(4)
imshow(testiabs)

testire=abs(ifft2(testishift));
figure(5)
imshow(mat2gray(testire))

mesh3D_1 = Mesh(abs(testifft));
figure(6)
imshow(mesh3D_1)

mesh3D_2=Mesh(abs(testishift));
figure(7)
imshow(mesh3D_2)



