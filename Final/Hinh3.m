clear all
clc
close all
rgb=imread('shape_color.jpg');
gray=rgb2gray(rgb);
figure,imshow(gray),impixelinfo
%%  
a=gray;
[r c] =  size(a);
for i=0:255
    count(i+1,1)=i;
    count(i+1,2)=0;
end
for i=1:r
    for j=1:c
        for k=1:256
           if (a(i,j) == count(k,1))
               count(k,2) = count(k,2)+1;
           end
        end
    end
end
maxindex = max(count(:,2))
for i=1:256
    if (count(i,2) == maxindex)
        fmaxpixel = count(i,1);
        break
    end
end
threshold = 30;
for i=1:r
    for j=1:c
        if (fmaxpixel >= 150)
            if (a(i,j) >= fmaxpixel-threshold)
                a(i,j) = fmaxpixel;
            end
        else
            if (a(i,j) <= fmaxpixel+threshold)
                a(i,j) = fmaxpixel;
            end
        end
    end
end                                               
for i=1:r
    for j=1:c
        if (a(i,j) == fmaxpixel)
            out(i,j)=0;
        else
            out(i,j)=255;
        end
    end
end
%%
out = bwareaopen(out,50);
out = imfill(out,'holes');
%figure,imshow(out);
%figure,imshow(rgb);
%%
s  = regionprops(out, 'centroid');
%lay area
dt  = regionprops(out, 'area');
%lay perimeter
cv = regionprops(out, 'perimeter');
dim = size(s);
%lay boundaries X,Y
boundaries = bwboundaries(out);
for k=1:dim(1)
    b= boundaries{k};
    dim = size(b);
    other=true;
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
            text(s(k).Centroid(1),s(k).Centroid(2),'CIRCLE')
            other=false
     end
    %%tam giac
    canh_tamgiac=round(d/3);
    S_tamgiac= round(canh_tamgiac*(a+b)/2);
    pytago_tamgiac = sqrt(a*a-b*b)
    canh2_tamgiac = canh_tamgiac/2;
     if ((abs(S_tamgiac-c)/c <0.15) && (abs(pytago_tamgiac-canh2_tamgiac)/canh2_tamgiac < 0.15))
         text(s(k).Centroid(1),s(k).Centroid(2),'TRIANGLE')
         other=false;
     end
     %SQUARE
     canh_square=round(d/4);
     square=round(canh_square*canh_square);
     othercanh_square= 2*sqrt(a*a-b*b);
     if ((abs(square-c)/c < 0.15) && (abs(othercanh_square-canh_square)/othercanh_square <0.1))
         text(s(k).Centroid(1),s(k).Centroid(2),'SQUARE')
         other=false;
     end
     %%RECTANGLE
     canhdai_rectangle=round(2*sqrt(a*a-b*b))
     canhngan_rectangle=round((d-2*canhdai_rectangle)/2);
     canhngan_rectangle2=round(2*b);
     canhdai_rectangle2=round((d-2*canhngan_rectangle2)/2);
     dientich_rectangle=round(canhdai_rectangle*canhngan_rectangle);
     dientich_rectangle2=round(canhdai_rectangle*canhngan_rectangle2);
     if ((abs(dientich_rectangle-c)/c < 0.39) && (canhdai_rectangle/canhngan_rectangle>1) && (abs(dientich_rectangle2-c)/c < 0.2) && (canhdai_rectangle/canhngan_rectangle2>1) && (canhdai_rectangle2/canhngan_rectangle2>1) && (canhdai_rectangle2/canhngan_rectangle2>1) && (abs(canhdai_rectangle2-canhdai_rectangle)/canhdai_rectangle2<0.1)&&(abs(canhngan_rectangle2-canhngan_rectangle)/canhngan_rectangle2<0.3)) 
         if ((abs(square-c)/c < 0.15) && (abs(othercanh_square-canh_square)/othercanh_square <0.1))
         else
         text(s(k).Centroid(1),s(k).Centroid(2),'RECTANGLE')
         other=false;
         end
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
         text(s(k).Centroid(1),s(k).Centroid(2),'ELIP')
         other=false;
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
         text(s(k).Centroid(1),s(k).Centroid(2),'PENTAGON')
         other=false;
     end
     %%HEXAGON
    canh=round(d/6);
    canh2=round(2*sqrt(a^2-b^2));
    chuvi=canh*6;
    chuvi2=canh2*6;
    dientich=6*canh*b/2;
    dientich2=6*canh2*b/2;
     if (abs(dientich-c)/c<0.1 && abs(dientich2-c)/c<0.2 && abs(chuvi-d)/d<0.1)
         if ((abs(c-tron)/c)<0.1)
         else
         text(s(k).Centroid(1),s(k).Centroid(2),'HEXAGON')
         other=false;
         end
     end
     
     if (other==true)
         text(s(k).Centroid(1),s(k).Centroid(2),'Triangle')
     end
end
%%
hold on
s  = regionprops(out, 'centroid');
dim = size(s);
for k=1:dim(1)
    %(s(k).Centroid(1), s(k).Centroid(1)
    y = round(s(k).Centroid(1));
    x = round(s(k).Centroid(2)); 
    %
    if (gray(x,y)>= 120) && (gray(x,y)<=125)
        text(s(k).Centroid(1),s(k).Centroid(2)+10,'green')
    end
    %
    if (gray(x,y)>= 199) && (gray(x,y)<=207)
        text(s(k).Centroid(1),s(k).Centroid(2)+10,'weak pink')
    end
    %
    if (gray(x,y)>= 125) && (gray(x,y)<=127)
        text(s(k).Centroid(1),s(k).Centroid(2)+10,'strong organ')
    end
    %
    if (gray(x,y)>= 83) && (gray(x,y)<=85)
        text(s(k).Centroid(1),s(k).Centroid(2)+10,'weak  blue')
    end
    %

%%Detect color
%for k=1:length(s)
   % if (gray(round(s(k).Centroid(1)),round(s(k).Centroid(2))) >= 119) && (gray(round(s(k).Centroid(1)),round(s(k).Centroid(2))) <=125)
        %text(s(k).Centroid(1),s(k).Centroid(2)+10,'GREEN')
   % end
end