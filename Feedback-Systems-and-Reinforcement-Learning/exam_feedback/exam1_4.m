clear all
clc
%u=[1,2];x=[1:20];
ro=0.1;%ro (0,1)
c=zeros(2,20);
for i=1:20
    c(1,i)=1/i;
end
for i=1:20
    c(2,i)=1/i;
end
N=1000;
v=zeros(N,20);
p1=zeros(20,20);
p2=zeros(20,20);
%u=1 transition matrix
for j=2:20
    p1(:,j)=sort(rand(1,20))/20;
end
for i=1:20
    p1(i,1)=1-sum(p1(i,[2:20]));
end
%u=2 transition matrix
for j=2:20
    p2(:,j)=sort(rand(1,20))/20;
end
for i=1:20
    p2(i,1)=1-sum(p2(i,[2:20]));
end
for ii=2:N
    for i=1:20
        for u=1:2
            buffer1=0;
            for jj=1:20
                buffer1=buffer1+((2-u)*p1(i,jj)+(u-1)*p2(i,jj))*v(ii-1,jj);
            end
            q(u,ii-1,i)=c(u,i)+ro*buffer1;
        end
        buffer2=min(q(1,ii-1,i));
        buffer3=min(q(2,ii-1,i));
        v(ii,i)=min(buffer2,buffer3);
        if v(ii,i)==buffer2
            action(ii-1,i)=1;
        else
            action(ii-1,i)=2;
        end
    end
end
