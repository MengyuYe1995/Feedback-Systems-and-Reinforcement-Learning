%generate 1000 training data
shift =1;
n = 2;%2 dim
sigma = 1;
N = 1000;
y = [randn(n,N/2)-shift, randn(n,N/2)*sigma+shift];%generate N gaussian training point
x = [ones(N/2,1);-ones(N/2,1)];

%show the training data
figure;
plot(y(1,1:N/2),y(2,1:N/2),'rs');
hold on;
plot(y(1,1+N/2:N),y(2,1+N/2:N),'go');
title('1000 training data');
legend('Positve samples','Negative samples','Location','SouthEast');

%fit the training model into gaussian model
y_pos = y(:,x==1);
model_pos.mu = mean(y_pos,2);
model_pos.var = cov(y_pos');
model_pos.prior = length(y_pos)/length(y);

y_neg = y(:,x~=1);
model_neg.mu = mean(y_neg,2);
model_neg.var = cov(y_neg');
model_neg.prior = length(y_neg)/length(y);


%generate the 100 testing data
% test on new dataset, same distribution

sigma = 1;
N = 100;
y_test = [randn(n,N/2)-shift, randn(n,N/2)*sigma+shift];
x_test = [ones(N/2,1);-ones(N/2,1)];
figure;
plot(y_test(1,1:N/2),y_test(2,1:N/2),'rs');
hold on;
plot(y_test(1,1+N/2:N),y_test(2,1+N/2:N),'go');
title('100 testing data');
legend('Positve samples','Negative samples','Location','SouthEast');


%classify the testing set
mu1 = model_pos.mu;
sigma1 = model_pos.var;
p1 = model_pos.prior;

mu2 = model_neg.mu;
sigma2 = model_neg.var;
p2 = model_neg.prior;

bias = 0.5*log(det(sigma2))-0.5*log(det(sigma1))+log(p1/p2);
err = 0;
h = zeros(size(x_test));
for i=1:length(x_test)
   c = bias + 0.5*(y_test(:,i)-mu2)'/sigma2*(y_test(:,i)-mu2) - 0.5*(y_test(:,i)-mu1)'/sigma1*(y_test(:,i)-mu1);
   if c > 0
       h(i) = 1;
   else
       h(i) = -1;
   end
   if h(i)~=x_test(i)
       err = err + 1;
   end   
end
%missclassification rate
rate=err/100
