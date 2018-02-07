clear all
clc
total=0;
for i=1:1000
n=100;
theta=randn(n,1);
N=1000;
sigma=1;
mu=0;
noise=normrnd(mu,sigma,N,1);
X=randn(N,n);
Y=X*theta+noise;
theta_est=pinv(X)*Y;
sigma_est=sqrt(1/(N-n)*(Y-X*theta_est)'*(Y-X*theta_est));
total=total+sigma_est;
end
sigma_av=total/1000
