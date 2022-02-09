function AF = allan_factor(T,qrs_x)
i=0;
a=qrs_x(1);
Array=[];
for m =1:length(qrs_x)
    i = i+1;
    if qrs_x(m)>=a+T
        a=qrs_x(m);
        Array(end+1)=i;
        i=0;
    end
end
for i =1:length(Array)-1
    AF(i) = (1/2)*((Array(i+1)-Array(i))^2)/Array(i+1);
end
