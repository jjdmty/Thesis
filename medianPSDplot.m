plotpsd_rr=[];
plotpsd_edr=[];
a={};
for n=1:35
    %% load data
    p = n;
    [qrs_all,ecg_all,time]=load_data(p);
    freq =100;
    ecg_sec_per_sample = time/length(ecg_all);
    ecg_x=time/length(ecg_all):time/length(ecg_all):time;
    qrs_x= qrs_all/freq;
    qrs_y=400*ones(1,length(qrs_all));
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
    %% EDR
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
    %% find psd
    array_four_adj=[];
    array_psd_edr=[];
    four_adj=find_psd(rr_seg);
    psd_edr = find_psd(seg_amp);
    %% turn to array 
    for m = 1:length(four_adj)
        array_four_adj(m,:) =four_adj{m};
    end
    for m = 1:length(psd_edr)
        array_psd_edr(m,:) =psd_edr{m};
    end
    
%% the plot values
    for i = 1:32
        median_rr_psd(i) = median(array_four_adj(:,i));
        median_edr_psd(i) = median(array_psd_edr(:,i));
    end
    rr(n,:)=median_rr_psd;
    edr(n,:)=median_edr_psd;
end
%% 
for i =1:32
    sum_rr(i) = log(sum(rr(:,i)));
    sum_edr(i) =log(sum(edr(:,i)));
end

%% plot
figure(1);
plot(sum_rr,'-o');
figure(2);
plot(sum_edr,'-o');
