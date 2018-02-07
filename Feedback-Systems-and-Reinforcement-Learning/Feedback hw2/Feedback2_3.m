clear all

a=conv(conv([1 -1.17],[1 -0.73]),conv([1 -0.53+0.26i],[1 -0.53-0.26i]));
b=[0 0 3.4*conv([1 0.96],[1 0.51])];

d=conv(conv([1 -0.47+0.32i],[1 -0.47-0.32i]),conv([1 0.18],[1 0.23]));
l=conv(conv([1 0.38],[1 0.25]),conv([1 0.15],[1 -0.11]));
f=l
n=l;

abar=toeplitz([a zeros(1,length(a)-2)],[a(1) zeros(1,length(a)-2)]);
bbar=toeplitz([b zeros(1,length(b)-2)], [b(1) zeros(1,length(b)-2)]);
dce=conv(d,l);
qbar=(dce(1,2:length(dce))-[a(1,2:length(a)) zeros(1,length(a)-1)])';
par=[abar bbar]\qbar;
g=[1 par(1:0.5*length(par))']
m=[0 par(0.5*length(par)+1:length(par))']
den=conv(a,conv(g,n))+[conv(b,conv(f,m))];
r2ynum=conv(n,conv(f,b));
figure(1),dstep(r2ynum,den)
title('Y/R Step Response')
[sy1,sx1]=dstep(r2ynum,den);
S1=stepinfo(sy1,'SettlingTimeThreshold',0.02)

r2unum=conv(f,conv(a,n));
figure(2),dstep(r2unum,den)
title('U/R Step Response')
[sy2,sx2]=dstep(r2unum,den);
S2=stepinfo(sy2,'SettlingTimeThreshold',0.02)