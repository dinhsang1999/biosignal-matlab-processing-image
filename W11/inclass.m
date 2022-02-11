load mri
I = ind2gray(D(:,:,17),map)

h_unsharp = fspecial('unsharp',.5);
I_unsharp = imfilter(I,h_unsharp);
    
Edge_1=edge(I_unsharp,'sobel',0.4);
Edge_2=edge(I_unsharp,'canny',0.15);
Edge_3=edge(I_unsharp,'prewitt',0.4);

subplot(2,2,1); 
imshow(I);
title('');
subplot(2,2,2);
imshow(Edge_1);
title('');
subplot(2,2,3);
imshow(Edge_2);
title('');
subplot(2,2,4);
imshow(Edge_3);
title('');



