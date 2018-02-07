clear all
clc
data = importdata('/Users/leafy/Downloads/haberman.data.txt');
x(:,1:3) = data(:,1:3);
y(:,1) = data(:,4);
y=y-ones(306,1);
train_data=x(1:240,:);train_label=y(1:240,:);test_data=x(241:306,:);test_label=y(241:306,:);
nb = fitcnb(train_data,train_label);
predict_label=predict(nb,test_data);
accuracy=length(find(predict_label==test_label))/length(test_label)