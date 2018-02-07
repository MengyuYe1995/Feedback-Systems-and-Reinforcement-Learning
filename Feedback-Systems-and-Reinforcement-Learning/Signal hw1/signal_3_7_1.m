%stdft
%short time dft for sine with frequency change
%8/19/16
clear all
ind1=[1:425]; ind2=[426:1024]; N=1024;
x=[sin(266.24*2*(pi/N)*ind1),sin(174.08*2*(pi/N)*ind2)];
figure(1), plot(x(30:50),'*k:')
xx=fft(x);
figure(2), plot(fftshift(abs(xx))), grid
xx1=fft(x(100:350)); figure(3), plot(fftshift(abs(xx1))), grid
xx2=fft(x(200:450)); figure(4), plot(fftshift(abs(xx2))), grid
xx3=fft(x(300:550)); figure(5), plot(fftshift(abs(xx3))), grid
xx4=fft(x(400:650)); figure(6), plot(fftshift(abs(xx4))), grid
xx5=fft(x(500:750)); figure(7), plot(fftshift(abs(xx5))), grid