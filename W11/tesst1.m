clc 
close all 
clear all
I = imread('rice.png');
imshow(I)
background = imopen(I,strel('disk',15));
I2 = I - background;
imshow(I2)
I3 = imadjust(I2);
imshow(I3);
level = graythresh(I3);
bw = im2bw(I3,level);
bw = bwareaopen(bw, 50);
%bw = imfill(bw,'holes');
imshow(bw)
cc = bwconncomp(bw, 4)
%cc.NumObjects
%%
graindata = regionprops(cc, 'basic')
grain = false(size(bw));
%%% This is ANswer
for i = 1:length(graindata)
    if graindata(i).Area > 300
        grain(cc.PixelIdxList{i}) = true; 
    end
end
%%%
imshow(grain)

