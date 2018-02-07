clear all
close all

c=[1 0 0 0 2 0 0 -0.1 0 0 0 0 0.01];
M=length(c);
N=35;%length of the equalizer 
lambda=0.0009;
ro=0.12
om=1.1;

%select training sequence length
%p=input('enter training/source sequence length (try 4000) = ');
p=10000;
%set up time vector
time=[1:p];
%set up white, zero-mean, BPSK source
s=sign(rand(size(time))-.5);
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
y=filter(F,[1,zeros(1,34)],r);
y_useful=y(1+delt:p);
delayed_s=s(1:p);
err_total_mmse=0;
for i=1:p-delt
    err_total_mmse=(y_useful(i)-delayed_s(i))^2+err_total_mmse;
end
err_av_mmse=err_total_mmse/(p-delt)%average summed squared parameter error of mmse

mu=0.002;
st=s';
itno=p-M-N;
strt=M+N;
f=zeros(N,itno);
sspe=zeros(1,itno);
e=zeros(size(st));
fdelt=f_opt(:,delt);
df=0.5;
f(:,strt)=fdelt-df*2*(rand(size(f(:,strt)))...
          -0.5*ones(size(f(:,strt))));
for i=strt:itno-1
yeq(i)=f(:,i)'*flipud(r(i-N-M+2:i-M+1)');
qyeq(i)=sign(yeq(i));
e(i)=st(i-delt+1,1)-yeq(i);
f(:,i+1)=f(:,i)+mu*e(i)*flipud(r(i-(N-1)-M+1:i-M+1)'); 
sspe(i+1)=(fdelt-f(:,i+1))'*(fdelt-f(:,i+1));
end
ww=[0:pi/100:pi];
comdelt=conv(fdelt,c);
frcod=freqz(comdelt,1,ww);
[fradin]=freqz(conv(c,f(:,strt)),1,ww);
[fras]=freqz(conv(c,f(:,itno)),1,ww);
figure(1),plot(ww,20*log10(abs(fras)),'.', ww,20*log10(abs(frcod)),'-',ww,20*log10(abs(fradin)),'--k')
title('Combo Freq Resp Magnitude')

filter(f(:,itno),[1,zeros(1,34)],r);
y_useful=y(1+delt:p);
delayed_s=s(1:p);
err_total_lms=0;
for i=1:p-delt
    err_total_lms=(y_useful(i)-delayed_s(i))^2+err_total_lms;
end
err_av_lms=err_total_lms/(p-delt)%average summed squared parameter error of mmse
sys = tf(f(:,itno)',[1,zeros(1,N-1)])
figure(2),pzmap(sys);
figure(3),freqz(F,[1,zeros(1,N-1)]);
figure(4),plot([1:itno-strt],e(strt:itno-1).*e(strt:itno-1),'.');
figure(5),plot([1:itno-strt],yeq(strt:itno-1),'.')
figure(6),plot(f(:,itno),'.');%the equalizer¡¯s instantaneous impulse response
hold on
plot(F,'o')
hold off
figure(7),freqz(F,[1,zeros(1,34)]);
hold on
freqz(f(:,itno),[1,zeros(1,34)]);
