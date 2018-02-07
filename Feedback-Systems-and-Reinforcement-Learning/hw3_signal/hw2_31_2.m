%signal1
mu=0;                     
sigma=2.02;                 
b=sigma/sqrt(2);     
a=rand(1,100000)-0.5;    
x1=mu-b*sign(a).*log(1-2*abs(a)); 
%signal2
mu=0;                     
sigma=2.02;                 
b=sigma/sqrt(2);     
a=rand(1,100000)-0.5;    
x2=mu-b*sign(a).*log(1-2*abs(a));

X=[x1;x2];
A=rand(2,2);
Y=A*X;

W_Standard=A^(-1);
W=rand(2,2);

aplha=0.01;

for i=1:100000
    W=W+aplha*([1-2/(1+exp(-W(1,:)*Y(:,i)));1-2/(1+exp(-W(2,:)*Y(:,i)))]*Y(:,i)'+(W')^(-1))
    %W=W+aplha*([-0.3466-1.414*abs(-W(1,:)*Y(:,i));-0.3466-1.414*abs(-W(2,:)*Y(:,i));-0.3466-1.414*abs(-W(3,:)*Y(:,i))]*Y(:,i)'+(W')^(-1));
end
X_est=W*Y;