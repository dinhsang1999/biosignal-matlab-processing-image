clc
close all
clear all

I = imread('cancercell2.jpg');
figure, imshow(I),title('original image');

gray=rgb2gray(I);
figure, imshow(gray),title('grayscale');

[~, threshold] = edge(gray, 'sobel');
fudgeFactor = .5;
BWs = edge(gray,'sobel', threshold * fudgeFactor);
figure, imshow(BWs), title('binary gradient mask');

se90 = strel('line', 3, 90);
se0 = strel('line', 3, 0);

BWsdil = imdilate(BWs, [se90 se0]);
figure, imshow(BWsdil), title('dilated gradient mask');

BWdfill = imfill(BWsdil, 'holes');
figure, imshow(BWdfill);
title('binary image with filled holes');

BWnobord = imclearborder(BWdfill, 4);
figure, imshow(BWnobord), title('cleared border image');

seD = strel('diamond',1);
BWfinal = imerode(BWnobord,seD);
BWfinal = imerode(BWfinal,seD);
figure, imshow(BWfinal), title('segmented image');

[B,L] = bwboundaries(BWfinal,'noholes');
figure,imshow(label2rgb(L, @jet, [.5 .5 .5]));

stats = regionprops(L,'Area','Centroid');

for i=1:length(stats)
    if stats(i).Area >10000
        text(stats(i).Centroid(1),stats(i).Centroid(2),'Cancer')
    end
end

