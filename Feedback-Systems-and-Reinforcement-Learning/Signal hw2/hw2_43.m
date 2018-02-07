clear all
clc
n=10;
total=0;
for i=1:(n)
    rand('state',i+2)
    rr=rand(1,n)+0.5;
    total=rr+total;
    RR(i,:)=rr;
end
r=total'/(n);
R=cov(RR);
lamda1=1;
lamda2=1;
mu=rand(n,1);
z(:,1)=rand(n,1);
w(:,1)=1/2.7*ones(n,1);
one=ones(n,1);
c=1;

for i=1:1000;
    s=0.001*0.99^(i);%step
    w(:,i+1)=w(:,i)-s*(2*R*w(:,i)+lamda2*one+mu+lamda1*r);
    z(:,i+1)=z(:,i)+2*s*mu.*z(:,i);
    lamda1=lamda1+s*(w(:,i)'*r-c);
    lamda2=lamda2+s*(one'*w(:,i)-1);
    mu=mu+s*(w(:,i)-z(:,i).*z(:,i));
    min(i)=w(:,i+1)'*R*w(:,i);
    c_obj(i)=w(:,i+1)'*r;
    w_obj(i)=sum(w(:,i+1));
end

% figure ;
% plot(min) ;
% title('min of w*R*w') ;
% xlabel('Iteration Number') ;
% ylabel('Output objective') ;

figure ;
plot(c_obj) ;
title('c obj of w*r') ;
xlabel('Iteration Number') ;
ylabel('Output objective') ;

figure ;
plot(w_obj) ;
title('w obj of sum w') ;
xlabel('Iteration Number') ;
ylabel('Output objective') ;