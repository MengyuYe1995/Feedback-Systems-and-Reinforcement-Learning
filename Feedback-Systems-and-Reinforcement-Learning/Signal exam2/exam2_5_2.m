clear all
clc
%data generation
theta=[3,5,zeros(1,8)]';
theta_lasso_est_total=0;
k=100;

for i=1:k
x=10*rand(5,10);1
noise=normrnd(0,1,5,1);
y=x*theta+noise;

%LASSO 
lamda_lasso=1;
cvx_begin
variable theta_lasso(10,1)
minimize norm(y-x*theta_lasso)^2+lamda_lasso*norm(theta_lasso,1)
cvx_end

theta_lasso_est(:,i)=theta_lasso;
theta_lasso_est_total=theta_lasso_est_total+theta_lasso;
end
theta_lasso_est_av=theta_lasso_est_total/k;
bias=theta_lasso_est_av-theta
variance=0;

for i=1:10
    variance(i,1)=var(theta_lasso_est(i,:));
end
variance
