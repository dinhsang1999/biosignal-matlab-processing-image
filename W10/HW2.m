
clc
close all
clear all
%clear auto, ?? ph?i x�a tay
rgb = imread('coloredChips.png');
figure,imshow(rgb), impixelinfo %cho n� hi?n th�ng s? ? d??i c�i h�nh show ra �,
%v�o figure m?i xu?t ra, ??a con tr? v�o h�nh, nh�n v�o g�c tr�i b�n d??i
%l� hi?u.
%%
rgb_h = rgb2hsv(rgb);
figure,imshow(rgb_h)
red = rgb_h(:,:,1);
s = rgb_h(:,:,2);
v = rgb_h(:,:,3);
figure,imshow(red)
figure,imshow(s)
figure,imshow(v)
%??i v�i h? m�u ?? ph�n v�ng m�u cho d? detect color
%nh?n th?y ? k�nh ??u ti�n c?a h? m�u hsv, m�u ?? kh�c bi?t v?i c�c m�u c�n
%l?i, figure(3)
[r c] =size(red); % l?y height vs weight c?a ?nh
for i = 1:r %qu�t t?ng pixel
    for j= 1:c
       if red(i,j) >= 0.9 %t�y index ? ?nh m� thay ??i cho h?p l�
           out(i,j) = 255;
       else
           out(i,j) = 0;
       end
    end
end

figure,imshow(out)
out = bwareaopen(out,100);
figure,imshow(out)
%%
%delete(h);
figure,imshow(rgb)
[centers, radii] = imfindcircles(out,[20 25], 'ObjectPolarity','bright', ...
          'Sensitivity',0.92,'Method','twostage');
h = viscircles(centers,radii,'Color','k'); 
%gray_image = rgb2gray(rgb);
%imshow(gray_image);
%[centers, radii] = imfindcircles(rgb,[20 25],'ObjectPolarity','dark', ...
%    'Sensitivity',0.9)
%[centers, radii] = imfindcircles(rgb,[20 25],'ObjectPolarity','dark')
%[centers, radii] = imfindcircles(rgb,[20 25],'ObjectPolarity','dark', ...
%    'Sensitivity',0.92);
%h = viscircles(centers,radii);
%length(centers)
%delete(h);  % Delete previously drawn circles
%h = viscircles(centers,radii);
%[centers, radii] = imfindcircles(rgb,[20 25], 'ObjectPolarity','dark', ...
 %         'Sensitivity',0.92,'Method','twostage');

%delete(h);

%h = viscircles(centers,radii);
%[centers, radii] = imfindcircles(red,[20 25], 'ObjectPolarity','bright', ...
 %        'Sensitivity',0.9,'Method','twostage');

%delete(h);

%viscircles(centers,radii);
%[centersBright, radiiBright] = imfindcircles(red,[20 25],'ObjectPolarity', ...
 %   'bright','Sensitivity',0.92);
%delete(h);
%viscircles(centersBright,radiiBright);
%imshow(rgb);

%hBright = viscircles(centersBright, radiiBright,'Color','b');
%[centersBright, radiiBright, metricBright] = imfindcircles(h,[20 25], ...
%   'ObjectPolarity','bright','Sensitivity',0.92,'EdgeThreshold',0.25);

%delete(hBright);

%hBright = viscircles(centersBright, radiiBright,'Color','b');