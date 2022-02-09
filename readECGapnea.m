function [ECG,Class,QRS]=readECGapnea(rec);

if nargin==1
   QRSflag=0;
end

% Set the path to the directory containing the data files
dirpath='C:\Users\lenovo\Desktop\apnea';

if (rec>=1 & rec<=20)
   ecgnr=sprintf('a%02d',rec);
   Class2='a';
elseif (rec>=21 & rec<=25)
   ecgnr=sprintf('b%02d',rec-20);
   Class2='b';
elseif (rec>=26 & rec<=35)
   ecgnr=sprintf('c%02d',rec-25);
   Class2='c';
end   

anot='qrs';
heasig=readheader([dirpath ecgnr '.hea']);
t=[1 heasig.nsamp];

%Read epoch annotations
annotapn=readannot([dirpath ecgnr '.' 'apn'],heasig,t);
Class=annotapn.anntyp;

%Read qrs timepoints
annotqrs=readannot([dirpath ecgnr '.' 'qrs'],heasig,t);
QRS=annotqrs.time;

[length(QRS) length(Class) annotapn.time(1) annotapn.time(end)]
time=t(1);
fid=fopen([dirpath heasig.fname(1,:)],'rb');
ECG=getvec(fid,heasig,time,inf);
fclose('all');
ECG=ECG(1,:);

clf
plot(ECG)
hold on
plot(QRS,ECG(QRS),'ro')

%Upsample annotations to 100Hz so can plot them against signal
Annotations=repmat(abs(Class)',60*100,1);
Annotations=(Annotations(:)-abs('A'))/(abs('N')-abs('A'))*100-475;

plot(Annotations)

