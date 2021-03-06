function y=getvec(fid,heasig,x1,x2,dirsig);
% reads the piece of signal between x1 & x2
% returns each signal as a column of a matrix to ease plotting
% Esta funcion todavia esta por retocar para poder aceptar todos
% los formatos de lectura (Lund, DB:16,61,8,160,212,ideal,etc)


   % Leer los datos segun el formato
   if heasig.fmt(1)==8,           
      %fseek(fid,x1,-1);
      %y=fread(fid,[heasig.nsig,x2-x1],'int8');
   elseif heasig.fmt(1)==16,
      %%%fseek(fid,2*x1*heasig.nsig,-1);
      %%%y=fread(fid,[heasig.nsig,x2-x1],'int16');
%      y=int16(fread(fid,[heasig.nsig,inf],'int16'));%%%% hack by Phil
      y=fread(fid,[heasig.nsig,inf],'int16');%%%% hack by Phil
   elseif heasig.fmt(1)==61,
      fseek(fid,2*x1,-1);
      y=fread(fid,[heasig.nsig,x2-x1],'int16');
      y=swap16(y);
   elseif heasig.fmt(1)==80,
   elseif heasig.fmt(1)==160,
   elseif heasig.fmt(1)==212,  
      if exist('rdsign212')==3
         y=rdsign212([dirsig heasig.fname(1,:)],heasig.nsig,x1,x2);     
      else
       for i=1:heasig.nsig
        fseek(fid,heasig.group(i,:)*3/2*x1,-1);
        %data=fread(fid,[3 (heasig.group(1,:)*(x2-x1)/2)],'uchar');
        data=fread(fid,[3 (heasig.group(1)*(x2-x1)/2)],'uchar');  % JG 020399     
        low=rem(data(2,:),16);  
        samples(1:2:heasig.group(i)*(x2-x1)-1)=data(1,:)+256*low-(low>7)*4096;
        low=data(2,:)-low;
        samples(2:2:heasig.group(i,:)*(x2-x1))=data(3,:)+16*low-(low>127)*4096;
        clear data;
        clear low;
        for k=1:heasig.nsig,
          y(:,k)=samples(k:heasig.group(i,:):size(samples,2)).';
        end;
       end
      end
   elseif heasig.fmt(1)==310,
   end;
