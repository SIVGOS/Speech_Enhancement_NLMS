function [sn,dec_vus,n,tms] = clean_vus(x,Fs)
%Program to find vus and sn matrix of a clean speech (VUS ALGO-1)
%sn: 
%  voiced/unvoiced: n ones
%  silent: n zeros
%vus:
%  v(voiced)=1
%  u(unvoiced)=-1
%  s(silent/only noise)=0
%n=number of samples per frame
%tms=time-scale for plotting frames
N=length(x);
t=linspace(0,N/Fs,N);
t_fram=20; %msec
n=Fs*t_fram/1000;
clear z;
z=0;
frqs=[];
tms=[];
dec_vus=[];
sn=[];
xmag_rec=[];
while(z<N) %Calculating average magnitude and ZCR of frames
    if(z+n<N)
        x1=x(z+1:z+n);
        t1=t(z+1:z+n);
        tms=[tms,t(z+n)];
        xmag=mean(abs(x(z+1:z+n)));
    else
        x1=x(z+1:N);
        t1=t(z+1:N);
        tms=[tms,t(N)];
        xmag=mean(abs(x(z+1:N)));
    end
    favg1=FreqCount(x1,t1);
    frqs=[frqs,favg1];
    xmag_rec=[xmag_rec,xmag];
    z=z+n;
end
clear z;
%------------Normalizing Parameters--------------
frqsNorm=frqs/max(frqs); 
xmag_rec_Norm=xmag_rec/max(xmag_rec);
%-----------Applying Thresholds---------------=
for z=1:length(frqs)
    if(xmag_rec_Norm(z)>0.25 && frqsNorm(z)<0.5)
        dec_vus=[dec_vus,1]; %voiced
        sn=[sn,ones(1,n)]; %Contains signal
    elseif(xmag_rec_Norm(z)<0.25 && frqsNorm(z)>0.5)
        dec_vus=[dec_vus,-1]; %unvoices
        sn=[sn,ones(1,n)]; %Contains signal
    else
        dec_vus=[dec_vus,0];
        sn=[sn,zeros(1,n)]; %Contains silence
    end
end
% figure
% subplot 311
% stem(xmag_rec_Norm)
% subplot 312
% stem(frqsNorm)
% subplot 313
% stem(dec_vus)
end