clear all
p=0.1;
for i=1:10000
    u=rand;
    if u<0.6
        m(i)=0;
    else m(i)=1;
    end
end
dlmwrite('file.txt',m,'delimiter','')
gzip('file.txt')
result=[990 1394 1603 1662 1674 1663 1603 1394 981 47]*8/10000;
figure(1),plot(1:10,result)

i=0;
for p=0.1:0.1:1
    i=i+1;
    entropy(i)=-p*log2(p)-(1-p)*log2(1-p);
end
figure(2),plot(0.1:0.1:1,entropy)