clear all
close all

c=[1 0 0 0 2 0 0 -0.1 0 0 0 0 0.01];
M=length(c);
N=35;%length of the equalizer 
lambda=0.09;
ro=0.12;
om=1.1;

%select training sequence length
%p=input('enter training/source sequence length (try 4000) = ');
p=4000;
%set up time vector
time=[1:p];
%set up white, zero-mean, PAM source
yo=(rand(size(time))-.5);
for indx=1:p
if abs(yo(indx)) > 0.25
s(indx)=3*sign(yo(indx));
else
s(indx)=sign(yo(indx));
end
end
s_after_channel=filter(c,[1 zeros(1,12)],s);
sigma_s=sqrt(5);
%set up r(k)
beta=sqrt(3*lambda*sigma_s*sigma_s);
w=unifrnd(-beta,beta,1,p);
g=sqrt(sigma_s^2*2*ro);
cos_noise=zeros(1,p);
for i=1:p
   cos_noise(i)=g*sin(om*(i-1));
end
r=cos_noise+s_after_channel+w;

cosvec=cos(om*[0:(N-1)])';
V=toeplitz(cosvec);   %interference matrix
C=toeplitz([c,zeros(1,N-1)],[c(1),zeros(1,N-1)]);
f_opt=inv(C'*C+lambda*eye(N)+ro*V)*C';
[mmse,optind]=min(diag(eye(size(C*f_opt))-C*f_opt));
delt=optind-1;
optimum_delay=delt
mmse_w_opt_delay=mmse

F=f_opt(:,optind)';
y=filter(F,[1,zeros(1,N-1)],r);
y_useful=y(1+delt:p);
delayed_s=s(1:p);
err_total=0;
for i=1:p-delt
    err_total=(y_useful(i)-delayed_s(i))^2+err_total;
end
err_av=err_total/(p-delt)


correct=0;
for i=1:p-delt
    if delayed_s(i)==3&&y_useful(i)>=2
        correct=correct+1;
    elseif delayed_s(i)==1&&y_useful(i)<2&&y_useful(i)>=0
        correct=correct+1;
    elseif delayed_s(i)==-1&&y_useful(i)<0&&y_useful(i)>=-2
        correct=correct+1;
    elseif delayed_s(i)==-3&&y_useful(i)<-2
        correct=correct+1;
    end
end
err=p-delt-correct;
percent_error=err/(p-delt)
figure(1),freqz(F,[1,zeros(1,N-1)]);%the equalizer¡¯s frequency response
figure(2),stem(F,'.');%the equalizer¡¯s instantaneous impulse response
figure(3),freqz(conv(F,c),[1,zeros(1,N+M-2)]);%Combo Freq Resp
figure(4),plot(1:p-delt,y_useful,'.');
%eyediagram(y,2);%the degree of eye-opening achieved
