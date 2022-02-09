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

%% mean RR-interval
rr_mean = cellfun(@mean,rr_seg);

%% PSD method 1
% zero mean sequence  % to reset the zero point as mean???
zeromean = {};
for m=1:length(rr_seg)
    zeromean{m} =normalize(rr_seg{m},'center','mean'); % https://ww2.mathworks.cn/help/matlab/ref/double.normalize.html
end
% zero-padding  at the back of sequence or two sides(left &right)??
for m=1:length(zeromean)
    x=zeromean{m};
    a_b= zeros(1,256);
    a_b(1:length(x))=x;
    zero_p_b{m}=a_b;% zero padding at the back of sequence
%     a_t = zeros(1,256);
%     a_t((256/2)-(length(x)/2):(256/2)+(length(x)/2)-1) = x;
%     zero_p_t{m}=a_t; %zero padding at two sides 
end
% fft to zero_p & square the magnitude of coefficient
for m =1:length(zero_p_b)
    sig_fft{m}=abs(fft(zero_p_b{m})).^2;
%     pdg{m}=periodogram(zero_p_b{m});% find periodogram
end
% then just use the front half of each (128)
front_fft={};
for m =1:length(sig_fft)
    front_fft{m}=sig_fft{m}(1:128);
end
% Averaging of four adjacent frequency
four_adj={};
array=[];
for m =1:length(front_fft)
    for i=1:4:length(front_fft{m})
        array(end+1)=mean(front_fft{m}(i:i+3));
    end
    four_adj{m}=array;
    array=[];
end


