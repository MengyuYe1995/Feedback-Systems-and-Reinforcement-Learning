clear all
close all
N=1500;
s=0.1*sin(0.23*pi*[1:N]);
w=0.45*(0.1+sin(0.7*pi*[1:N])+sin(0.4*pi*[1:N])+0.3*sin(0.1*pi*[1:N]));
G=0.2*[0.8,1.4,0.7];
a=[1 0 0];
F=[0 0 0]';
lg=length(G);
v=zeros([1,N]);
mu=0.05;
d=filter(G,a,w);
V=d+s;
X=toeplitz(w,[w(1) zeros(1,2)])';
error=zeros(1,N);
e=zeros(1,N);
RecovErr=zeros(1,N);
for i=lg:N
    error(i)=d(i)-X(:,i)'*F;
    F=F+mu*X(:,i)*error(i);  
    ww=w(1,[i:-1:i-lg+1])
    v(1,i)=G*ww'+s(1,i);
    e(i)=v(1,i)-F'*ww';
    RecovErr(i)=e(i)-s(i);
end
sum_square_error=(F(1)-G(1))^2+(F(2)-G(2))^2+(F(3)-G(3))^2
plot(RecovErr);
