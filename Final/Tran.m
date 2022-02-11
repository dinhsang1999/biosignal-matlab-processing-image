clear all; close all; clc;
rgb = imread('shape_color.jpg');
%rgb=imread('shapes2b.jpg');
imshow(rgb), impixelinfo;
%chuyen sang gray scale
I=rgb2gray(rgb);
%edge detection with Canny
bw=edge(I,'canny');

%get rid of noise of less than 15 pixel
bw = bwareaopen(bw,10); %loc noise trong khoang cach 30 pixel

%fill any hole to complete a shape
bw = imfill(bw,'holes'); %fill hinh

%dien tich do matlab
%lay centroid
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
    dim_boundary = size(b); 
    
    %Calculate the khoang cach tu centroid to each point at the boundaries
    for i=1:dim_boundary(1)
        khoangcach{k}(1,i) = sqrt ((b(i,2) - s(k).Centroid(1))^2 + (b(i,1) - s(k).Centroid(2))^2 );
    end 
    
    %detemine the max and min khoang cach
    a=max(khoangcach{k});
    b=min(khoangcach{k});
    
    %get the area from the prop command
    %this is the area based on the number of pixels in the shape
    c=dt(k).Area;
    d=cv(k).Perimeter;

    %dien tich
    %pi*R^2
    tron = round(pi*a^2);
    h = a *3.0/2;
    tamgiac = round(h^2/sqrt(3));
    chuvi_tamgiac = 3*(2/sqrt(3))*(3/2)*a;   
    vuong = (2*b)^2;
    chuvi_vuong = 4*(2*b);
    b2chunhat = sqrt(a^2-b^2);
    chunhat = (2*b)*(2*b2chunhat);
    chuvi_chunhat = 2*(2*b + 2*b2chunhat);
    
     %CIRCLES
     if ((abs(c-tron)/c)<0.1)
           text(s(k).Centroid(1),s(k).Centroid(2),'circle')
            %fprintf('cirle')
            continue
     end
     
     %SQUARE
     canh_square=round(d/4);
     square=round(canh_square*canh_square);
     othercanh_square= 2*sqrt(a*a-b*b);
     if ((abs(square-c)/c < 0.15) && (abs(othercanh_square-canh_square)/othercanh_square <0.1))
         text(s(k).Centroid(1),s(k).Centroid(2),'square')
         continue
     end
     %RHOMBUS
     q = sqrt(a^2 - b^2);
     f = a^2/q;
     e = sqrt(f^2 - a^2);
     thoi_1 = 2*a*2*e;
     thoi_2 = b*d/2
     chuvi_1 = 4 * f;
     v=d/4;
     if ((abs(c-thoi_2)/c < 0.105) && (abs(d-chuvi_1)/d < 0.15) && (abs(d-chuvi_1)/d < 0.15) && (abs(v-f)/v < 0.13))
            text(s(k).Centroid(1),s(k).Centroid(2),'rhombus')
            continue
     end
     
     %%PENTAGON
     canh=round(d/5);
    canh2=round(2*sqrt(a^2-b^2));
    chuvi=canh*5;
    chuvi2=canh2*5;
    dientich=5*canh*b/2;
    dientich2=5*canh2*b/2;
     if (abs(dientich-c)/c<0.1 && abs(chuvi2-d)/d<0.15 && abs(chuvi-d)/d<0.1 && abs(dientich2-c)/c<0.1)   
         text(s(k).Centroid(1),s(k).Centroid(2),'PENTAGON')
         continue
     end
     
     %HEXAGON
     lucgiac = (6.0/2)*(a^2)*sin(2*pi/6);
     chuvi_lucgiac = 6*2*sqrt(a^2-b^2);
     if ((abs(c-lucgiac)/c < 0.15))
          if ((abs(d - chuvi_lucgiac)/d) < 0.15)
            text(s(k).Centroid(1),s(k).Centroid(2),'hexagon')
            continue
         end
     end
     

     %SQUARE
     if ((abs(c-vuong)/c < 0.15))
        if ((abs(d - chuvi_vuong)/d) < 0.15)
            text(s(k).Centroid(1),s(k).Centroid(2),'square');
            fprintf('square');
            continue
        end
     end
     
     %RECTANGLE
     if ((abs(c-chunhat)/c < 0.1))
        if ((abs(d - chuvi_chunhat)/d) < 0.1)
            text(s(k).Centroid(1),s(k).Centroid(2),'rectangle');
            %fprintf('rectangle');
            continue
        end
     end
     
     %%tam giac
    canh_tamgiac=round(d/3);
    S_tamgiac= round(canh_tamgiac*(a+b)/2);
    pytago_tamgiac = sqrt(a*a-b*b)
    canh2_tamgiac = canh_tamgiac/2;
     if ((abs(S_tamgiac-c)/c <0.15) && (abs(pytago_tamgiac-canh2_tamgiac)/canh2_tamgiac < 0.15))
         text(s(k).Centroid(1),s(k).Centroid(2),'TRIANGLE')
         continue
     end  
     
     %ELLIPSE
     elip = pi*a*b;
     chuvi_elip = 2*pi*sqrt((a^2+b^2)/2);
     if ((abs(c-elip)/c < 0.2))
          if ((abs(d - chuvi_elip)/d) < 0.2)
            text(s(k).Centroid(1),s(k).Centroid(2),'ellipse')
            continue
         end
     end 
end
     
     
     
     
     
  
%{
hold on
s  = regionprops(bw, 'centroid');
dim = size(s);
for k=1:dim(1)
    %(s(k).Centroid(1), s(k).Centroid(1)
    y = round(s(k).Centroid(1));
    x = round(s(k).Centroid(2));
    red = rgb(x,y,1);
    green = rgb(x,y,2);
    blue = rgb(x,y,3);
    fprintf('red: %d \n green: %d \n blue: %d\n', red, green, blue);
    color = 'identifying';
    color_threshold = 0.5;
    reverse_color_threshold = 1 - color_threshold;
    if (red > color_threshold*255) &&  (green < reverse_color_threshold*255) && (blue < reverse_color_threshold*255)
        color = 'red';
    end
    if (red > color_threshold*255) &&  (green > color_threshold*255) && (blue < reverse_color_threshold * 255)
        color = 'yellow';
    end
    if (red < reverse_color_threshold*255) &&  (green > color_threshold*255) && (blue < reverse_color_threshold * 255)
        color = 'green';  
    end
    if (red < reverse_color_threshold*255) &&  (green < reverse_color_threshold*255) && (blue > color_threshold * 255)
        color = 'blue';  
    end
    %if (red > 0.5*255) &&  (green > 0.5*255) && (blue > 0.5 * 255)
    %    color = 'white';  
    %end
    
    text(s(k).Centroid(1),s(k).Centroid(2) - 100,color)
end
%}