clear all
range=0:0.1:20;
%figure(1),plot(range,[gampdf(range,1.5,1);gamcdf(range,1.5,1)])
mu=1.5;
%mu=5;
%mu=3;
%figure(2),plot(range,exppdf(range,mu))
a=gampdf(range,1.5,1);
b=exppdf(range,mu);
c=a./b;
c_max=max(c);
iter=c;
j=1;
for i=1:1000
    x=exprnd(mu);  
    u=rand;
    qx=exppdf(x,mu);
    px=gampdf(x,1.5,1);
    if u<px/(c_max*qx)
        y(j)=x;
        j=j+1;
    end
end
figure(3),histogram(y,'normalization','cdf')
hold on
plot(range,gamcdf(range,1.5,1))