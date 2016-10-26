%Thresholding

clc;
clear all;
close all;

%load spine;
load clown; 
image(X);

[m,n]=size(X);

xlabel('amplitude');
ylabel('amplitude');
title('Original Image');

z=max(max(X));
l=z/2;

for i=1:m
    for j=1:n
           if X(i,j)>=l
               k(i,j)=l;
           else
               k(i,j)=0;
           end
           
              
    end
end


figure
image(k);

xlabel('amplitude');
ylabel('amplitude');
title('Thresholding of an Image');
