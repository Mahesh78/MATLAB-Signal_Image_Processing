% Negative of an image
clc;
clear all;
close all;
image=imread('Jellyfish.jpg');
image1=rgb2gray(image);
imshow(image1)

L=256;
[r,c]=size(image1);


for i=1:r
    for j=1:c
        for k=0:255
            
            if Y(i,j)==k-1
                S(i,j)=L-1-k;
            end
       end
    end
end

subplot 121;
imshow(Y);

subplot 122;
imshow(S);