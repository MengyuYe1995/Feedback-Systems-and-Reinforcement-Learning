clear all
clc
%step0
for i=1:9
    m(i)=1;
    c_av(i)=binornd(1,i/10);
end
s=9;n=s+1;
B=1;%upper bound
ef=1.1;%Exploration factor(>1)
%find(c_av==max(c_av))
for i=n:100
    for ii=1:9
        buffer(ii)=c_av(ii)+B*sqrt(ef*log(i)/m(ii));
    end
    label=find(buffer==max(buffer));
    c_av(label(1))=(c_av(label(1))*m(label(1))+binornd(1,label(1)/10))/(m(label(1))+1);
    m(label(1))=m(label(1))+1;
end
theta_best=find(c_av==max(c_av))
total=0;
c_av_emp=c_av*m';
regret=0.9*100-c_av_emp

