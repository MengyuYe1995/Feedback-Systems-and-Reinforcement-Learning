clear all
clc
n=10;
total=0;
for i=1:(n)
    rand('state',i+2)
    rr=rand(1,n)/2+0.5;
    total=rr+total;
    RR(i,:)=rr;
end
r=total'/(n);
R=cov(RR);
lamda=1;
w=10*rand(n,1);
s=0.01;%step
ro=0.1;
for ii=1:10000
    w=w-s*(2*R*w+2*w*(lamda+ro*(w'*w-1)));
    lamda=lamda+s*(w'*w-1);
    min(ii)=w'*R*w;
end
w'*w
figure ;
plot(min) ;
title('objective function') ;
xlabel('Iteration Number') ;
ylabel('Output objective') ;

