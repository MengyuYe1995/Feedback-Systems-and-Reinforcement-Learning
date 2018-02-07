clear all
close all

c=[1 0 0 0 2 0 0 -0.1 0 0 0 0 0.01];
M=length(c);
N=35;%length of the equalizer 
lambda=0.09;
b=1;
z=0;
delay=zeros(1,13);
err_av=zeros(1,13);
for ro=0:0.01:0.12;
om=1.1;
%select training sequence length
%p=input('enter training/source sequence length (try 4000) = ');
p=4000;
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
err_total=0;
for i=1:p-delt
    err_total=(y_useful(i)-delayed_s(i))^2+err_total;
end
delay(b)=delt;
b=b+1;
%eyediagram(y,2)
for ii=1:p-delt
    err_total=(y_useful(ii)-delayed_s(ii))^2+err_total;
end
z=z+1;
err_av(z)=err_total/(p-delt);
end
figure(1),plot(0:0.01:0.12,delay);
figure(2),plot(0:0.01:0.12,err_av);
