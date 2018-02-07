clear all
A=[1 0.2 -0.4;-0.3 0.45 0.7;1.1 0.2 -1.2];b=[0.4;-1.1;2.3];c=[0.3 0.9 0.06];d=0.4;
[num,den]=ss2tf(A,b,c,d);
plant_poles=roots(den);
plant_zeros=roots(num);
C=[A*A*b A*b b];
O=[c;c*A;c*A*A];
eig(C);
eig(O)

g=0.001;
new_den=den+g*num;
plant_new_poles=roots(new_den)
rlocus(num,den)