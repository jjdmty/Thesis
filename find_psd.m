function four_adj = find_psd(rr_seg)
zero_p_b = {};
sig_fft={};
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