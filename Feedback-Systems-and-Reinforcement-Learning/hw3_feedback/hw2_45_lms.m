clear all
clc
mu=0.001;

n=1000;
%generate input u
w=rand(1,n);
u=rand(1,n)*30;

%generate output y
a1=1.5;a2=2.5;
b=[a1,a2];
a=[1 zeros(1,2)];
d=filter(b,a,u)+w;
bhat=(zeros(1,2))';
error=zeros(1,n);
X=toeplitz(u,[u(1) 0])';

for i=1:1:n
    error(i)=d(i)-X(:,i)'*bhat;
    bhat=bhat+mu*X(:,i)*error(i);  
    b_err(i)=norm(b-bhat);
end
figure ;
plot(20*log10(abs(error))) ;
title('Learning Curve') ;
xlabel('Iteration Number') ;
ylabel('Output Estimation Error in dB') ;
figure ;
semilogy(b_err);
title('Weight Estimation Error') ;
xlabel('Iteration Number') ;
ylabel('Weight Error in dB') ; 
