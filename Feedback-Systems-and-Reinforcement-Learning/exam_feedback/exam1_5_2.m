clear all
clc
theta(:,1)=3;
c=(normrnd(theta(:,1),1)-5)^1.2;
total=zeros(1,1000);
%for j=1:1000
for i=1:30000
    d=sign(rand-0.5);
    delta=1/((i+1)^1);
    a=0;b=0;
    for ii=1:10
        a=a+(normrnd(theta(:,i)+0.01,1)-10)^2;
        b=b+(normrnd(theta(:,i)-0.01,1)-10)^2;
    end
    gradient_est(i,1)=(a-b)/(0.02*ii);
    step=0.0001;
    theta(:,i+1)=theta(:,i)-step*gradient_est(i,1);
end
figure(1)
plot(theta)
xlabel('iteration i')
ylabel('estimation of theta')
title('stimation of theta that minimizes the E(C(theta,x))')