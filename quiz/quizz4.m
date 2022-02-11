function Gausian(im , size , sigma , noiseType )
original = imread ( im ) ;
grayscale = rgb2gray ( original ) ;
figure (1) ;
imshow ( original ) ;
noisyImage = imnoise ( grayscale , noiseType ) ;
figure (4) ;
imshow ( noisyImage ) ;
h = fspecial ( 'gaussian ' , size , sigma ) ;
M = conv2 ( double ( grayscale ) , double ( h ) ) ;
figure (3) ;
imshow (( M .^2) .^0.5 , []) ;
end
Gausian('darkly.jpg' , [3 3] , 0.375 , 'gaussian') ;
Gausian('darkly.jpg' , [6 6] , 0.75 , 'gaussian') ;
Gausian('darkly.jpg' , [12 12] , 1.5 , 'gaussian') ;