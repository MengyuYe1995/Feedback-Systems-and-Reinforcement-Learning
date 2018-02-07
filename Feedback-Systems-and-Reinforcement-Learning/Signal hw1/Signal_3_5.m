clear all
N=33;
g1=1; om1=2*pi*(8/(2*N)); g2=1; 

om2=2*pi*(14/(2*N));
x0=cos(om1*[1:N]);
y0=abs(fftshift(fft(x0,N)));
xax=[-16*2*pi/N:2*pi/N:(N-17)*2*pi/N];
%figure(1), plot(x0,'k*:')
figure(2), stem(y0,'k'), grid minor
figure(3), stem(xax,y0,'k'), grid minor

x1=g1*g2*(cos(om1*[1:N]).*cos(om2*[1:N]));
y1=abs(fftshift(fft(x1,N)));
%figure(4), plot(x1,'k*:')
figure(5), stem(y1,'k'), grid minor
xax=[-16*2*pi/N:2*pi/N:(N-17)*2*pi/N];
figure(6), stem(xax,y1,'k'), grid minor
