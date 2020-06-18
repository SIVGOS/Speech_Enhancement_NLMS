function [avg_freq] = FreqCount(x,t)
%SIVGOS' Program to count average zero crossing rate of a signal
%Syntax:
%   [avg_freq]=FreqCount(x,t,n)
%
% x=input signal
% t=time scale
if(length(x)~=length(t))
    disp('ERROR: signal and time scale lengths must be equal')
    return
end
l=length(x);
T=t(l)-t(1);
count=0;
for n=2:l
    if(x(n)*x(n-1)<0)
        count=count+1;
    end
end
avg_freq=count/(2*T);
end