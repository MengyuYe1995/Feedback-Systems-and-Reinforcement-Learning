clear all
clc
% RLS algo
NoOfData = 1000 ;  % Set no of data points used for training
Lambda = 0.5 ;    % Set the forgetting factor
Delta = 0.001 ;    % P initialized to Delta*I
x = randn(NoOfData, 1)*30 ;% Input assumed to be white
w=rand(1,NoOfData);%noise
a1=1.5;a2=2.5;
b=[a1,a2];
a=[1 zeros(1,2)];  
d = filter(b, a, x)+w ;  % Generate output (desired signal)
% Initialize RLS
P = Delta * eye (2,2) ;
w = zeros (2,1);
% RLS Adaptation
for n = 2 : NoOfData ;
  u = x(n:-1:n-2+1) ;
  pi_ = u' * P ;
  k = Lambda + pi_ * u ;
  K = pi_'/k;
  e(n) = d(n) - w' * u ;
  w = w + K * e(n) ;
  PPrime = K * pi_ ;
  P = ( P - PPrime )  ;
  w_err(n) = norm(b - w) ;
end ;
% Plot results
figure ;
plot(20*log10(abs(e))) ;
title('Learning Curve') ;
xlabel('Iteration Number') ;
ylabel('Output Estimation Error in dB') ;
figure ;
semilogy(w_err);
title('Weight Estimation Error') ;
xlabel('Iteration Number') ;
ylabel('Weight Error in dB') ; 