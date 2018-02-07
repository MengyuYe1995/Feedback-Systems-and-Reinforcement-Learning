clear all
clc
close all
theta(1)=1;
x=normrnd(1/theta,1);%transmission power theta higher,error rate more likely higher
power(1)=1;
d=10;%error rate bound
c=0.1;%ro
mu=1;
s=0.001
for k=1:1000
    s=s*0.999;
    a1=normrnd((1/(theta(k)+0.01)),1);%we can also do it in a messy way:run a1 a2several times and get mean to compute gradient of theta
    a2=normrnd((1/(theta(k)-0.01)),1);
    theta(k+1)=theta(k)-s*(1+(a1-a2)/0.02*(mu+c*(1/theta(k)-d)));
    if (mu+s*(1/theta(k)-d))>0
        mu=mu+s*(1/theta(k)-d);
    else
        mu=0;
    end
    err(k+1)=1/theta(k+1);
end
subplot(2,1,1)
title('power')
plot(theta);
subplot(2,1,2)
plot(err);
title('error rate')

