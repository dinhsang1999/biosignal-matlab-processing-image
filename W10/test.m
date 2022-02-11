clc
close all
clear all
%%
[X,cmap] = imread('shapes.gif');
rgb = ind2rgb(X,cmap);
figure,imshow(rgb),impixelinfo
gray=rgb2gray(rgb);
figure,imshow(gray),impixelinfo
%%red = gray(:, :, 1);
%green = gray(:, :, 2);
%blue = gray(:, :, 3);
%%
[r c] =size(gray);
for i = 1:r 
    for j= 1:c
       if gray(i,j) > 0.49 && gray(i,j) < 0.5 %màu cam,hình vuông
           out_square(i,j) = 255;
       elseif gray(i,j) > 0.72 && gray(i,j) < 0.74
           out_elip(i,j)= 255;
       else 
           out_square(i,j) = 0;
           out_elip(i,j) = 0;
       end
    end
end
%%
[B_square,L_square] = bwboundaries(out_square,'noholes');
[B_elip,L_elip] = bwboundaries(out_elip,'noholes')    
%figure,imshow(label2rgb(L, @jet, [.5 .5 .5]))
stats_square = regionprops(L_square,'Area','Centroid');
stats_elip = regionprops(L_elip,'Area','Centroid');
position=[];
for i = 1:length(stats_square)
    position = vertcat(position,stats_square(i).Centroid);
    
end
%Elip
for i = 1:length(stats_elip)
    position = vertcat(position,stats_elip(i).Centroid);
end
%%
figure,imshow(rgb)
%%
for i = 1:3
    text(position(i,1),position(i,2),'S')
end
%%
for i = 4:7
    text(position(i,1),position(i,2),'E')
end
    

