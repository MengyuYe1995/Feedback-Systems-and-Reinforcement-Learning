clear all
clc
N=1000;
theta_square_av=0;theta_square_variance=0;
a1=0.8;a2=0.001;%a2 close to 0
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

%Square root LASSO
mu=0.1;
cvx_begin
variable theta_square(2,1)
minimize sqrt(N-2)*norm(y(3:N)'-fi*theta_square)+mu*norm(theta_square,1)
cvx_end

theta_square_av=theta_square_av+theta_square;
theta_square_variance=norm([a1;a2]-theta_square)+theta_square_variance;
end
theta_square_av=theta_square_av/100;
bias_square=theta_square_av-[a1;a2]
theta_square_variance=theta_square_variance/100