clc;
clear all;
close all;
image=imread('Jellyfish.jpg');
image1=rgb2gray(image);
imshow(image1)
[r,c]=size(image1);


for i=1:r
    for j=1:c
        
        D(j,i)=Y(i,j);
    end
end

subplot 121;
imshow(Y);

subplot 122;
imshow(D);