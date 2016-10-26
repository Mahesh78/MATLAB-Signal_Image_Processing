% Image smoothening in Spatial Domain
clc;
clear all;
close all;

load clown;
image(X);

[m,n]=size(X);

xlabel('amplitude');
ylabel('amplitude');
title('Original Image');

for i=2:m-1
    for j=2:n-1
        Y(i,j)=(0.29*(X(i-1,j-1)+X(i-1,j)+X(i-1,j+1)+X(i,j-1)+X(i,j)+X(i,j+1)+X(i+1,j-1)+X(i+1,j)+X(i+1,j+1)))/9;
    end
end

figure
image(Y);

xlabel('amplitude');
ylabel('amplitude');
title('Smoothened Image');
