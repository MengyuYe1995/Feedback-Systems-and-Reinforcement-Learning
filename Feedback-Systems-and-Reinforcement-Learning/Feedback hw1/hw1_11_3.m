clear all
a=0;b=0;
for i=1:5000
    u1=rand;
    if u1<0.1
        x0(i)=1;
        a=a+1;
    else
        x0(i)=2;
        b=b+1;
    end
    pi(:,1)=[a,b,0]/5000;
end
x=x0;
a=0;b=0;c=0;
for j=1:500
for i=1:5000
    if x(i)==1
        u2=rand;
        if u2<0.3
            x(i)=1;
            a=a+1;
        elseif u2>=0.3&&u2<0.6
            x(i)=2;
            b=b+1;
        else
            x(i)=3;
            c=c+1;
        end
    elseif x(i)==2
        u2=rand;
        if u2<0.1
            x(i)=1;
            a=a+1;
        else
            x(i)=2;
            b=b+1;
        end
    elseif x(i)==3
        u2=rand;
        if u2<0.1
            x(i)=1;
            a=a+1;
        elseif u2>=0.1&&u2<0.2
            x(i)=2;
            b=b+1;
        else
            x(i)=3;
            c=c+1;
        end
    end
end
end
proportion=[a,b,c]/5000/500;