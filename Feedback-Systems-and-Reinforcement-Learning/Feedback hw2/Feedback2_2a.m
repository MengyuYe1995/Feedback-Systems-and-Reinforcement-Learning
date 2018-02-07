clear all
A=[0.7 -0.2 0 0.3;0 0.8 0.3 -0.4;-0.1 0.3 0 -0.2;0.2 -0.2 0.9 0.8];
b=[0.11;-0.04;0.08;0];
c=[0.5 -2 0 3];d=0;
dp=[0.1+0.4i 0.1-0.4i 0.6082-0.0620i 0.6082+0.0620i];
k=place(A,b,dp)
t=100;
[sy,sx]=dstep(A-b*k,b,c,d,1,t);
dstep(A-b*k,b,c,d,1,t);
S=stepinfo(sy,'SettlingTimeThreshold',0.02)