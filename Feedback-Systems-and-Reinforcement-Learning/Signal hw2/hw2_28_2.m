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

%A=[1,zeros(1,n-1);0,1,zeros(1,n-2);0,0,1,zeros(1,n-3)];
A=[1,zeros(1,n-1);0,1,zeros(1,n-2)];
%A=[1,zeros(1,n-1)];
P=A'*(A*A')^(-1)*A;

theta_est=pinv(X)*Y;
theta_est_c=theta_est+(X'*X)^(-1)*A'*(A*(X'*X)^(-1)*A')^(-1)*(-A*theta_est);

sigma_est_c=sqrt(1/(N-n)*(Y-X*theta_est_c)'*(Y-X*theta_est_c));
total=total+sigma_est_c;
end
sigma_av=total/1000
A*theta_est_c