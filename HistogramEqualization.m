%Histogram Equalization
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
for i=1:256
    y(i)=co(i)/(r*c);
end
sum(1)=y(1);
for i=2:256
    sum(i)=sum(i-1)+y(i);
end
bar(sum,0.05,'r');
for i=1:r
    for j=1:c
        for k=1:256
            if image(i,j)==k-1
                image1(i,j)=sum(k)*k;
            end
        end
    end
end
imshow(image1)
