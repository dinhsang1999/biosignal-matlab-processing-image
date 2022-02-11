clc
close all
clear all
%%Auto clear
I = imread('800wm.jpg');
%Show original image
figure,imshow(I),impixelinfo
gray=rgb2gray(I);
%Show index
figure,imshow(gray),impixelinfo
%%
g3 = imadjust(gray,[0.5 0.75],[0 1],3);
figure,imshow(g3),impixelinfo
g = imbinarize(g3);
BWdfill = imfill(g, 'holes');
figure, imshow(BWdfill),impixelinfo
g = bwareaopen(g,3000);
figure,imshow(g)
BWdfill = imfill(g, 'holes');
figure, imshow(BWdfill),impixelinfo
seD = strel('diamond',1);
BWfinal = imerode(BWdfill,seD);
BWfinal = imerode(BWfinal,seD);
figure, imshow(BWfinal),