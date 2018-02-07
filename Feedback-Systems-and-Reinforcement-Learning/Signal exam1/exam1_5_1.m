clear all
clc
theta(:,1)=1;
c=abs(normrnd(theta(:,1),1));
total=zeros(1,10000);
%for j=1:100
for i=1:10000
    d=sign(rand-0.5);
    delta=0.01/((i+1)^1);
    gradient_est(i,1)=d*((normrnd(theta(:,i)+delta*d,1)-5)^2-(normrnd(theta(:,i)-delta*d,1)-5)^2)/(2*delta);
    step=0.001/((i+1+0.1)^1);
    theta(:,i+1)=theta(:,i)-step*gradient_est(i,1);
    total(1,i)=total(1,i)+theta(:,i+1);
end
%end
theta_av=total/100;
% figure(1)
% plot(theta_av)
% xlabel('iteration i')
% ylabel('estimation of theta')
% title('stimation of theta that minimizes the E(C(theta,x))')
