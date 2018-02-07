clear all
clc
%step0
for i=1:9
    m(i)=1;
    c_av(i)=binornd(1,i/10);
end
s=9;n=s+1;
for t=n:100
    %step1a
    for ii=1:9
        cvx_begin
        variable q
        maximize q
        subject to
            q>=0.01
            q<=1
            m(ii)*(c_av(ii)*(log(c_av(ii)+0.01)-log(q))+(1-c_av(ii))*(log(1-c_av(ii)+0.01)-log(1-q)))<=log((exp(1)*t)*log(exp(1)*t)^(3))
        cvx_end
        buffer(ii)=q;
    end
    label=find(buffer==max(buffer));
    label_max=label(1);
    c_av_max=c_av(label(1));
    for i=1:length(label)
        if c_av(i)>c_av_max
            label_max=label(i);
            c_av_max=c_av(label(i));
        end
    end
    c_av(label_max)=(c_av(label_max)*m(label_max)+binornd(1,label_max/10))/(m(label_max)+1);
    m(label_max)=m(label_max)+1;
end
theta_best=find(c_av==max(c_av))
regret=(0.9*100-c_av*m')