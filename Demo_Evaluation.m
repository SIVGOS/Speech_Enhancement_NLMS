%Program to Demonstrate the evaluation process of 2-stage speech
%enhancement algorithm
clear all
close all
clc
[x0,Fs]=wavread('siva_clean.wav'); %Clean speech
[d0,Fsd]=wavread('siva_ref.wav'); %Reference speech (for Auto_NLMS)
[n0,Fsn]=wavread('bus_noise.wav'); %Noise 
if(Fs~=Fsd || Fs~=Fsn)
    disp('ERROR: Sampling Rates Must be Equal');
    return
end
x1=sivNorm(x0);
d=sivNorm(d0);
n=sivNorm(n0);
[sn,dec_vus,n1,tms] = clean_vus(x1,Fs);
%Creating noisy speech
x=sivNorm(x1+n);
mse_x=find_MSE(x,x1)
snr_x=find_SNR(x,sn)
%Stage 1
m=1e-5;%Change m to change step-size
N=6; %Change N to change order
y=Auto_NLMS(x,d,Fs,m,N);
msey=find_MSE(y,x1)
snry=find_SNR(y,sn)
figure
subplot 311
plot(x1)
subplot 312
plot(x)
subplot 313
plot(y)