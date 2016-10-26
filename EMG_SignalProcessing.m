clear all;
clc
Fs=1000;
x=load('datemg.txt');
emg=x;
t=0:length(x)-1/Fs;
figure(1)
plot(t,emg)

%removing 50 hz noise 
BW = 0.1/1; % Bandwidth = CutOff Frequency (0.1) / Quality Factor (1)
[bn,an] = iirnotch(0.1,0.1,1);  % bn and an are the vectors of the numerator and denominator coefficients respectively, for the filter
filt_emg = filter(bn,an,emg);
% wavelet transform
[C,L]=wavedec(filt_emg,2,'db7'); 
d2=wrcoef('d',C,L,'db7',2); 
emgg=filt_emg - d2;


% significance of zero phase filtering
Fc=3; % Cut-off frequency (from 2 Hz to 6 Hz depending to the type of your electrode)
N=4; % Filter Order
[B, A] = butter(N,Fc*2/Fs, 'low'); %filter's parameters 
EMG=filtfilt(B, A, emgg); 
EMG1=filter(B, A, emgg); 
t11=0:length(EMG)-1/Fs;
figure(2)
plot(t11,EMG)
t21=0:length(EMG1)-1/Fs;
hold on 
plot(t21,EMG1,'r')

% Band pass filter lp & hp
[b,a]=butter(7,(20/500),'high');
x2 = filtfilt(b,a,emgg);
[B1,A1]=butter(7,(450/500));
x3=filtfilt(B1,A1,x2);
t3=0:length(x3)-1;

%rectification
figure(3)
x4=abs(x3);
t4=0:length(x4)-1/Fs ;
subplot(2,1,1)
plot(t3,x3)
xlim([0 3000])
subplot(2,1,2)
plot(t4,x4)
xlim([0 3000])

% averaging
N=length(x);
h=ones(1,150)/150;
delay=15;
x5=conv(x4,h);
x5=x5(15+(1:N));
t5=0:length(x5)-1/Fs ;
figure(4)
subplot(2,1,1)
plot(t3,x3)
xlim([0 3000])
subplot(2,1,2)
plot(t5,x5)
xlim([0 3000])


% linear envelope emg
[b1,a1]=butter(6,4/500,'low');
x6=filter(b1,a1,x4);
t6=0:length(x6)-1/Fs ;
figure(5)
subplot(2,1,1)
plot(t3,x3)
xlim([0 3000])
subplot(2,1,2)
plot(t6,x6)
xlim([0 3000])

% integrated emg
x7=cumtrapz(t4,x4);
t7=0:length(x7)-1/Fs ;
figure(6)
subplot(2,1,1)
plot(t3,x3)
subplot(2,1,2)
plot(t7,x7)


% Taking FFT
fft1= fft(emg,1024);
Mag= fft1.*conj(fft1)/1024;
f= 1000/1024*(1:512);
figure(7)
plot(f,Mag(1:512))

%Median Freq
N1=length(f);
low=1;
high=N1;
mid=ceil((low+high)/2);
while ~(sum(Mag(1:mid))>=sum(Mag((mid+1):N1))&&sum(Mag(1:(mid-1)))<sum(Mag(mid:N1)))
    if sum(Mag(1:mid))<sum(Mag((mid+1):N1))
        low=mid;
        else
        high=mid;
    end
         mid=ceil((low+high)/2);
end
disp(['Median freq = ' num2str(mid)]);


