clear all
clc

N=1000;
u=rand(1,1000);
pi_k=(u/sum(u(:)))';

for ii=1:N
 
    u=rand(1,N);
    A(ii,:)=u/sum(u(:));
 
end
tic
pi_k_1=A'*pi_k;
toc

pi_k_1_est=zeros(N,10000-100+1);

ii=1;
for M=100:300:10000
    tic;
    for j=1:M
        u=rand;
        i(j)=sum(u>cumsum(pi_k))+1;
    end
    
    for j=1:M
        pi_k_1_est(:,ii)=A(i(j),:)'+pi_k_1_est(:,ii);
    end
    pi_k_1_est(:,ii)=pi_k_1_est(:,ii)/M;
    t1=toc;
    var(ii)=((pi_k_1_est(:,ii)-pi_k_1)'*(pi_k_1_est(:,ii)-pi_k_1))/N;
    t(ii)=t1;
    ii=ii+1;
end
figure(1),plot(100:300:10000,var)
figure(2),plot(100:300:10000,t)
