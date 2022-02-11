clc
close all
clear all
%
rgb = imread('findcircle.jpg');
figure,imshow(rgb), impixelinfo 
%
rgb_h = rgb2hsv(rgb);
gray=rgb2gray(rgb);
%figure,imshow(rgb_h), impixelinfo
%figure,imshow(gray), impixelinfo 
%
r = rgb_h(:,:,1);
s = rgb_h(:,:,2);
v = rgb_h(:,:,3);
%
%figure,imshow(r), impixelinfo 
%figure,imshow(s), impixelinfo 
%figure,imshow(v), impixelinfo 
%
[m n] =size(r); 
%
for i = 1:m 
    for j= 1:n
       if (r(i,j) >= 0.55 && r(i,j) <= 0.59)
           out(i,j) = 255; 
       else
           out(i,j) = 0;	
       end
    end
end
%figure,imshow(out)
out = bwareaopen(out,50);
out = imfill(out,'holes');
%figure,imshow(out)
%%
bw=out;
D = bwdist(~bw);
D = -D;
%%
L = watershed(D);
L(~bw) = 0;
%figure,imshow(L)
L = bwareaopen(L,20);
%rgb = label2rgb(L,'jet',[.5 .5 .5]);
%figure,imshow(rgb)
%%
%c  = regionprops(out, 'centroid');
stats = regionprops(L,'Centroid');
%%
bankinh=20;
for i=1:length(stats)
    center(i,1)=stats(i).Centroid(1)
    center(i,2)=stats(i).Centroid(2)
    randi(i,1)=bankinh;
end
%%
figure, imshow(rgb)
h = viscircles(center,randi,'Color','k');




