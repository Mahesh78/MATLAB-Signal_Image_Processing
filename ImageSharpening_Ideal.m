%Image sharpening in Frequecy domain(ideal)

clc;
clear all;
close all;

load clown;
image(X);

[m,n]=size(X);

xlabel('amplitude');
ylabel('amplitude');
title('Original Image');

y=fft2(X);
d0=200;

for i=1:m
    for j=1:n
            D(i,j)=sqrt((i*i)+(j*j));
            
            if D(i,j)<=d0
                H(i,j)=0;
            else
                H(i,j)=1;
            end
            k(i,j)=H(i,j)*y(i,j);
              
    end
end

z=abs(ifft2(k));

figure
image(z);

xlabel('amplitude');
ylabel('amplitude');
title('Sharpened Image');
