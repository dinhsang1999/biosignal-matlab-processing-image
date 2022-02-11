original = imread( 'pepper_noise.jpg' ) ;
grayscale = rgb2gray( original ) ;
figure (1) ;
imshow ( original ) ;
figure (2) ;
imshow ( grayscale ) ;
noisyImage = imnoise ( grayscale , 'salt & pepper' ) ;
figure (4) ;
imshow ( noisyImage ) ;
h = fspecial ( 'gaussian' , [24 24] , 3 ) ;
M = conv2 ( double( grayscale ) , double( h ) ) ;
figure (3) ;
imshow (( M .^2) .^0.5 , []) ;


