%stdft
    %short time dft for sine with frequency change
    %8/19/16
 clear all
ind1=[1:425]; ind2=[426:1024]; N=100;
x=[sin(26*2*(pi/N)*ind1),sin(17*2*(pi/N)*ind2)];
%figure(1), plot(x(300:500),'*k:')
xx=fft(x);
%figure(2), plot(fftshift(abs(xx))), grid
xx1=fft(x(100:356)); figure(3), plot(fftshift(abs(xx1))), grid
%xx2=fft(x(200:456)); figure(4), plot(fftshift(abs(xx2))), grid
%xx3=fft(x(300:556)); figure(5), plot(fftshift(abs(xx3))), grid
%xx4=fft(x(400:656)); figure(6), plot(fftshift(abs(xx4))), grid
%xx5=fft(x(500:756)); figure(7), plot(fftshift(abs(xx5))), grid
xax=[(-128:128)/257*(26*2*3.14/257)];%http://www.ilovematlab.cn/thread-38878-1-1.html
figure(6), plot(xax,fftshift(abs(xx1))), grid

