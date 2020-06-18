function [mse] = find_MSE(x,y)
%x=desired signal
%y=actual signal
%mse=mean square error
l1=length(x);
l2=length(y);
for k=1:min(l1,l2)
    err(k)=(x(k)-y(k))^2;
end
mse=mean(err);
