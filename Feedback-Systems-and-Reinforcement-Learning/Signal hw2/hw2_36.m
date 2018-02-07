clear all
clc
%data generation
N=1000;
w=normrnd(1,1,1,N);
a1=0.8;a2=0.001;%a2 close to 0
y(1)=0;y(2)=0;
for i=3:N
    y(i)=a1*y(i-1)+a2*y(i-2)+w(i);
end
for i=3:N
    fi(i-2,:)=[y(i-1),y(i-2)];
end

%Ridge Regression
lamda_ridge=1;
lamda_lasso=10000;
theta_ridge=(fi'*fi+lamda_ridge*eye(2))^(-1)*fi'*y(3:N)';

%LASSO 
cvx_begin
variable theta_lasso(2,1)
minimize norm(y(3:N)'-fi*theta_lasso)^2+lamda_lasso*norm(theta_lasso,1)
cvx_end

%normal ls
theta_ls=(fi'*fi)^(-1)*fi'*y(3:N)';

%Square root LASSO
mu=10;
cvx_begin
variable theta_square(2,1)
minimize sqrt(N-2)*norm(y(3:N)'-fi*theta_square)+mu*norm(theta_square,1)
cvx_end
