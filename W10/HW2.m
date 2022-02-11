
clc
close all
clear all
%clear auto, ?? ph?i xóa tay
rgb = imread('coloredChips.png');
figure,imshow(rgb), impixelinfo %cho nó hi?n thông s? ? d??i cái hình show ra ý,
%vào figure m?i xu?t ra, ??a con tr? vào hình, nhìn vào góc trái bên d??i
%là hi?u.
%%
rgb_h = rgb2hsv(rgb);
figure,imshow(rgb_h)
red = rgb_h(:,:,1);
s = rgb_h(:,:,2);
v = rgb_h(:,:,3);
figure,imshow(red)
figure,imshow(s)
figure,imshow(v)
%??i vài h? màu ?? phân vùng màu cho d? detect color
%nh?n th?y ? kênh ??u tiên c?a h? màu hsv, màu ?? khác bi?t v?i các màu còn
%l?i, figure(3)
[r c] =size(red); % l?y height vs weight c?a ?nh
for i = 1:r %quét t?ng pixel
    for j= 1:c
       if red(i,j) >= 0.9 %tùy index ? ?nh mà thay ??i cho h?p lí
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