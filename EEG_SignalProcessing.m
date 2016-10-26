% Loading the EEG Signal;
clear all;
fs=256;
N=xlsread('eeg_data.xls',33,'A3:A2559');

l=length(N);
t=(0:l-1)/fs;
figure(1)
subplot 511
plot (t,N);
grid on;
title('Orignal Signal');

% Removal of 50Hz Noise
wo = 50/(fs/2);  bw = wo;
[b,a]=iirnotch(wo,bw);
filt1=filter(b,a,N);
subplot 512;
plot(t,filt1);
grid on;
title('After Removal Of Noise');

%wavelet decompostion;

[C,L] = wavedec(filt1,8,'db4');
a8= wrcoef('a',C,L,'db4',8);
subplot 513;
plot(t,a8);
grid on;
title('Baseline wander');

%without baseline wander;
y=filt1-a8;
subplot 514;
plot(t,y);
grid on;
hold on;
title('After removing Baseline wander');

% use of butterworth low-pass filter to remove high freq.
[m,n]=butter(6,70/128,'low');
filt2=filter(m,n,y);
subplot 515;
plot(t,filt2);
grid on;
title('Clean EEG Signal');

% Splitting the wave using wavelets

[c1,l1]=wavedec(filt2,1,'db4');

[c2,l2]=wavedec(filt2,2,'db4');

[c3,l3]=wavedec(filt2,3,'db4');

[c4,l4]=wavedec(filt2,4,'db4');
 
[c5,l5]=wavedec(filt2,5,'db4');

D2 = wrcoef('d',c2,l2,'db4',2);
D3 = wrcoef('d',c3,l3,'db4',3);
D4 = wrcoef('d',c4,l4,'db4',4);
D5 = wrcoef('d',c5,l5,'db4',5);
A5 = wrcoef('a',c5,l5,'db4',5);

figure (2)
subplot 511
plot(t,D2)
ylabel('GAMMA')

subplot 512
plot(t,D3)
ylabel('BETA')

subplot 513
plot(t,D4)
ylabel('ALPHA')

subplot 514
plot(t,D5)
ylabel('THETA')

subplot 515
plot(t,A5)
ylabel('DELTA')

% ENTROPY of each Wavelet
ENTP = [wentropy(D2,'shannon') wentropy(D3,'shannon') wentropy(D4,'shannon') wentropy(D5,'shannon') wentropy(A5,'shannon')];

% POWER of each Wavelet
pow_D2 = fft(D2,fs);
psd_D2 = pow_D2.*conj(pow_D2)/fs;
pwr_D2 = sum(psd_D2)/length(D2);

pow_D3 = fft(D3,fs);
psd_D3 = pow_D3.*conj(pow_D3)/fs;
pwr_D3 = sum(psd_D3)/length(D3);

pow_D4 = fft(D4,fs);
psd_D4 = pow_D4.*conj(pow_D4)/fs;
pwr_D4 = sum(psd_D4)/length(D4);

pow_D5 = fft(D5,fs);
psd_D5 = pow_D5.*conj(pow_D5)/fs;
pwr_D5 = sum(psd_D5)/length(D5);

pow_A5 = fft(A5,fs);
psd_A5 = pow_A5.*conj(pow_A5)/fs;
pwr_A5 = sum(psd_A5)/length(A5);

POWER = [pwr_D2 pwr_D3 pwr_D4 pwr_D5 pwr_A5];
ENTP
POWER

%WAVE = [GAMMA BETA ALPHA THETA DELTA];

figure(3)
bar(POWER)
xlabel('GAMMA         BETA         ALPHA         THETA         DELTA');
title('Power');

figure(4)
plot(ENTP)
xlabel('GAMMA          BETA          ALPHA          THETA          DELTA');
title('Entropy');


