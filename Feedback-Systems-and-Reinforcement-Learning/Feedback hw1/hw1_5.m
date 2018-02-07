clear all
%theoretical
mu=1;
x1=0:0.1:10;
x2=0:0.1:10;
[X,Y]=meshgrid(x1,x2);
m=1;
for x1=0:0.1:10
    n=1;
    for x2=0:0.1:10
        Z(m,n)=(1-exp(-x1))*(1-exp(-x2));
        n=n+1;
    end
    m=m+1;
end
figure(1),mesh(X,Y,Z)
%theoretical
%practical
range=0:0.1:10;
j=1;
for i=1:100
    u1=rand;
    x1(j)=-log(1-u1);
    j=j+1;
end
h1=hist(x1,range);  
cdf1=cumsum(h1)/(sum(h1));

j=1;
for i=1:100 
    u2=rand;
    x2(j)=-log(1-u2);
    j=j+1;
end
h2=hist(x2,range);  
cdf2=cumsum(h2)/(sum(h2));

x1=0:0.1:10;
x2=0:0.1:10;
[X,Y]=meshgrid(x1,x2);

m=1;
for x1=0:0.1:10
    n=1;
    for x2=0:0.1:10
        Z2(m,n)=cdf1(m)*cdf2(n);
        n=n+1;
    end
    m=m+1;
end
figure(2),mesh(X,Y,Z2)
