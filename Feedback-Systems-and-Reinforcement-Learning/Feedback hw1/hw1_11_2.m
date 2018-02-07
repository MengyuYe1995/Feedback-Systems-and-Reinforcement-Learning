clear all
a=0;b=0;c=0;j=1;

    while j<5001
        pi=[0.1 0.9 0];
        q=[1/3 1/3 1/3];
        u1=rand;
        u2=rand;
        x=ceil(3*u1);
        cc=0.9*3;
        if u2<pi(x)/(cc*q(x))
        xx(j)=x;
        j=j+1;
        end
    end
for i=1:5000
    if xx(i)==1
        a=a+1;
    elseif xx(i)==2
        b=b+1;
    end
end
pi_real(:,1)=[a,b,c]/5000;

d=2;
for k=1:500
a=0;b=0;c=0;i=1;
while i<5001
    flag=0;
    while flag==0
    if xx(i)==1
        pi=[0.3 0.3 0.4];
        q=[1/3 1/3 1/3];
        u1=rand;
        u2=rand;
        x=ceil(3*u1);
        cc=0.4*3;
        if u2<pi(x)/(cc*q(x))
        xxx(i)=x;
        flag=1;
        end
    elseif xx(i)==2
        pi=[0.1 0.9 0];
        q=[1/3 1/3 1/3];
        u1=rand;
        u2=rand;
        x=ceil(3*u1);
        cc=0.9*3;
        if u2<pi(x)/(cc*q(x))
        xxx(i)=x;
        flag=1;
        end
    elseif xx(i)==3
        pi=[0.1 0.1 0.8];
        q=[1/3 1/3 1/3];
        u1=rand;
        u2=rand;
        x=ceil(3*u1);
        cc=0.8*3;
        if u2<pi(x)/(cc*q(x))
        xxx(i)=x;
        flag=1;
        end
    end
    end
    xx(i)=xxx(i);
    i=i+1;
end

    for ii=1:5000
    if xx(ii)==1
        a=a+1;
    elseif xx(ii)==2
        b=b+1;
    elseif xx(ii)==3
        c=c+1;
    end
    end
    pi_real(:,d)=[a,b,c]/5000;
    
d=d+1;
end
