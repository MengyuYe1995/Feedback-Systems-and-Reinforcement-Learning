clear all
clc
theta=[3,5]';

X1=10*rand(10,2);
X2=10*rand(10,2);
noise1=normrnd(0,1,10,1);
noise2=normrnd(0,1,10,1);
y1=X1*theta+noise1;

theta_est(:,1)=[1;1];
for i=1:100
    y2=X2*theta_est(:,i);
    theta_est(:,i+1)=pinv([X1;X2])*[y1;y2];
end

