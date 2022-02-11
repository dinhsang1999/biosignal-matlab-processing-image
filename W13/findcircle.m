rgb=imread('2.jpg');
imshow(rgb)
%chuyen sang gray scale
a=rgb2gray(rgb);
%edge detection with Canny
bw=edge(a,'canny');

%get rid of noise of less than 15 pixel
bw = bwareaopen(bw,30); %loc noise trong khoang cach 30 pixel

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
    dim = size(b);
    
    %Calculate the khoang cach tu centroid to each point at the boundaries
    for i=1:dim(1)
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
          
     if ((abs(c-tron)/c)<0.1)
            text(s(k).Centroid(1),s(k).Centroid(2),'circle')
     end
end
  