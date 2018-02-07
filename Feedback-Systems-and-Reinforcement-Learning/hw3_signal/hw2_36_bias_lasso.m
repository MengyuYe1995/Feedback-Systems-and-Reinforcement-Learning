clear all
clc
N=1000;
theta_lasso_av=0;theta_lasso_variance=0;
a1=0.8;a2=0.001;%a2 close to 0
lamda_lasso=10000;
for k=1:100
%data generation
w=normrnd(1,1,1,N);
y(1)=0;y(2)=0;
for i=3:N
    y(i)=a1*y(i-1)+a2*y(i-2)+w(i);
end
for i=3:N
    fi(i-2,:)=[y(i-1),y(i-2)];
end

%lasso
cvx_begin
variable theta_lasso(2,1)
minimize norm(y(3:N)'-fi*theta_lasso)^2+lamda_lasso*norm(theta_lasso,1)
cvx_end

theta_lasso_av=theta_lasso_av+theta_lasso;
theta_lasso_variance=norm([a1;a2]-theta_lasso)+theta_lasso_variance;
end
theta_lasso_av=theta_lasso_av/100;
bias_lasso=theta_lasso_av-[a1;a2]
theta_lasso_variance=theta_lasso_variance/100