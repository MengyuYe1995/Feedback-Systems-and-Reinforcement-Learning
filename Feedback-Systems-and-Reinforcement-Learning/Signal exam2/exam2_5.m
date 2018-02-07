clear all 
clc
%data generation
theta=[3,5,zeros(1,8)]';
k=100;
theta_ridge_est_total=0;

for i=1:k
x=10*rand(5,10);
noise=normrnd(0,1,5,1);
y=x*theta+noise;


%Ridge Regression
lamda_ridge=1;
theta_ridge=(x'*x+lamda_ridge*eye(10))^(-1)*x'*y;

theta_ridge_est(:,i)=theta_ridge;
theta_ridge_est_total=theta_ridge_est_total+theta_ridge;
end
theta_ridge_est_av=theta_ridge_est_total/k;
bias=theta_ridge_est_av-theta
variance=0;

for i=1:10
    variance(i,1)=var(theta_ridge_est(i,:));
end
variance
