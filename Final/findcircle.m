clear all
clc
close all
rgb=imread('shape_color.jpg');
gray=rgb2gray(rgb);
%gray=imresize(gray,0.2);
%rgb=imresize(rgb,0.2);
figure,imshow(gray),impixelinfo
[r c] =size(gray);
for i = 1:r 
    for j= 1:c
        if gray(i,j) > 134 && gray(i,j) < 136 %màu cam ??m,hình vuông
           out_1(i,j) = 255;
           %
       elseif gray(i,j) > 90 && gray(i,j) < 92 %màu cam nh?t,elip
           out_2(i,j)= 255;
           %
       elseif gray(i,j) > 125 && gray(i,j) < 127 %màu cam nh?t,elip
           out_3(i,j)= 255;
           %
       elseif gray(i,j) > 217 && gray(i,j) < 219 %màu cam nh?t,elip
           out_4(i,j)= 255;
        else
           out_1(i,j) = 0;
           out_2(i,j) = 0;
           out_3(i,j) = 0;
           out_4(i,j) = 0;
        end
    end
end
out_1 = bwareaopen(out_1,20);
out_1 = imfill(out_1,'holes');
 
out_2 = bwareaopen(out_2,20);
out_2 = imfill(out_2,'holes');
 
out_3 = bwareaopen(out_3,20);
out_3 = imfill(out_3,'holes');
 
out_4 = bwareaopen(out_4,20);
out_4 = imfill(out_4,'holes');
 
figure,imshow(out_1);
figure,imshow(out_2);
figure,imshow(out_3);
figure,imshow(out_4);
 
[B_1,L_1] = bwboundaries(out_1,'noholes');
[B_2,L_2] = bwboundaries(out_2,'noholes'); 
[B_3,L_3] = bwboundaries(out_3,'noholes');
[B_4,L_4] = bwboundaries(out_4,'noholes');
 
stats_1 = regionprops(L_1,'Centroid');
stats_2 = regionprops(L_2,'Centroid');
stats_3 = regionprops(L_3,'Centroid');
stats_4 = regionprops(L_4,'Centroid');
 
figure,imshow(rgb);
for i=1:length(stats_1)
    text(stats_1(i).Centroid(1),stats_1(i).Centroid(2),'GREEN')
end
 
for i=1:length(stats_2)
    text(stats_2(i).Centroid(1),stats_2(i).Centroid(2),'RED')
end
 
for i=1:length(stats_3)
    text(stats_3(i).Centroid(1),stats_3(i).Centroid(2),'BLUE')
end
 
for i=1:length(stats_4)
    text(stats_4(i).Centroid(1),stats_4(i).Centroid(2),'YELLOW')
end
 
for i=1:r
    for j=1:c
        if (out_1(i,j) == 0 && out_2(i,j) == 0 && out_3(i,j) == 0 && out_4(i,j) == 0)
            out(i,j)=0;
        else
            out(i,j)=255;
        end
    end
end
bw =out;
bw=bwareaopen(out,20);
imfill(out,'holes');
s  = regionprops(bw, 'centroid');
%lay area
dt  = regionprops(bw, 'area');
%lay perimeter
cv = regionprops(bw, 'perimeter');
dim = size(s);
%lay boundaries X,Y
boundaries = bwboundaries(bw);
for k=1:dim(1)
    b= boundaries{k};
    dim = size(b);
    %Calculate the khoang cach tu centroid to each point at the boundaries
    for i=1:dim(1)
        khoangcach{k}(1,i) = sqrt ((b(i,2) - s(k).Centroid(1))^2 + (b(i,1) - s(k).Centroid(2))^2 );
    end 
    %detemine the max and min khoang cach
    a=max(khoangcach{k});
    b=min(khoangcach{k});
    %get the area from the prop command
    %this is the area based on the number of pixels in the shape\
    c=dt(k).Area;
    d=cv(k).Perimeter;
    %%CIRCLE
    tron = round(pi*a^2);
     if ((abs(c-tron)/c)<0.1)
            text(s(k).Centroid(1),s(k).Centroid(2)-20,'CIRCLE')
     end
     %%tam giac
    canh_tamgiac=round(d/3);
    S_tamgiac= round(canh_tamgiac*(a+b)/2);
    pytago_tamgiac = sqrt(a*a-b*b)
    canh2_tamgiac = canh_tamgiac/2;
     if ((abs(S_tamgiac-c)/c <0.15) && (abs(pytago_tamgiac-canh2_tamgiac)/canh2_tamgiac < 0.15))
         text(s(k).Centroid(1),s(k).Centroid(2)-20,'TRIANGLE')
     end
     %SQUARE
     canh_square=round(d/4);
     square=round(canh_square*canh_square);
     othercanh_square= 2*sqrt(a*a-b*b);
     if ((abs(square-c)/c < 0.15) && (abs(othercanh_square-canh_square)/othercanh_square <0.1))
         text(s(k).Centroid(1),s(k).Centroid(2)-20,'SQUARE')
     end
     %%RECTANGLE
     canhdai_rectangle=round(2*sqrt(a*a-b*b))
     canhngan_rectangle=round((d-2*canhdai_rectangle)/2);
     canhngan_rectangle2=round(2*b);
     canhdai_rectangle2=round((d-2*canhngan_rectangle2)/2);
     dientich_rectangle=round(canhdai_rectangle*canhngan_rectangle);
     dientich_rectangle2=round(canhdai_rectangle*canhngan_rectangle2);
     if ((abs(dientich_rectangle-c)/c < 0.39) && (canhdai_rectangle/canhngan_rectangle>1) && (abs(dientich_rectangle2-c)/c < 0.2) && (canhdai_rectangle/canhngan_rectangle2>1) && (canhdai_rectangle2/canhngan_rectangle2>1) && (canhdai_rectangle2/canhngan_rectangle2>1) && (abs(canhdai_rectangle2-canhdai_rectangle)/canhdai_rectangle2<0.1)&&(abs(canhngan_rectangle2-canhngan_rectangle)/canhngan_rectangle2<0.3)) 
         text(s(k).Centroid(1),s(k).Centroid(2)-20,'RECTANGLE')
     end
     %%ELIP
     canhdai=a; 
     canhngan=b;
     landa = (a-b)/(a+b);
     dientich=a*b*pi;
     const=1+(3*(landa^2))/(10+sqrt(4-3*(landa^2)));
     chuvi= pi*(a+b)*const;
     tron = round(pi*a^2);
     if ((abs(dientich-c)/c <0.1) && (abs(chuvi-d)/d<0.013))
         if (abs(tron-c)/c<0.1)
         else
         text(s(k).Centroid(1),s(k).Centroid(2)-20,'ELIP')
         end
     end
     %%PENTAGON
     canh=round(d/5);
    canh2=round(2*sqrt(a^2-b^2));
    chuvi=canh*5;
    chuvi2=canh2*5;
    dientich=5*canh*b/2;
    dientich2=5*canh2*b/2;
     if (abs(dientich-c)/c<0.1 && abs(chuvi2-d)/d<0.1 && abs(chuvi-d)/d<0.05 && abs(dientich2-c)/c<0.05)   
         text(s(k).Centroid(1),s(k).Centroid(2)-20,'PENTAGON')
     end
     %%HEXAGON
     canh=round(d/6);
    canh2=round(2*sqrt(a^2-b^2));
    chuvi=canh*6;
    chuvi2=canh2*6;
    dientich=6*canh*b/2;
    dientich2=6*canh2*b/2;
     if (abs(dientich-c)/c<0.1 && abs(dientich2-c)/c<0.2 && abs(chuvi-d)/d<0.1)   
         text(s(k).Centroid(1),s(k).Centroid(2)-20,'HEXAGON')
     end
     
end
 
