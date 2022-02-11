clc
close all
clear all
%
rgb = imread('findcircle.jpg');
figure,imshow(rgb);
gray=rgb2gray(rgb);
BW = edge(gray,'sobel');
figure,imshow(BW);