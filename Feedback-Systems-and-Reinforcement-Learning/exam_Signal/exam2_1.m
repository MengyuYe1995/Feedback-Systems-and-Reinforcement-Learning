clear all
clc
theta=[3];

theta_est=ones(1,1000);
for i=1:1000
    
X1=100*rand(1);
X2=100*rand(1);
noise1=normrnd(0,1,1,1);
noise2=normrnd(0,1,1,1);
y1=X1*theta+noise1;

theta_est_buffer=1;
for j=1:100
    y2=X2*theta_est_buffer;
    theta_est_buffer=pinv([X1;X2])*[y1;y2];
end
theta_est(i)=theta_est_buffer;
end
bias=mean(theta_est)-theta
variance=var(theta_est)