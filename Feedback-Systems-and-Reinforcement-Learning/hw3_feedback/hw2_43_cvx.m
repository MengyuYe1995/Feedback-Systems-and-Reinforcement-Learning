clear all
clc
n=10;
total=0;
for i=1:n
    rand('state',i+2)
    rr=rand(1,n)/2+0.5;
    total=rr+total;
    RR(i,:)=rr;
end
r=total'/(n);
R=cov(RR);
lamda1=1;
lamda2=1;
mu=rand(n,1);
z=rand(n,1);
one=ones(n,1);
c=0.7;

cvx_begin
variable w(10) nonnegative
minimize(w'*R*w)
subject to
    one'*w==1
    w'*r==c
cvx_end
sum(w)
w'*R*w