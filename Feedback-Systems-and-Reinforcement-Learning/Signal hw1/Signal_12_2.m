clear all
close all

%rawtp=input('enter the parameter of the channel,try:[1 0 0 0 2 0 0 -0.1 0 0 0 0 0.01]:');
rawtp=[1 0 0 0 2 0 0 -0.1 0 0 0 0 0.01]';
M=length(rawtp);
%N=input('enter the length of the equalizer,try less than 35:');%length of the equalizer 
N=35;
%lambda=input('enter the parameter of brandwidth noise power,try:0.0001 :');
lambda=0.0001;
%ro=input('enter the parameter of sin or cos interpreter noise power,try:0 :');
ro=0;
om=1.1;
ng=sqrt(3*lambda);
sg=sqrt(2*ro);
c=(sqrt((1-ng*(ng/3)-0.5*sg*sg)/(rawtp'*rawtp))*rawtp)';

%select training sequence length
%p=input('enter training/source sequence length (try 350/5000/8000/10000) = ');
p=10000;
%set up time vector
time=[1:p];
%set up white, zero-mean, PAM source
yo=(rand(size(time))-.5);
for indx=1:p
if abs(yo(indx)) > 0.375
    s(indx)=7*sign(yo(indx))/sqrt(21);
elseif abs(yo(indx))<=0.375&&abs(yo(indx))>0.25
    s(indx)=5*sign(yo(indx))/sqrt(21);
elseif abs(yo(indx))<=0.25&&abs(yo(indx))>0.125
    s(indx)=3*sign(yo(indx))/sqrt(21);
else
s(indx)=sign(yo(indx))/sqrt(21);
end
end
dc=1.7619;   %dispersion constant
s_after_channel=filter(c,[1 zeros(1,12)],s);
sigma_s=1;
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

%mu=input('enter the step size of LMS solution,try:0.02:');
mu=0.02;
st=s';
itno=p-M-N;
strt=M+N;
f=zeros(N,itno);
sspe=zeros(1,itno);
e=zeros(size(st));
fdelt=f_opt(:,delt);
df=0.5;
f(:,strt)=fdelt-df*2*(rand(size(f(:,strt)))-0.5*ones(size(f(:,strt))));

for i=strt:350-M-N
yeq(i)=f(:,i)'*flipud(r(i-N-M+2:i-M+1)');
if abs(yeq(i))>=6/sqrt(21)
    qyeq(i)=sign(yeq(i))*7/sqrt(21);
elseif abs(yeq(i))<6/sqrt(21)&&abs(yeq(i))>=4/sqrt(21)
    qyeq(i)=sign(yeq(i))*5/sqrt(21);
elseif abs(yeq(i))<4/sqrt(21)&&abs(yeq(i))>=2/sqrt(21)
    qyeq(i)=sign(yeq(i))*3/sqrt(21);
else
    qyeq(i)=sign(yeq(i))/sqrt(21);
end

e(i)=st(i-delt+1,1)-yeq(i);
f(:,i+1)=f(:,i)+mu*e(i)*flipud(r(i-(N-1)-M+1:i-M+1)'); %LMS
sspe(i+1)=(fdelt-f(:,i+1))'*(fdelt-f(:,i+1));
end

ww=[0:pi/100:pi];
comdelt=conv(fdelt,c);
frcod=freqz(comdelt,1,ww);
[fradin]=freqz(conv(c,f(:,strt)),1,ww);
[fras]=freqz(conv(c,f(:,350-M-N+1)),1,ww);
%after the LMS solution for about 350 points we can find that it's not
%close enough to the mmse solution.It means we need to do DMA to continue updating the F 
figure(1),plot(ww,20*log10(abs(fras)),'.', ww,20*log10(abs(frcod)),'-')
title('Combo Freq Resp Magnitude')

%mu2=input('enter the step size of DMA solution,try:0.001:');
mu2=0.001;
for i=303:itno-1
yeq(i)=f(:,i)'*flipud(r(i-N-M+2:i-M+1)');
if abs(yeq(i))>=6/sqrt(21)
    qyeq(i)=sign(yeq(i))*7/sqrt(21);
elseif abs(yeq(i))<6/sqrt(21)&&abs(yeq(i))>=4/sqrt(21)
    qyeq(i)=sign(yeq(i))*5/sqrt(21);
elseif abs(yeq(i))<4/sqrt(21)&&abs(yeq(i))>=2/sqrt(21)
    qyeq(i)=sign(yeq(i))*3/sqrt(21);
else
    qyeq(i)=sign(yeq(i))/sqrt(21);
end

e(i)=st(i-delt+1,1)-yeq(i);
f(:,i+1)=f(:,i)+mu2*yeq(i)*(dc-yeq(i)*yeq(i))*flipud(r(i-(N-1)-M+1:i-M+1)'); %DMA
sspe(i+1)=(fdelt-f(:,i+1))'*(fdelt-f(:,i+1));
end

ww=[0:pi/100:pi];
comdelt=conv(fdelt,c);
frcod=freqz(comdelt,1,ww);
[fradin]=freqz(conv(c,f(:,strt)),1,ww);
[fras]=freqz(conv(c,f(:,itno)),1,ww);
%if the combined response of LMS/DMA are nearly close to the MMSE solution then we succeed 
figure(2),plot(ww,20*log10(abs(fras)),'.', ww,20*log10(abs(frcod)),'-')
title('Combo Freq Resp Magnitude')


correct=0;
for i=1:p-delt
    if delayed_s(i)==3/sqrt(21)&&y_useful(i)<4/sqrt(21)&&y_useful(i)>=2/sqrt(21)
        correct=correct+1;
    elseif delayed_s(i)==1/sqrt(21)&&y_useful(i)<2/sqrt(21)&&y_useful(i)>=0
        correct=correct+1;
    elseif delayed_s(i)==-1/sqrt(21)&&y_useful(i)<0&&y_useful(i)>=-2/sqrt(21)
        correct=correct+1;
    elseif delayed_s(i)==-3/sqrt(21)&&y_useful(i)<-2/sqrt(21)&&y_useful(i)>=-4/sqrt(21)
        correct=correct+1;
    elseif delayed_s(i)==5/sqrt(21)&&y_useful(i)<6/sqrt(21)&&y_useful(i)>=4/sqrt(21)
        correct=correct+1;
    elseif delayed_s(i)==-5/sqrt(21)&&y_useful(i)<-4/sqrt(21)&&y_useful(i)>=-6/sqrt(21)
        correct=correct+1;
    elseif delayed_s(i)==7/sqrt(21)&&y_useful(i)>=6/sqrt(21)
        correct=correct+1;
    elseif delayed_s(i)==-7/sqrt(21)&&y_useful(i)<-6/sqrt(21)
        correct=correct+1;
    end
end
err=p-delt-correct;
percent_error=err/(p-delt)%percent error rate for mmse solution
%if the eyes are open and we can tell them with our own eyes,we succeed 
figure(3),plot([1:itno-strt],yeq(strt:itno-1),'.')
%if the error is small enough then we get a huge success
figure(4),plot([1:itno-strt],e(strt:itno-1).*e(strt:itno-1),'.');