clear all
%loading
[s,Fs]=audioread('HW2.m4a');%recording frequency Fs=44100Hz
N = length(s);%length of input signal
w=5*randn(1,N);%white noise
%G=0.2*[0.8,1.4,0.7];% filter the noise before it is added to the speech signal
G=1;
lg=length(G);
%v=zeros([1,N]);
for ind=lg:N,
    ww=w(1,[ind:-1:ind-lg+1]);    
    v(ind)=G*ww'+s(ind);%signal adding the noise
end
%sound(v,Fs);%play the signal with the white noise

%LMS
W=toeplitz(w,[w(1) zeros(lg-1)]);
F = zeros(lg,1);
E = zeros(1,N);
mu = 0.0001;%adjust the step size until you get the clear voice!!!
for i=1:N
    E(i)=v(i)-W(i,:)*F;
    F=F+mu*W(i,:)'*E(i);  
end
sound(E,Fs);%play the signal getting rid of the white noise
figure(1) 
subplot(3,1,1), plot(w),title('w'),axis([0,N,-15,15])
subplot(3,1,2), plot(v),title('v'),axis([0,N,-10,10])
subplot(3,1,3), plot(E),title('e'),axis([0,N,-1,1])