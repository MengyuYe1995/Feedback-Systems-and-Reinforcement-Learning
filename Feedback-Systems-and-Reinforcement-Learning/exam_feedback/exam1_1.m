clear all
clc
a=0;b=0;
A1=[0.95 0.05;0.1 0.9];
A2=[0.55 0.45;0.45 0.55];
pix(:,1)=[1,0];
piz(:,1)=[0,1];
x=-1*ones(1,5000);
z=1*ones(1,5000);
d=2;e=2;
for j=1:100
a=0;b=0;c=0;d=0;
for i=1:5000
    if x(i)==-1
        u2=rand;
        if u2<0.95
            x(i)=-1;
            a=a+1;
        else
            x(i)=1;
            b=b+1;
        end
    elseif x(i)==1
        u2=rand;
        if u2<0.9
            x(i)=1;
            b=b+1;
        else
            x(i)=-1;
            a=a+1;
        end
    end
end
for ii=1:5000
    if z(ii)==-1
        u2=rand;
        if u2<0.55
            z(ii)=-1;
            c=c+1;
        else
            z(ii)=1;
            d=d+1;
        end
    elseif z(ii)==1
        u2=rand;
        if u2<0.55
            z(ii)=1;
            d=d+1;
        else
            z(ii)=-1;
            c=c+1;
        end
    end
end
pix(:,e)=[a,b]/5000;
piz(:,e)=[c,d]/5000;
e=e+1;

Ey_est(e-2)=-pix(1,e-1)-piz(1,e-1)+pix(2,e-1)+piz(2,e-1);

pix_predict=(A1')^(e-1-1)*pix(:,1);
piz_predict=(A2')^(e-1-1)*piz(:,1);
Ey_predict(e-2)=-pix_predict(1,1)+pix_predict(2,1)-piz_predict(1,1)+piz_predict(2,1);
end
figure(1)
plot(Ey_est)
hold on
plot(Ey_predict)
xlabel('iteration k')
ylabel('Ey-est AND Ey-predict')
title('performance conparsion')  
