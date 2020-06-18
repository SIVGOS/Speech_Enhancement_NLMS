function [y] = Auto_NLMS(x,ref,Fs,m,N)
%Final program for Auto-update NLMS algorithm
%x=noisy input signal
%ref=reference clean speech
%Fs=sampling rate
%m=Step size
%N=filter order
%y=output clean speech
ns1=x(Fs+1:Fs*1.5); %Extracting 0.5 sec noise (0.5 to 1 sec.)
ns=[];
L1=length(x);
L2=length(ref);
for z=1:2*L2/Fs
    ns=[ns;ns1]; %Repeating the noise to make it equal to ref
end
x0=ref+ns; %Adding repeated noise and ref
w=zeros(1,N); %Initializing filter parameters with zeros
for k=1:L2-N %Here goes the NLMS algorithm
    xk=x0(k:k+N-1);
    y0(k)=w*xk;
    e(k)=ref(k)-y0(k);
    wk=w;
    w=wk+m*e(k)*xk'/(xk'*xk);
end
y1=filter(w,1,x); %Filtering x with the final filter parameters
y=sivNorm(y1); %Normalizing the output (so that its magnitude can compared with x
end

