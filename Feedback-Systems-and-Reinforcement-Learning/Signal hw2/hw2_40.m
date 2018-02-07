clear all
clc
%step0
for i=1:10
    m(i)=1;
    c_av(i)=normrnd(i,i);
end
s=10;n=s+1;
B=50;%upper bound
ef=3;%Exploration factor(>1)
%find(c_av==max(c_av))
for i=n:1000
    %step1a
    for ii=1:10
        buffer(ii)=c_av(ii)+B*sqrt(ef*log(i)/m(ii));
    end
    label=find(buffer==max(buffer));
    %step1b
    c_av(label)=(c_av(label)*m(label)+normrnd(label,label))/(m(label)+1);
    m(label)=m(label)+1;
end
theta_best=find(c_av==max(c_av))
total=0;
% for i=1:1000
%     total=total+normrnd(theta_best,theta_best);
% end
c_av_opt=total;
c_av_emp=c_av*m';
regret=(10*1000-c_av_emp)

regret_theory=0;
for i=1:9
    regret_theory=regret_theory+4*log(1000)/(10-i)+8*(10-i);
end
regret_theory
