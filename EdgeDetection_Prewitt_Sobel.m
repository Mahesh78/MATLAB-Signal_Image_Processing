% Edge Detection

%(a) Prewitt's Operator---> Horizontal

clc;
clear all;
close all;

load clown;
figure()
image(X);
title('Original Image');

[m,n]=size(X);
D=[-1,-1,-1;0,0,0;1,1,1];
T=('Enter the value of threshold')

for i=1:m-2
    for j=1:n-2
        Y(i,j)=X(i,j)*D(1,1)+X(i,j+1)*D(1,2)+X(i,j+2)*D(1,3)+X(i+1,j)*D(2,1)+X(i+1,j+1)*D(2,2)+X(i+1,j+2)*D(2,3)+X(i+2,j)*D(3,1)+X(i+2,j+1)*D(3,2)+X(i+2,j+2)*D(3,3);
        
        if Y(i,j)>T
            R(i,j)=Y(i,j);
        end
    end
end

figure
image(R);
title('Modified Image');



% Prewitt's Operator---> Vertical

clc;
clear all;
close all;

load clown;
figure()
image(X);
title('Original Image');

[m,n]=size(X);
D=[-1,0,1;-1,0,1;-1,0,1];
T=('Enter the value of threshold')

for i=1:m-2
    for j=1:n-2
        Y(i,j)=X(i,j)*D(1,1)+X(i,j+1)*D(1,2)+X(i,j+2)*D(1,3)+X(i+1,j)*D(2,1)+X(i+1,j+1)*D(2,2)+X(i+1,j+2)*D(2,3)+X(i+2,j)*D(3,1)+X(i+2,j+1)*D(3,2)+X(i+2,j+2)*D(3,3);
        
        if Y(i,j)>T
            R(i,j)=Y(i,j);
        end
    end
end

figure
image(R);
title('Modified Image');

%(b) Sobel Operator---> Horizontal

clc;
clear all;
close all;

load clown;
figure()
image(X);
title('Original Image');

[m,n]=size(X);
D=[-1,-2,-1;0,0,0;1,2,1];
T=('Enter the value of threshold')

for i=1:m-2
    for j=1:n-2
        Y(i,j)=X(i,j)*D(1,1)+X(i,j+1)*D(1,2)+X(i,j+2)*D(1,3)+X(i+1,j)*D(2,1)+X(i+1,j+1)*D(2,2)+X(i+1,j+2)*D(2,3)+X(i+2,j)*D(3,1)+X(i+2,j+1)*D(3,2)+X(i+2,j+2)*D(3,3);
        
        if Y(i,j)>T
            R(i,j)=Y(i,j);
        end
    end
end

figure
image(R);
title('Modified Image');


% Sobel Operator---> Vertical

clc;
clear all;
close all;

load clown;
figure()
image(X);
title('Original Image');

[m,n]=size(X);
D=[-1,0,1;-2,0,2;-1,0,1];
T=('Enter the value of threshold')

for i=1:m-2
    for j=1:n-2
        Y(i,j)=X(i,j)*D(1,1)+X(i,j+1)*D(1,2)+X(i,j+2)*D(1,3)+X(i+1,j)*D(2,1)+X(i+1,j+1)*D(2,2)+X(i+1,j+2)*D(2,3)+X(i+2,j)*D(3,1)+X(i+2,j+1)*D(3,2)+X(i+2,j+2)*D(3,3);
        
        if Y(i,j)>T
            R(i,j)=Y(i,j);
        end
    end
end

figure
image(R);
title('Modified Image');

