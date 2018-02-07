clear all
clc
%data generation
N=1000;
lamda=1;
alpha=0.5;
theta_elastic_av=0;theta_elastic_variance=0;
a1=0.8;a2=0.001;%a2 close to 0

for k=1:10
w=normrnd(1,1,1,N);
y(1)=0;y(2)=0;
for i=3:N
    y(i)=a1*y(i-1)+a2*y(i-2)+w(i);
end
for i=3:N
    fi(i-2,:)=[y(i-1),y(i-2)];
end

%Elastic-Net criterion
cvx_begin
variable theta_elastic(2,1)
minimize norm(y(3:N)'-fi*theta_elastic)^2+lamda*(alpha*norm(theta_elastic,1)+(1-alpha)*norm(theta_elastic)^2)
cvx_end
theta_elastic_av=theta_elastic_av+theta_elastic;
theta_elastic_variance=norm([a1;a2]-theta_elastic)+theta_elastic_variance;
end
theta_elastic_av=theta_elastic_av/10;
bias_elastic=theta_elastic_av-[a1;a2]
theta_elastic_variance=theta_elastic_variance/10
