%Histogram
clc
clear all
close all
image=imread('Jellyfish.jpg');
image1=rgb2gray(image);
imshow(image1)
[r,c]=size(image1);
k=1:256;
co(k)=0;
for i=1:r
    for j=1:c
        for k=1:256
            if image1(i,j)==k-1
                co(k)=co(k)+1;
            end
        end
    end
end
bar(co,0.05,'b')
