%% Clean up...
close all; clear all; clc;

%% Loading the File (Signal)

ecg = load('SampleECG.txt');
% ecg = data;
% ecg = Data(:,1); % Selecting Channel 1

%% Plotting the Signal 

Fs = 1000; % Sampling Frequency
t = (0:length(ecg)-1)/Fs; % Time Vector
figure; subplot(211), plot(t,ecg); % Sub-Plotting it on a new figure (2R,1C,Pos 1)
%axis([0 15 -8 10]);  % Axis Limits [Xmin Xmax Ymin Ymax]
title('Original signal'); 

%% Pre-processing

% Filtering the Signal

BW = 0.1/1; % Bandwidth = CutOff Frequency (0.1) / Quality Factor (1)
[bn,an] = iirnotch(0.1,0.1,1);  % bn and an are the vectors of the numerator and denominator coefficients respectively, for the filter
filt_ecg = filter(bn,an,ecg);
 
% Removing the Baseline Wander using Wavelet Decomposition Technique

[C,L]=wavedec(filt_ecg,10,'db6'); % Decompose the signal to the 10th level
A10=wrcoef('a',C,L,'db6',10); % Reconstruct the signal branch using 'approximate' coefficients
cleanSignal=filt_ecg-A10; % Remove the low freq signal branch

subplot(212); plot(t,cleanSignal); % Sub-Plot the signal on the same figure (Pos 2)
%axis([0 15 -8 10]);
title('Filtered signal');

%% Peak Detection (R-Peaks) using Peakdet.m

[maxtab, mintab] = peakdet(cleanSignal,.45*max(cleanSignal)); % Find the peaks and valleys
hold on; % Enable hold
plot((maxtab(:,1))./Fs, maxtab(:,2), 'r*'); % Plot the peaks on the filtered signal (Pos 2)
tpeak = maxtab(:,1)/Fs; % Store all the peaks in vector 'tpeak'

%% HRV Analysis - Time Domain
% R-R Interval, 
% HRV, 
% Mean Heart Rate, 
% SDNN, 
% RMSSD
% NN50

% R-R Interval

T_IHRV_ECG = zeros(length(tpeak)-1,1); % Preallocating vectors
IHRV_ECG = zeros(length(tpeak)-1,1);
RRinterval = zeros(length(tpeak)-1,1);


INCR=0; 
for Rpoint=1:1:length(tpeak)-1 
    INCR=INCR+1; 
    T_IHRV_ECG(INCR)=tpeak(Rpoint+1,1); % Storing peaks 
    IHRV_ECG(INCR)=1/((tpeak(Rpoint+1,1))-(tpeak(Rpoint,1)))*60; % HRV = Inverse of the R-R Interval (per min)
    RRinterval(INCR)=((tpeak(Rpoint+1,1))-(tpeak(Rpoint,1))); % R-R Interval = Time difference b/w 2 consecutive peaks
end

figure; % Creating a new figure

scatter(T_IHRV_ECG,IHRV_ECG,'k','+'); % Scatter Plot for HRV
title('Heart Rate Variability derived from ECG');
xlabel('Time in sec'); ylabel('beats/min');


mean_hr = mean(IHRV_ECG); % Mean Heart Rate,
disp(['Mean HRV = ' num2str(mean_hr)]);

SDNN = std(RRinterval); % SDNN,
disp(['SDNN = ' num2str(SDNN)]);

sq = diff(RRinterval).^2;
rms = sqrt(mean(sq)); % RMSSD,
disp(['RMSSD = ' num2str(rms)]);

NN50 = sum(abs(diff(RRinterval))>.05); % NN50,
disp(['NN50 = ' num2str(NN50)]);

%% HRV Analysis - Frequency Domain
% Bandpower of - VLF, LF, HF Regions
% LF/HF Ratio

Timescale_HRV=(min(T_IHRV_ECG):0.25:max(T_IHRV_ECG)); % Calculate the Timescale vector with an interval of 0.25 (corresponding to 4Hz)
HRV_Interp=interp1(T_IHRV_ECG,IHRV_ECG,Timescale_HRV,'cubic'); % 'Cubic' Interpolation of HRV to get an evenly sampled vector

Nnew = 1024; % For 1024 point DFT
Fs_new=4; % Sampling Rate = 4Hz
FreqIndex=(0:(Nnew/2))*Fs_new/Nnew; % Calculate the Frequency Index for Fs_new

FFT_HRV=fft(HRV_Interp-mean(HRV_Interp),Nnew); % Calculate the FFT 
PSD_HRV=(abs(FFT_HRV).^2); % Calculate the PSD
figure; plot(FreqIndex,PSD_HRV(1:length(FreqIndex))); % Plot the PSD on a new figure
title('Frequency domain analysis of HRV'); 
xlabel('Frequency (Hz)');
ylabel('Magnitude');

% VLF Band
band_vlf_1 = 1;
band_vlf_2 = 12; % corresponding to 0.04 Hz
bandpower_vlf = trapz(FFT_HRV(band_vlf_1:band_vlf_2),PSD_HRV(band_vlf_1:band_vlf_2));

% LF Band
band_lf_1 = 12;
band_lf_2 = 40; % corresponding to 0.15 Hz
bandpower_lf = trapz(FFT_HRV(band_lf_1:band_lf_2),PSD_HRV(band_lf_1:band_lf_2));

%HF Band
band_hf_1 = 40;
band_hf_2 = 104; % corresponding to 0.4 Hz
bandpower_hf = trapz(FFT_HRV(band_hf_1:band_hf_2),PSD_HRV(band_hf_1:band_hf_2));

disp(['LF/HF ratio = ' num2str(bandpower_lf/bandpower_hf)]); % Displaying the LF/HF Ratio
 
%% HRV Analysis - Non Linear
% Poincare Plot

RRahead = zeros(length(IHRV_ECG)-1,1); % Preallocating the vector

for i = 1:length(IHRV_ECG)-1
     RRahead(i) = IHRV_ECG(i+1); % This vector contains the HRV values starting from the 2nd value, thus making it 
end
 
figure, plot(RRahead,IHRV_ECG(1:length(IHRV_ECG)-1),'o'); % Poincare Plot i.e. R-R(n)(X-Axis) vs R-R(n-1)(Y-Axis)
title('Poincare Plot');
xlabel('RR(n)');
ylabel('RR(n-1)');

%% End of C0de