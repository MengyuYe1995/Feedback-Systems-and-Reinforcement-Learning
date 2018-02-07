%lpfID
    %Lowpass filter design by inverse dft with/without Hamming window
    %crjjr 9/11/16
    clear all
    om=0.6*pi; L=24; pass = fix(om*L/(2*pi))+ 1;
    A=[zeros(1,pass),ones(1,L/2-pass),-ones(1,L/2-pass),zeros(1,pass)];
    %figure(1), plot(A)
    M=(L-1)/2; k=[0:L-1]; p=exp(2*pi*j*(-M)*k/L); H=A.*p;
    %figure(2), plot(unwrap(angle(p)))
    h=ifft(H); h=real(h); zros=roots(h) 
    %figure(3), stem(h)
    %figure(4), freqz(h)
    BB=fft(h,512);gfft=abs(BB); %figure(5), plot(fftshift(gfft))
    sys=tf(h,[1,zeros(1,L-1)],1) 
    BBH=fft(hamming(L).'.*h,512);gffth=abs(BBH);
    %figure(8), plot(fftshift(gffth))
    sysH=tf(hamming(L).'.*h,[1,zeros(1,L-1)],1);
    %figure(11), stem(hamming(L))
    figure(12),freqz((hamming(L).'.*h))
    a=filter(hamming(L).'.*h,[1,zeros(1,L-1)],ones(1,L));
    k=(1:2*L);
    x1(k)=10*cos(0.5*pi*k);
    b=filter(hamming(L).'.*h,[1,zeros(1,L-1)],x1(k));
    figure(13),plot(b)
    x2(k)=10*cos(0.75*pi*k);
    b=filter(hamming(L).'.*h,[1,zeros(1,L-1)],x2(k));
    figure(14),plot(b)
    x3(k)=10*ones(1,2*L);
    b=filter(hamming(L).'.*h,[1,zeros(1,L-1)],x3(k));
    figure(15),plot(b)
    
    