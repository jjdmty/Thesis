%% load data 
p = 1;
[qrs_all,ecg_all,time]=load_data(p);
freq =100;

%% plot all
ecg_sec_per_sample = time/length(ecg_all);
ecg_x=time/length(ecg_all):time/length(ecg_all):time;
% ecg_x=1/100:1/100:10000;
% qrs_x= qrs_all.*(time/qrs_all(end));
qrs_x= qrs_all/freq;
qrs_y=400*ones(1,length(qrs_all));

figure(p);
subplot(2,1,1)
title('whole data');
plot(ecg_x,ecg_all);
hold on;
plot(qrs_x,qrs_y,'.');

%% plot 20sec
% ecg20=ecg_all(1:round(20/(ecg_sec_per_sample))); %20sec/sec per sample=samples in 20sec
% ecg_x20=time/length(ecg_all):time/length(ecg_all):20;
% ecg20=ecg_all(1:length(ecg_x20));
ecg20=ecg_all(1:2000);
ecg_x20=1/freq:1/freq:20;
i=1; qrs_x20=0;
while true
    if qrs_x(i)>=20
        break;
    end
    qrs_x20(i)=qrs_x(i);
    i=i+1;
end
qrs_y20=400*ones(1,length(qrs_x20));
figure(p);
subplot(2,1,2)
title('20 sec');
plot(ecg_x20,ecg20);
hold on;
plot(qrs_x20,qrs_y20,'o');

%% raw rr interval (without 1-mins segments) 
rr=rr_int(qrs_all)./freq;
figure('name','raw rr interval');
subplot(2,1,1)
plot(rr);
title('whole data');
ylabel('seconds');
xlabel('No of samples');
subplot(2,1,2)
rr20=rr(1:19);
title('20 sec');
xlabel('No of samples');
ylabel('seconds');
plot(rr20);

%% 1 mins segmentation 
mins =60;
m=1;
cellarray={};
array=[];
for i=1:length(qrs_x)
    if qrs_x(i)<mins
        array(length(array)+1)=qrs_x(i);
    else
        m=m+1;
        mins=mins+60;
        cellarray{m}=array;
        array=[];
    end
end
seg=cellarray(1,2:end);

%% 1 min segments rr interval 
rr_seg={};
save=[];
for i=1:length(seg)
    save = rr_int(seg{i});
    rr_seg{i}=save;
    save=[];
end

%% mean RR-interval & std rr-interval
rr_mean = cellfun(@mean,rr_seg);
rr_std=cellfun(@std,rr_seg);
figure('name','1 mins segments');
subplot(2,1,1)
plot(rr_mean,'.');
subplot(2,1,2)
plot(rr_std,'.')

%% serial correlation coefficients
figure('name','autocorr');
scc = cellfun(@autocorr,rr_seg,'UniformOutput',false);
% first five coefficient
ffc=[];
for m =1:length(scc)
    for i=1:5
        ffc(m,i) = scc{m}(i+1);
    end
end


%% NN50 measure (diff>50ms == >50e-3 sec)
nn50_v1=zeros(1,length(rr_seg)); % pair number for NN50
nn50_v2=zeros(1,length(rr_seg));
save=[];
for m = 1:length(rr_seg)
    save=rr_seg{m};
    for i=1:length(save)-1
        if save(i)-save(i+1)>50e-3
            nn50_v1(m)=nn50_v1(m)+1;
        end
        if save(i+1)-save(i)>50e-3
            nn50_v2(m)=nn50_v2(m)+1;
        end
    end    
end
figure('name', 'NN50 measure variant 1 vs 2');
plot(nn50_v1);
hold on;
plot(nn50_v2);
legend('Variant 1','Variant 2');
title('NN50 measure for 1min segments');
ylabel('No. of pairs');

%% pNN50 measures 
% defined as each NN50 measure devided by the total number of RR-interval
% first find out the total No. of rr interval for each 1-min segments
rrN = [];
for m=1:length(rr_seg)
    rrN(m)=length(rr_seg{m});
end
pNN50_v1 = nn50_v1./rrN;
pNN50_v2 = nn50_v2./rrN;

figure('name', 'pNN50 measure variant 1 vs 2');
plot(pNN50_v1);
hold on;
plot(pNN50_v2);
legend('Variant 1','Variant 2');
title('pNN50 measure for 1min segments');

%% SDSD measures 
% defined as the standard deviation of the differences between adjacent 
% RR-interval 
sd={};%store the differences between adjacent rr_interval
for m =1:length(rr_seg)
    save = rr_seg{m};
    for i=1:length(save)-1
        sa(i)=save(i+1)-save(i);
    end
    sd{m}=sa;
    sa=[];
end
sdsd = cellfun(@std,sd);
figure('name','SDSD');
plot(sdsd);

%% RMSSD measure
% defined as the square root of the mean of the sum of the squres of
% differences between adjacent RR intervals
for m=1:length(sd)
    save = sd{m};
    sqr_save = save.^2;
    sum_sd(m) = sum(sqr_save);
end
rmssd = sqrt(mean(sum_sd))

%% amplitude difference (EDR??????)
gap =300; %300ms samples 
seg_amp = {};
for m=1:length(seg)
    for i=1:length(seg{m})
        sec = (seg{m}(i));
       
        samp = round(sec/ecg_sec_per_sample);
        if samp+gap>length(ecg_all)
                break
        end
        if samp ==0
            samp=1;
        end
        arr = ecg_all(samp:samp+gap);
        seg_amp{m}(i) = max(arr)-min(arr); 
    end
end
mean_amp = cellfun(@mean,seg_amp);
std_amp = cellfun(@std,seg_amp);
figure('name','mean & std of amp');
subplot(2,1,1);
plot(mean_amp,'.');
subplot(2,1,2)
plot(std_amp,'.');


%% allan factor 
% A_5,A_10,A_15,A_20,A_25
% 1    2     3    4   5

A_5 = allan_factor(5,qrs_x);
A_10 = allan_factor(10,qrs_x);
A_15 = allan_factor(15,qrs_x);
A_20 = allan_factor(20,qrs_x);
A_25 = allan_factor(25,qrs_x);

%% PSD for rr
four_adj=find_psd(rr_seg);
psd_edr = find_psd(seg_amp);
    
    
    
    



