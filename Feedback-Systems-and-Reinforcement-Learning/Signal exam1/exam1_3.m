clear all
clc
total=0;
n=10;
%theta=randn(n,1);
theta=[1;2;3;4;5;6;7;8;9;10];
N=100;
sigma=1;
mu=0;
noise=normrnd(mu,sigma,N,1);
X=2*randn(N,n);
Y=X*theta;
lamda(:,1)=rand;
theta_est(:,1)=randn(n,1);

%A=[1,zeros(1,n-1);0,1,zeros(1,n-2)];
A=[1,1,zeros(1,n-2)];
b=A*theta;
M=30;
for i=1:M
    s=0.001*0.99^(i);%step
    theta_est(:,i+1)=theta_est(:,i)-s*(-2*X'*(Y-X*theta_est(:,i))+lamda(:,i)*A');
    lamda(:,i+1)=lamda(:,i)+s*(A*theta_est(:,i)-b);
    err(i,:)=norm(Y-X*theta_est(:,i+1));
    b_est(i,:)=A*theta_est(:,i+1);
end

figure(1)
plot(err)
xlabel('iteration i')
ylabel('square error')
title('square error')

figure(2)
plot(b_est)
xlabel('iteration i')
ylabel('A*theta-est')
title('A*theta-est')