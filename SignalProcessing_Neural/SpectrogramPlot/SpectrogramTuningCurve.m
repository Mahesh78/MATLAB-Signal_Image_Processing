clc; clear all; close all;
load LIPdata.mat;

params.tapers=[5 9]; params.pad=2; params.Fs=1000; params.fpass=[0 100]; params.trialave=1; params.err=0;
movingwin=[0.3 0.05]; % duration of moving window used to evaluate spectrograms
win=[1.5 1.5]; % window around events
fignum=[6 3 2 1 4 7 8 9]; angle=0;% figure numbers for particular directions


for targ=0:7;
    E=targoff(find(targets==targ));
    [Slfp,tlfp,flfp]=mtspecgramtrigc(dlfp(:,1),E,win,movingwin,params);
    
    tlfp = tlfp - win(1);
    LFP(targ+1)=struct('Dir',Slfp);                       
    Time(targ+1)=struct('Dir',tlfp);                  
    Frequency(targ+1)=struct('Dir',flfp);             
    
    subplot(3,3,fignum(targ+1));
    imagesc(tlfp,flfp,10*log10(Slfp)'); axis xy; colorbar;
    caxis([-50 -30]);
    
    title(['angle:',num2str(angle),'^0']);
    angle=angle+45;
    xlabel('Time (sec)'); ylabel('Frequency(Hz)');
end;

% [s,t,f] = mtspecgramtrigc(dlfp(:,1),targoff(targets==5),win,movingwin,params);
% figure
% t = t-win(1);
% imagesc(t,f,10*log10(s)'); axis xy; colorbar; caxis([-50 -30])
% amp = abs(s);

Fi=0;Fe=18;Ti=-0.1;Te=0.1;

[Val1,ti_id]=min(abs(Time(8).Dir-Ti));
[Val2,te_id]=min(abs(Time(8).Dir-Ti));
[Val3,fi_id]=min(abs(Frequency(8).Dir-Fi));
[Val4,fe_id]=min(abs(Frequency(8).Dir-Fe));

for i=1:length(Time)
    Extract=LFP(i).Dir(ti_id:te_id,fi_id:fe_id);
    Selected(i)=sum(sum(Extract));
end

angle=0:45:315;

figure(),plot(angle,Selected,'k-');
xlim([0,315]);
title('Tuning Curve');xlabel('Saccade angle'); ylabel('Spectral Power');
