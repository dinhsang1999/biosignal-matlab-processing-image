clc
close all
clear all
%%
I = imread('cancercell_challenge.jpg');
figure,imshow(I),impixelinfo
gray=rgb2gray(I); 
%show "index"
figure,imshow(gray),impixelinfo
%I saw different from cell cancers, they have "index" < 100. 
%%Scan pixels of image
[r c] =size(gray);
 for i = 1:r 
    for j= 1:c
        if gray(i,j) < 100 
           out(i,j) = 255;
        else
           out(i,j) = 0;      
        end
    end
 end
 %%Separation of adherent cells
 figure,imshow(out)
 %
 D = bwdist(~out);
 figure,imshow(D,[])
 
 %
 D = -D;
 figure,imshow(D,[])
 %
 L = watershed(D);
 L(~out) = 0;
 %
 rgb = label2rgb(L,'jet',[.5 .5 .5]);
 figure,imshow(rgb)
 %%
 [B,Li] = bwboundaries(L,'noholes');
 stats = regionprops(Li,'Area','Centroid');
 %%stick "X"
 figure,imshow(I);
 for i = 1:length(stats)
    text(stats(i).Centroid(1)-2.5,stats(i).Centroid(2),'X','FontSize',10)
 end
%%draw cover
figure,imshow(I);
hold on;
for i = 1:length(B)
    boundary =B{i};
    plot(boundary(:,2), boundary(:,1),'w','LineWidth',2)
 end

%%draw boundingBox
figure,imshow(I);
hold on;
statsB = regionprops(Li,'BoundingBox');
for k = 1 : length(statsB)
  BB = statsB(k).BoundingBox;
  rectangle('Position', [BB(1),BB(2),BB(3),BB(4)],...
  'EdgeColor','r','LineWidth',1 )
end

