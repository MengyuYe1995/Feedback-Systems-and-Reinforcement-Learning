clear all
j=1;
for x=0:0.001:1
    cdf(j)=-1/(log(x)-1);
    j=j+1;
end
figure(1),plot(0:0.001:1,cdf)

j=1;
for i=1:10000  
    u=rand;
    y(j)=exp(1-1/u);
    j=j+1;
end
hold on    
histogram(y,'normalization','cdf')