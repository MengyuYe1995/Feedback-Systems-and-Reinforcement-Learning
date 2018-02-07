clear all
k=10000;
w=randn(k-1,1);
%transition probability matrix A
A=[0.2 0.8;0.6 0.4];
%initial mean m0 of x0 
m0=0;
z=1;
for a1=1.3:0.01:1.5
    
x=10*ones(1,10000)+unifrnd(-2,2,1,10000);
%initial probability distribution pi[0] of the Markov chain
pi=[0.5 0.5];

a2=0.7;
for i=1:10000
    u=rand;
    if u<pi(1)
        xx(i)=1;
    else
        xx(i)=2;
    end
end

for i=1:10000-1
    for j=1:k-1
        if xx(i)==1
            a(i)=a1;
        else a(i)=a2;
        end
    x(i)=a(i)*x(i)+w(j);
    u=rand;
    if x(i)==1
        if u<A(1,1)
        xx(i)=1;
        else
        xx(i)=2;
        end
    else
        if u>A(2,2)
        xx(i)=2;
        else
        xx(i)=1;
        end
    end
    end
end

mean(z)=sum(x)/10000;
z=z+1;
end
figure(1),plot(1.3:0.01:1.5,mean)