clear all 
clc
theta=5;
num=1000;%1000 input u
total=0;
for j=1:1000
u=rand(1,num)';
u(u>0.5)=1; 
u(u<=0.5)=-1; %1000 +-1 random input u
e=normrnd(0,1,num,1);%generate noise
%generate y
for i=1:1000
    y(i,1)=theta*u(i,1)+e(i,1);
end
theta_est=pinv(u)*y;
total=total+(theta-theta_est)^2;
end
var=total/1000
