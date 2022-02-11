load mri
I = ind2gray(D(:,:,17),map)

h_unsharp = fspecial('unsharp',.5);
I_unsharp = imfilter(I,h_unsharp);

h_s = fspecial('Sobel');
I_sobel_horin = imfilter(I,h_s);
I_sobel_vertical = imfilter(I,h_s');

I_sobel_combined = im2bw(I_sobel_horin)|im2bw(I_sobel_vertical)
subplot(2,2,1); 
imshow(I);
title('Original');
subplot(2,2,2);
imshow(I_unsharp);
title('Unsharp');
subplot(2,2,3);
imshow(I_sobel_horin);
title('Horizontal Sobel');
subplot(2,2,4);
imshow(I_sobel_combined);
title('Combined Image');



