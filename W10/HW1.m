clc
close all
clear all
%%
[X,cmap] = imread('shapes.gif');
rgb = ind2rgb(X,cmap);
figure,imshow(rgb),impixelinfo
gray=rgb2gray(rgb); %show "index"
figure,imshow(gray),impixelinfo

%%Scan pixel of image RGB
[r c] =size(gray);
for i = 1:r 
    for j= 1:c
        %% satify condition => white
       if gray(i,j) > 0.49 && gray(i,j) < 0.5 %màu cam ??m,hình vuông
           out_square(i,j) = 255;
           %
       elseif gray(i,j) > 0.72 && gray(i,j) < 0.74 %màu cam nh?t,elip
           out_elip(i,j)= 255;
           %
       elseif gray(i,j) > 0.8 && gray(i,j) < 0.81 %màu h??ng,hexagon
           out_hexagon(i,j)= 255;
           %
       elseif gray(i,j) > 0.47 && gray(i,j) < 0.48 %lá cây,hexagon
           out_circle(i,j)= 255;
           %
       elseif gray(i,j) > 0.16 && gray(i,j) < 0.17 %blue,hexagon
           out_rectangle(i,j)= 255;
           %
       elseif gray(i,j) > 0.88 && gray(i,j) < 0.89 %zang`,hexagon
           out_triangle(i,j)= 255;
           % 
       elseif gray(i,j) > 0.48 && gray(i,j) < 0.49 %rose,octagon
           out_octagon(i,j) =255;
          %%Other = Black
       else 
           out_square(i,j) = 0;
           out_elip(i,j) = 0;
           out_hexagon(i,j)= 0;
           out_circle(i,j)= 0;
           out_rectangle(i,j)= 0;
           out_triangle(i,j)= 0;
           out_octagon(i,j) =0;
       end
    end
end
%%Get BoundingBox and Area vs Centroid
[B_square,L_square] = bwboundaries(out_square,'noholes');
[B_elip,L_elip] = bwboundaries(out_elip,'noholes'); 
[B_hexagon,L_hexagon] = bwboundaries(out_hexagon,'noholes');
[B_circle,L_circle] = bwboundaries(out_circle,'noholes');
[B_rectangle,L_rectangle] = bwboundaries(out_rectangle,'noholes');
[B_triangle,L_triangle] = bwboundaries(out_triangle,'noholes');
[B_octagon,L_octagon] = bwboundaries(out_octagon,'noholes');
%%
stats_square = regionprops(L_square,'Area','Centroid');
stats_elip = regionprops(L_elip,'Area','Centroid');
stats_hexagon = regionprops(L_hexagon,'Area','Centroid');
stats_circle = regionprops(L_circle,'Area','Centroid');
stats_rectangle = regionprops(L_rectangle,'Area','Centroid');
stats_triangle = regionprops(L_triangle,'Area','Centroid');
stats_octagon = regionprops(L_octagon,'Area','Centroid');
%%A empty Matrix M by 2 
position=[];
%%Got T?a ?? c?a t?t c? centroid
%Square
for i = 1:length(stats_square)
    position = vertcat(position,stats_square(i).Centroid);
    
end
%Elip
for i = 1:length(stats_elip)
    position = vertcat(position,stats_elip(i).Centroid);
end
%Hexagon
for i = 1:length(stats_hexagon)
    position = vertcat(position,stats_hexagon(i).Centroid);
end
%circle
for i = 1:length(stats_circle)
    position = vertcat(position,stats_circle(i).Centroid);
end
%Hexagon
for i = 1:length(stats_rectangle)
    position = vertcat(position,stats_rectangle(i).Centroid);
end
%Hexagon
for i = 1:length(stats_triangle)
    position = vertcat(position,stats_triangle(i).Centroid);
end
%Octagon
for i = 1:length(stats_octagon)
    position = vertcat(position,stats_octagon(i).Centroid);
end
%%overlap on orgiginal image vs Draw 'text' to regconize shapes
figure,imshow(rgb)
%Square
next_F=length(stats_square);
for i = 1:next_F
    text(position(i,1)-5,position(i,2),'S')
end
%Elip
next_E=next_F+length(stats_elip);
for i = next_F+1:next_E
    text(position(i,1)-5,position(i,2),'E')
end
next_F=next_E;    
%Hexagon
next_E=next_F+length(stats_hexagon);
for i = next_F+1:next_E
    text(position(i,1)-5,position(i,2),'H')
end
next_F=next_E; 
%Circle
next_E=next_F+length(stats_circle);
for i = next_F+1:next_E
    text(position(i,1)-5,position(i,2),'C')
end
next_F=next_E; 
%Rectangle
next_E=next_F+length(stats_rectangle);
for i = next_F+1:next_E
    text(position(i,1)-5,position(i,2),'R')
end
next_F=next_E; 
%Triangle
next_E=next_F+length(stats_triangle);
for i = next_F+1:next_E
    text(position(i,1)-5,position(i,2),'T')
end
next_F=next_E; 
%Triangle
next_E=next_F+length(stats_octagon);
for i = next_F+1:next_E
    text(position(i,1)-5,position(i,2),'0')
end
next_F=next_E; 