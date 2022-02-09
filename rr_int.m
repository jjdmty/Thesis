function rr = rr_int(array)
rr=[];freq=100;
for i=1:length(array)-1
    rr(i)=abs(array(i+1)-array(i));
end

%     i=2;rr=0;freq=100;
%     while true 
%         if i> length(array)
%             break
%         end
%         rr(i-1)=abs((array(i)-array(i-1))/freq);
%         i=i+1;
%     end