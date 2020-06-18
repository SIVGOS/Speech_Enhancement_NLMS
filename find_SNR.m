function snr=find_SNR(x,sn)
% Program to find the SNR (dB) using the VUS sequence
signal=[];
noise=[];
l=length(x);
for k=1:l
    if(sn(k)==1)
        signal=[signal,x(k)^2];
    elseif(sn(k)==0)
        noise=[noise,x(k)^2];
    end
end
snr=log10(mean(signal)/mean(noise));
end