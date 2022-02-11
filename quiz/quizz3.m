orig = imread ('convikhuan.jpg') ;
orig = immultiply(orig,1.2);
grayscale1 = rgb2gray ( orig ) ;
figure(1);
imshow (grayscale1);
k_v = [ -1 0 1; -2 0 2; -1 0 1];
k_h = [-1 -2 -1; 0 0 0; 1 2 1];
M1 = conv2 ( double ( grayscale1 ) , double ( k_v ) ) ;
M2 = conv2 ( double ( grayscale1 ) , double ( k_h ) ) ;
figure(2);
imshow (( M1 .^2+ M2 .^2) .^0.5 , []) ;
grayscale2 = ( M1 .^2+ M2 .^2) .^0.5
M1 = conv2 ( double ( grayscale2 ) , double ( k_v ) ) ;
M2 = conv2 ( double ( grayscale2 ) , double ( k_h ) ) ;
figure(3);
imshow (( M1 .^2+ M2 .^2) .^0.5 , []) ;

