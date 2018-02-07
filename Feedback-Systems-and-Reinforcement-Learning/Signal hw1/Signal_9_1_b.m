clear all
N=1000;
s=0.1*sin(0.23*pi*[1:N]);
w=0.45*(0.1+sin(0.7*pi*[1:N])+sin(0.4*pi*[1:N])+0.3*sin(0.1*pi*[1:N]));
G=0.2*[0.8,1.4,0.7];
F=[0 0 0]';
E=zeros(1,N);
lg=length(G);
v=zeros([1,N]);
for ind=lg:N,
    ww=w(1,[ind:-1:ind-lg+1]);    
    v(ind)=G*ww'+s(ind);
end
mu=0.06;
X=toeplitz(w,[w(1) zeros(1,2)]);
for i=1:N
    E(i)=v(i)-X(i,:)*F;
    F=F+mu*X(i,:)'*E(i);  
end
sum_square_error=(F(1)-G(1))^2+(F(2)-G(2))^2+(F(3)-G(3))^2