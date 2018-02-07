clear all
A=[0.7 -0.2 0 0.3;0 0.8 0.3 -0.4;-0.1 0.3 0 -0.2;0.2 -0.2 0.9 0.8];
b=[0.11;-0.04;0.08;0];
c=[0.5 -2 0 3];d=0;
dp=[0.8+0.1i 0.8-0.1i 0.6082-0.0620i 0.6082+0.0620i];
k=place(A,b,dp);
%l=k';
l=[1 -0.1 -0.1 0]';
x_wave=zeros(4,20);
x_wave(:,1)=[2 -0.5 0 -1]';
sum=zeros(1,20);
sum(1)=x_wave(:,1)'*x_wave(:,1);
for i=2:20
    x_wave(:,i)=(A-l*c)*x_wave(:,i-1);
    sum(i)=x_wave(:,i)'*x_wave(:,i);
end
x=1:20;
plot(x,sum);