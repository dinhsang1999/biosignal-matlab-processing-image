I=imread('shapes.gif');
BW1=imbinarize(I);
BW2 = BW1;
figure(1); imshow(BW2);
[B2,L2] = bwboundaries(BW2,'noholes');
figure(2);
imshow(label2rgb(L2, @jet, [.5 .5 .5]));
hold on;

for k = 1:length(B2)
  boundary = B2{k};
  plot(boundary(:,2), boundary(:,1), 'w', 'LineWidth', 2)
end

figure(3);
imshow(label2rgb(L2, @jet, [.5 .5 .5]));
hold on;
stats = regionprops(L2,'Area','Centroid');
threshold = 0.90;

for k = 1:length(B2)
  boundary = B2{k};
  delta_sq = diff(boundary).^2;    
  perimeter = sum(sqrt(sum(delta_sq,2)));
  area = stats(k).Area;
  metric = 4*pi*area/perimeter^2;
  if metric > threshold && metric<=1
    plot(boundary(:,2), boundary(:,1), 'w', 'LineWidth', 2);
  end
end

figure(4);
imshow(label2rgb(L2, @jet, [.5 .5 .5]));
title('Circle');
hold on;
threshold = 0.95;

for k = 1:length(B2)
  boundary = B2{k};
  delta_sq = diff(boundary).^2;    
  perimeter = sum(sqrt(sum(delta_sq,2)));
  area = stats(k).Area;
  metric = (area/(sqrt(3)*0.25))/((perimeter^2)/9);
  if metric > threshold && metric<=1
    plot(boundary(:,2), boundary(:,1), 'w', 'LineWidth', 2);
  end
end
title('Triangle');

[B1,L1] = bwboundaries(BW1,'noholes');
figure(5);
imshow(label2rgb(L1, @jet, [.5 .5 .5]));
hold on;
for k = 1:length(B1)
  boundary = B1{k};
  plot(boundary(:,2), boundary(:,1), 'w', 'LineWidth', 2)
end
title('Square');

figure(6);
stats1 = regionprops(L2,'BoundingBox');
imshow(label2rgb(L2, @jet, [.5 .5 .5]));
hold on;
threshold = 0.9;

for k = 1:numel(stats1)
    boundary = B2{k};
  area = stats(k).Area;
  BoundingBox=stats1(k).BoundingBox;
  metric=area/(BoundingBox(3)*BoundingBox(4));
  if metric > threshold && metric<=1
      plot(boundary(:,2), boundary(:,1), 'w', 'LineWidth', 2);
  end
end
title('Rectangular');







