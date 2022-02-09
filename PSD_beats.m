p = 1;
[qrs_all,ecg_all,time]=load_data(p);
freq =100;
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

%% beats number 
for i=1:length(seg)
    beats_n(i)=length(seg{i});
end