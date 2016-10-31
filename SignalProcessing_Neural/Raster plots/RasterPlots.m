clc;
clear all;
close all;
load BehavioralTaskMarkers_NeuEngData.mat;

load NeuEngData.mat;

ExpParam=sortNEV(BehavTaskMarkers,'Type','ExpParam');
success=sortNEV(ExpParam,'outcome',1);



Finger0=sortNEV(success,'finger',0);
Finger1=sortNEV(success,'finger',1);
Finger2=sortNEV(success,'finger',2);
Finger3=sortNEV(success,'finger',3);
Finger4=sortNEV(success,'finger',4);
Finger5=sortNEV(success,'finger',5);
Finger6=sortNEV(success,'finger',6);

Finger1(1,1).TimeStampSec;

Marker=sortNEV(BehavTaskMarkers,'Type','Marker');
MI=sortNEV(Marker,'Value','30');                     %Getting Marker values for Finger pressed
MI_time=MI(1,1).TimeStampSec;


for unit=1:3
    
    if unit==1
    
    
     unit1=find(Channels.Chan3(:,2)==1);
     ap=Channels.Chan3(:,3);                     %Time instances of Channel
     aps=ap(unit1);                              %Time instances of channel for neuron1
   figure(),
    set(gcf,'name','Unit 1, Channel 3','numbertitle','off');
    
    elseif unit==2
    
    
     unit1=find(Channels.Chan4(:,2)==1);
     ap=Channels.Chan4(:,3);                     %Time instances of Channel
     aps=ap(unit1);                             %Time instances of channel for neuron1
     
        figure(), set(gcf,'name','Unit 1, Channel 4','numbertitle','off');
    
   else 
    
    
     unit1=find(Channels.Chan5(:,2)==1);
     ap=Channels.Chan5(:,3);                     %Time instances of Channel
     aps=ap(unit1);                             %Time instances of channel for neuron1
    
figure(),         set(gcf,'name','Unit 1, Channel 5','numbertitle','off');
    end


    %Finger 0
    for i=1:length(Finger0)
        Finger0Stamps(i)=Finger0(i).TimeStampSec;             %Storing tie instances for Finger 0
    end
    
    for i=1:length(MI)
        MIStamps(i)=MI(i).TimeStampSec;                       %Relating withMarker of interest
    end
    
    for i=1:length(Finger0Stamps)
      X=Finger0Stamps(i);
      D=X-MIStamps;
      DI=D(D>0);
      [SC,Id]=min(DI);
      mm0(i)=MIStamps(Id);                                     % Extracting starting values
    end 
  
    for n=1:length(mm0)
   
    
    locations=(aps(find(aps > mm0(n)-1 & aps < mm0(n)+1)))-mm0(n);
    field='loc';
    S0(n,:)=struct(field,locations);
   
end



for d=1:length(S0)
     
    e=d.*ones(1, length(S0(d).loc));
    
    subplot 271;
        plot(S0(d).loc,e,'.r');                                    %Raster plots
        hold on
        title('Thumb');
        xlabel('Time in sec');ylabel('Trial no.');
end
   

    %Finger 1
for i=1:length(MI)
    for j=1:length(Finger1)
        l(i,j)=Finger1(1,j).TimeStampSec-MI(1,i).TimeStampSec;
    end
end



for y=1:length(Finger1)
a=l(:,y);
a(a>1)=1;
a(a<1)=0;
z=find(diff(a)~=0);
mm(y,:)=MI(z).TimeStampSec;                                  % Extracting starting values
end


for n=1:length(mm)
   
    
    locations=(aps(find(aps > mm(n)-1 & aps < mm(n)+1)))-mm(n);  %Start and stop values
    field='loc';
    S1(n,:)=struct(field,locations);
   
end


for d=1:length(S1)
     
    e=d.*ones(1, length(S1(d).loc));                   
    
    subplot 272;
        plot(S1(d).loc,e,'.r');                                  %Rasters
        hold on
        title('Index');
        xlabel('Time in sec');ylabel('Trial no.');
end
   

    %Finger 2
    
    
for i=1:length(MI)
    for j=1:length(Finger2)
        l2(i,j)=Finger2(1,j).TimeStampSec-MI(1,i).TimeStampSec;
    end
end



for y=1:length(Finger2)
a=l2(:,y);
a(a>1)=1;
a(a<1)=0;
z=find(diff(a)~=0);
mm2(y,:)=MI(z).TimeStampSec;
end


for n=1:length(mm2)
   
    
    locations=(aps(find(aps > mm2(n)-1 & aps < mm2(n)+1)))-mm2(n);
    field='loc';
    S2(n,:)=struct(field,locations);
   
end



for d=1:length(S2)
     
    e=d.*ones(1, length(S2(d).loc));
    
    subplot 273;
        plot(S2(d).loc,e,'.r');
        hold on
        title('Middle');
        xlabel('Time in sec');ylabel('Trial no.');
end


    %Finger 3
    
    
for i=1:length(MI)
    for j=1:length(Finger3)
        l3(i,j)=Finger3(1,j).TimeStampSec-MI(1,i).TimeStampSec;
    end
end



for y=1:length(Finger3)
a=l3(:,y);
a(a>1)=1;
a(a<1)=0;
z=find(diff(a)~=0);
mm3(y,:)=MI(z).TimeStampSec;
end


for n=1:length(mm3)
   
    
    locations=(aps(find(aps > mm3(n)-1 & aps < mm3(n)+1)))-mm3(n);
    field='loc';
    S3(n,:)=struct(field,locations);
   
end



for d=1:length(S3)
     
    e=d.*ones(1, length(S3(d).loc));
    
    subplot 274;
        plot(S3(d).loc,e,'.r');
        hold on
        title('Thumb,Index');
        xlabel('Time in sec');ylabel('Trial no.');
end



%Finger 4
    
    
for i=1:length(MI)
    for j=1:length(Finger4)
        l4(i,j)=Finger4(1,j).TimeStampSec-MI(1,i).TimeStampSec;
    end
end



for y=1:length(Finger4)
a=l4(:,y);
a(a>1)=1;
a(a<1)=0;
z=find(diff(a)~=0);
mm4(y,:)=MI(z).TimeStampSec;
end


for n=1:length(mm4)
   
    
    locations=(aps(find(aps > mm4(n)-1 & aps < mm4(n)+1)))-mm4(n);
    field='loc';
    S4(n,:)=struct(field,locations);
   
end



for d=1:length(S4)
     
    e=d.*ones(1, length(S4(d).loc));
    
    subplot 275;
        plot(S4(d).loc,e,'.r');
        hold on
        title('Thumb,Middle');
        xlabel('Time in sec');ylabel('Trial no.');
end

    %Finger 5
    
    
for i=1:length(MI)
    for j=1:length(Finger5)
        l5(i,j)=Finger5(1,j).TimeStampSec-MI(1,i).TimeStampSec;
    end
end



for y=1:length(Finger5)
a=l5(:,y);
a(a>1)=1;
a(a<1)=0;
z=find(diff(a)~=0);
mm5(y,:)=MI(z).TimeStampSec;
end


for n=1:length(mm5)
   
    
    locations=(aps(find(aps > mm5(n)-1 & aps < mm5(n)+1)))-mm5(n);
    field='loc';
    S5(n,:)=struct(field,locations);
   
end



for d=1:length(S5)
     
    e=d.*ones(1, length(S5(d).loc));
    
    subplot 276;
        plot(S5(d).loc,e,'.r');
        hold on
        title('Index,Middle');
        xlabel('Time in sec');ylabel('Trial no.');
end

    %Finger 6
    
    
for i=1:length(MI)
    for j=1:length(Finger6)
        l6(i,j)=Finger6(1,j).TimeStampSec-MI(1,i).TimeStampSec;
    end
end



for y=1:length(Finger6)
a=l6(:,y);
a(a>1)=1;
a(a<1)=0;
z=find(diff(a)~=0);
mm6(y,:)=MI(z).TimeStampSec;
end


for n=1:length(mm6)
   
    
    locations=(aps(find(aps > mm6(n)-1 & aps < mm6(n)+1)))-mm6(n);
    field='loc';
    S6(n,:)=struct(field,locations);
            title('Index,Middle');
        xlabel('Time in sec');ylabel('Trial no.');
end



for d=1:length(S6)
     
    e=d.*ones(1, length(S6(d).loc));
    
    subplot 277;
        plot(S6(d).loc,e,'.r');
        hold on
        title('Thumb,Index,Middle');
        xlabel('Time in sec');ylabel('Trial no.');
end



% Peri-stimulus Time Histogram
 
Slidetime=0.01;                            
NumOfSlides=2/Slidetime;
 
for Trials=1:length(Finger0)
Start=-1; Winlength=0.2; End=Start+Winlength;      
 
for i=1:NumOfSlides
ind=find(S0(Trials).loc>Start & S0(Trials).loc<End);
Time0(Trials,i)=Start;
count=numel(ind);
Freq0(Trials,i)=count/Winlength;
 
Start=Start+Slidetime;
End=Start+Winlength;
end
end
 
for Trials=1:length(Finger1)
Start=-1; Winlength=0.2; End=Start+Winlength;
 
for i=1:NumOfSlides
ind=find(S1(Trials).loc>Start & S1(Trials).loc<End);
Time1(Trials,i)=Start;
count=numel(ind);
Freq1(Trials,i)=count/Winlength;
 
Start=Start+Slidetime;
End=Start+Winlength;
end
end
 
for Trials=1:length(Finger2)
Start=-1; Winlength=0.2; End=Start+Winlength;
 
for i=1:NumOfSlides
ind=find(S2(Trials).loc>Start & S2(Trials).loc<End);
Time2(Trials,i)=Start;
count=numel(ind);
Freq2(Trials,i)=count/Winlength;
 
Start=Start+Slidetime;
End=Start+Winlength;
end
end
 
for Trials=1:length(Finger3)
Start=-1; Winlength=0.2; End=Start+Winlength;
 
for i=1:NumOfSlides
ind=find(S3(Trials).loc>Start & S3(Trials).loc<End);
Time3(Trials,i)=Start;
count=numel(ind);
Freq3(Trials,i)=count/Winlength;
 
Start=Start+Slidetime;
End=Start+Winlength;
end
end
 
for Trials=1:length(Finger4)
Start=-1; Winlength=0.2; End=Start+Winlength;
 
for i=1:NumOfSlides
ind=find(S4(Trials).loc>Start & S4(Trials).loc<End);
Time4(Trials,i)=Start;
count=numel(ind);
Freq4(Trials,i)=count/Winlength;
 
Start=Start+Slidetime;
End=Start+Winlength;
end
end
 
 
for Trials=1:length(Finger5)
Start=-1; Winlength=0.2; End=Start+Winlength;
 
for i=1:NumOfSlides
ind=find(S5(Trials).loc>Start & S5(Trials).loc<End);
Time5(Trials,i)=Start;
count=numel(ind);
Freq5(Trials,i)=count/Winlength;
 
Start=Start+Slidetime;
End=Start+Winlength;
end
end
 
for Trials=1:length(Finger6)
Start=-1; Winlength=0.2; End=Start+Winlength;
 
for i=1:NumOfSlides
ind=find(S6(Trials).loc>Start & S6(Trials).loc<End);
Time6(Trials,i)=Start;
count=numel(ind);
Freq6(Trials,i)=count/Winlength;
 
Start=Start+Slidetime;
End=Start+Winlength;
end
end
 
% Mean and Standard error of the Spike train
%Finger 0
MeanFreq0=mean(Freq0);
MeanTime0=mean(Time0);
 
SD0=std(Freq0);
Trials0=sqrt(size(Time0,1));
SE0=SD0/Trials0;

%Finger 1
MeanFreq1=mean(Freq1);
MeanTime1=mean(Time1);
SE1=std(Freq1)/sqrt(size(Time1,1));

%Finger 2
MeanFreq2=mean(Freq2);
MeanTime2=mean(Time2);
SE2=std(Freq2)/sqrt(size(Time2,1));

%Finger 3
MeanFreq3=mean(Freq3);
MeanTime3=mean(Time3);
SE3=std(Freq3)/sqrt(size(Time3,1));

%Finger 4
MeanFreq4=mean(Freq4);
MeanTime4=mean(Time4);
SE4=std(Freq4)/sqrt(size(Time4,1));

%Finger 5
MeanFreq5=mean(Freq5);
MeanTime5=mean(Time5);
SE5=std(Freq5)/sqrt(size(Time5,1));
%Finger 6
MeanFreq6=mean(Freq6);
MeanTime6=mean(Time6);
SE6=std(Freq6)/sqrt(size(Time6,1));
 
subplot (2,7,8), plot(MeanTime0,MeanFreq0,'-m');
hold on;
plot(MeanTime0,MeanFreq0-SE0,'-b',MeanTime0,MeanFreq0+SE0,'-b');hold on;
title('Thumb');
xlabel('Time in sec');ylabel('Frequency in Hertz');
 
subplot (2,7,9), plot(MeanTime1,MeanFreq1,'-m');
hold on;
plot(MeanTime1,MeanFreq1-SE1,'-b',MeanTime1,MeanFreq1+SE1,'-b');hold on;
title('Index');
xlabel('Time in sec');ylabel('Frequency  in Hertz');
 
subplot (2,7,10), plot(MeanTime2,MeanFreq2,'-m');
hold on;
plot(MeanTime2,MeanFreq2-SE2,'-b',MeanTime2,MeanFreq2+SE2,'-b');hold on;
title('Middle');
xlabel('Time in sec');ylabel('Frequency in Hertz');
 
subplot (2,7,11), plot(MeanTime3,MeanFreq3,'-m');
hold on;
plot(MeanTime3,MeanFreq3-SE3,'-b',MeanTime3,MeanFreq3+SE3,'-b');hold on;
title('Thumb,Index');
xlabel('Time in sec');ylabel('Frequency in Hertz');
 
subplot (2,7,12), plot(MeanTime4,MeanFreq4,'-m');
hold on;
plot(MeanTime4,MeanFreq4-SE4,'-b',MeanTime4,MeanFreq4+SE4,'-b');hold on;
title('Thumb, Middle');
xlabel('Time in sec');ylabel('Frequency in Hertz');
 
subplot (2,7,13), plot(MeanTime5,MeanFreq5,'-m');
hold on;
plot(MeanTime5,MeanFreq5-SE5,'-b',MeanTime5,MeanFreq5+SE5,'-b');hold on;
title('Index, Middle');
xlabel('Time in sec');ylabel('Frequency in Hertz');
 
subplot (2,7,14), plot(MeanTime6,MeanFreq6,'-m');
hold on;
plot(MeanTime6,MeanFreq6-SE6,'-b',MeanTime6,MeanFreq6+SE6,'-b');hold on;
title('Thumb, Index, Middle');
xlabel('Time in sec');ylabel('Frequency in Hertz');
 
end