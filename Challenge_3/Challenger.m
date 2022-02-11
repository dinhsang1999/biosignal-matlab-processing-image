clc
close all
clear all
%%Auto clear
I = imread('111.jpg');
%Show original image
figure,imshow(I),impixelinfo
gray=rgb2gray(I);
%Show index
figure,imshow(gray),impixelinfo
%pull hist to left(dark)
f2=gray-40
figure,imshow(f2)
%pull 'binary' image
E=150;
m=190;
g = 1./(1 + (m./(double(f2) + eps)).^E) ;
figure
imshow(g)
%denoise
g = imbinarize(g);
g = bwareaopen(g,5);
figure,imshow(g)
%expand
se90 = strel('line', 20, 2000);
se0 = strel('line', 20, 1400);
BWsdil = imdilate(g, [se90 se0]);
figure, imshow(BWsdil)
%Fill
BWdfill = imfill(BWsdil, 'holes');
figure, imshow(BWdfill);
%denoise
g = bwareaopen(BWdfill,1000);
figure,imshow(g),impixelinfo
%%link 2 block
for i=570:580
    for j=490:500
        g(j,i)=1;
    end
end
%%
figure,imshow(g),impixelinfo
%%
[B,L] = bwboundaries(g,'noholes');
stats = regionprops(L,'Area','Centroid');
%%draw cover
figure,imshow(I);
hold on;
for i = 1:length(B)
    boundary =B{i};
    plot(boundary(:,2), boundary(:,1),'r','LineWidth',2)
end
%%denoise again
g = bwareaopen(g,10000);
figure,imshow(g),impixelinfo
%%
figure,imshow(g),impixelinfo
%%got B
[B,L] = bwboundaries(g,'noholes');
stats = regionprops(L,'Area','Centroid');
%%draw cover 2
figure,imshow(I);
hold on;
for i = 1:length(B)
    boundary =B{i};
    plot(boundary(:,2), boundary(:,1)+5,'r','LineWidth',2)
end
figure,imshow(I);
hold on;
statsB = regionprops(L,'BoundingBox');
for k = 1 : length(statsB)
  BB = statsB(k).BoundingBox;
  rectangle('Position', [BB(1),BB(2),BB(3),BB(4)],...
  'EdgeColor','r','LineWidth',1 )
end
