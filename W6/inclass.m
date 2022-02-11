i=imread('peppers.png');
%%a=Rgb2gray(i);
red=i(:,:,1);
green=i(:,:,2);
blue=i(:,:,3);

gray=0.2989*red+0.5870*green+0.1140*blue;

