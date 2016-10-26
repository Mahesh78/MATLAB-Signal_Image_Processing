%Image smoothening in Frequecy domain(Butterworth)

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
            
            H(i,j)=1/(1+(D(i,j)/d0)^2);
            
            k(i,j)=H(i,j)*y(i,j);
              
    end
end

z=abs(ifft2(k));

figure
image(z);

xlabel('amplitude');
ylabel('amplitude');
title('Smoothened Image');
