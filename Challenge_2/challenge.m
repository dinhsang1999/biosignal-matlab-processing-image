clc
close all
clear all
%%Auto clear
I = imread('800wm.jpg');
%Show original image
figure,imshow(I),impixelinfo
%%grayscale
gray=rgb2gray(I);
%Show index
figure,imshow(gray),impixelinfo
%%Injust image
g3 = imadjust(gray,[0.5 0.75],[0 1],3);
figure,imshow(g3),impixelinfo
%%grayscale->Binary 
g = imbinarize(g3);
%%fill up
BWdfill = imfill(g, 'holes');
figure, imshow(BWdfill)
%denoise
g = bwareaopen(g,3000);
figure,imshow(g)
%fill up
BWdfill = imfill(g, 'holes');
figure, imshow(BWdfill),impixelinfo
%smooth(denoise)
seD = strel('diamond',1);
BWdfill = imerode(BWdfill,seD);
BWfinal = imerode(BWdfill,seD);
figure, imshow(BWdfill),
%rgb = label2rgb(BWdfill,'jet',[.5 .5 .5]);
%figure,imshow(rgb)
%%Denoise by watershed()
 D = bwdist(~BWdfill);
 figure,imshow(D,[])
 %
 D = -D;
 figure,imshow(D,[])
 %
 L = watershed(D);
 L(~BWdfill) = 0;
 %
 figure,imshow(L),impixelinfo
 %%Denoise
 L = imbinarize(L);
 figure,imshow(L),impixelinfo
 %%Mask 
 [r c] =size(BWdfill);
 for i = 1:r
    for j= 1:c
        if L(i,j) == 1
           BWdfill(i,j) = 0;
        end
    end
 end
%
figure,imshow(BWdfill),impixelinfo
%%denoise again
g = bwareaopen(BWdfill,1000);
figure,imshow(g)
%%Expand
se90 = strel('line', 3, 90);
se0 = strel('line', 3, 0);
%
g = imdilate(g, [se90 se0]);
figure, imshow(g)
%%draw cover
figure,imshow(I)
[B,L] = bwboundaries(g,'noholes');
hold on;
for i = 1:length(B)
    boundary =B{i};
    plot(boundary(:,2), boundary(:,1),'r','LineWidth',2)
end
%draw boundingbox
hold on;
statsB = regionprops(L,'BoundingBox');
for k = 1 : length(statsB)
  BB = statsB(k).BoundingBox;
  rectangle('Position', [BB(1),BB(2),BB(3),BB(4)],...
  'EdgeColor','r','LineWidth',1 )
end