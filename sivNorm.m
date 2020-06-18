function arr=sivNorm(x,n)
if(nargin==1)
    x1=abs(x);
    arr=x/max(x1);
else
    x1=abs(x(n:length(x)));
    x2=x(n:length(x));
    arr=(x2-min(x1))/(max(x1)-min(x1));
end