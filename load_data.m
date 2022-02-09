function [qrs,ECG,time] = load_data(p)
qrs=0;
ECG=0;
time=0;
if p==1
    load a01m
    ECG = val;
    load a01qrs
    qrs=QRS;
    time=29570; % sec
elseif p==2
    load a02m
    ECG = val;
    load a02qrs
    qrs=QRS;
    time=(8*60+50)*60+20;
elseif p==3
    load a03m
    ECG = val;
    load a03qrs
    qrs=QRS;
    time=(8*60+42)*60+30;
elseif p==4
    load a04m
    ECG = val;
    load a04qrs
    qrs=QRS;
    time=(8*60+16)*60+40;
elseif p==5
    load a05m
    ECG = val;
    load a05qrs
    qrs=QRS;
    time=(7*60+33)*60+15;
elseif p==6
    load a06m
    ECG = val;
    load a06qrs
    qrs=QRS;
    time=(8*60+29)*60+40;
elseif p==7
    load a07m
    ECG = val;
    load a07qrs
    qrs=QRS;
    time=(8*60+30)*60+05;
elseif p==8
    load a08m
    ECG = val;
    load a08qrs
    qrs=QRS;
    time=(8*60+20)*60+25;
elseif p==9
    load a09m
    ECG = val;
    load a09qrs
    qrs=QRS;
    time=(8*60+18)*60;
elseif p==10
    load a10m
    ECG = val;
    load a10qrs
    qrs=QRS;
    time=(8*60+36)*60+55;
elseif p==11
    load a11m
    ECG = val;
    load a11qrs
    qrs=QRS;
    time=(7*60+48)*60;
elseif p==12
    load a12m
    ECG = val;
    load a12qrs
    qrs=QRS;
    time=(9*60+37)*60;
elseif p==13
    load a13m
    ECG = val;
    load a13qrs
    qrs=QRS;
    time=(8*60+14)*60+15;
elseif p==14
    load a14m
    ECG = val;
    load a14qrs
    qrs=QRS;
    time=(8*60+42)*60+30;
elseif p==15
    load a15m
    ECG = val;
    load a15qrs
    qrs=QRS;
    time=(8*60+29)*60+20;
elseif p==16
    load a16m
    ECG = val;
    load a16qrs
    qrs=QRS;
    time=(8*60+1)*60+20;
elseif p==17
    load a17m
    ECG = val;
    load a17qrs
    qrs=QRS;
    time=(8*60+4)*60+5;
elseif p==18
    load a18m
    ECG = val;
    load a18qrs
    qrs=QRS;
    time=(8*60+12)*60+50;
elseif p==19
    load a19m
    ECG = val;
    load a19qrs
    qrs=QRS;
    time=(8*60+22)*60;
elseif p==20
    load a20m
    ECG = val;
    load a20qrs
    qrs=QRS;
    time=(8*60+20)*60;
elseif p==21
    load b01m
    ECG = val;
    load b01qrs
    qrs=QRS;
    time=(8*60+6)*60+10;
elseif p==22
    load b02m
    ECG = val;
    load b02qrs
    qrs=QRS;
    time=(8*60+48)*60+25;
elseif p==23
    load b03m
    ECG = val;
    load b03qrs
    qrs=QRS;
    time=(7*60+20)*60+30;
elseif p==24
    load b04m
    ECG = val;
    load b04qrs
    qrs=QRS;
    time=(7*60+8)*60+50;
elseif p==25
    load b05m
    ECG = val;
    load b05qrs
    qrs=QRS;
    time=(7*60+12)*60+15;
elseif p==26
    load c01m
    ECG = val;
    load c01qrs
    qrs=QRS;
    time=(8*60+3)*60+10;
elseif p==27
    load c02m
    ECG = val;
    load c02qrs
    qrs=QRS;
    time=(8*60+21)*60+10;
elseif p==28
    load c03m
    ECG = val;
    load c03qrs
    qrs=QRS;
    time=(7*60+33)*60+20;
elseif p==29
    load c04m
    ECG = val;
    load c04qrs
    qrs=QRS;
    time=(8*60+1)*60+10;
elseif p==30
    load c05m
    ECG = val;
    load c05qrs
    qrs=QRS;
    time=(7*60+45)*60+30;
elseif p==31
    load c06m
    ECG = val;
    load c06qrs
    qrs=QRS;
    time=(7*60+47)*60+20;
elseif p==32
    load c07m
    ECG = val;
    load c07qrs
    qrs=QRS;
    time=(7*60+8)*60+10;
elseif p==33
    load c08m
    ECG = val;
    load c08qrs
    qrs=QRS;
    time=(8*60+34)*60;
elseif p==34
    load c09m
    ECG = val;
    load c09qrs
    qrs=QRS;
    time=(7*60+47)*60+30;
elseif p==35
    load c10m
    ECG = val;
    load c10qrs
    qrs=QRS;
    time=(7*60+10)*60+50;
end