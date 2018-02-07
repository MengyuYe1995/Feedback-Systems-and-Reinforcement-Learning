clear all
clc
data = importdata('/Users/leafy/Downloads/haberman.data.txt');
x(:,1:3) = data(:,1:3);
y(:,1) = data(:,4);
y=y-ones(306,1);
b = glmfit(x(1:240,1:3),[y(1:240,1),ones(240,1)],'binomial', 'link', 'logit');
logitFit = glmval(b,x(241:306,1:3), 'logit');
test_label_true=y(241:306);
true=0;

%z=b(1)*ones(66,1)+x(241:306,1:3)*b(2:4,1);

test_label_est=zeros(1,length(test_label_true));
for i=1:length(test_label_true)
    if logitFit(i)>0.5
    test_label_est(i)=1;
    else 
        test_label_est(i)=0;
    end
    if test_label_est(i)==test_label_true(i)
        true=true+1;
    end
end
accuracy=true/length(test_label_true)