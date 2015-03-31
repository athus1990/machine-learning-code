clear; clc; close all;
rng(1);
Np = 4;
x=[2, 2;2, -2;-2, -2;-2, 2];
y=[1, 1;1, -1; -1, -1;-1, 1];
X=[x;y]


for i=1:length(x)
if(sqrt(x(i, 1)^2+x(i, 2)^2)>2)
    pi(i, 1)=4-x(i, 2)+abs(x(i, 1)-x(i, 2));
    pi(i, 2)=4-x(i, 1)+abs(x(i, 1)-x(i, 2));
else
    pi(i, 1)=x(i, 1);
    pi(i, 2)=x(i, 2);
end
end


for i=1:length(x)
if(sqrt(y(i, 1)^2+y(i, 2)^2)>2)
    pi1(i, 1)=4-y(i, 2)+abs(y(i, 1)-y(i, 2));
    pi1(i, 2)=4-y(i, 1)+abs(y(i, 1)-y(i, 2));
else
    pi1(i, 1)=y(i, 1);
    pi1(i, 2)=y(i, 2);
end
end
x=pi;
y=pi1;
Nn = 4;
scatter(x(:,1),x(:,2),50,'g*')
hold on;
scatter(y(:,1),y(:,2),50,'r+')
hold off;

data = cat(1,x,y);
group = cat(1,ones(4,1),-ones(4,1));
svmstruct = svmtrain(data,group,'showplot',1,'autoscale',0,'kernel_function','quadratic');

% Can we prove that we would get the same results using a linear SVM on the
% transformed data? Yes.
figure 
DATA = cat(1,ones(Np+Nn,1),...
    data(:,1).^2,...
    sqrt(2)*prod(data,2),...
    data(:,2).^2,...
    sqrt(2)*data(:,1),...
    sqrt(2)*data(:,2));
svmstruct2 = svmtrain(DATA,group,'showplot',1,'autoscale',0,'kernel_function','linear');

%% MATLAB example (uncomment the lines below
% Load the data and select features for classification
% load fisheriris
% X = [meas(:,1), meas(:,2)];
% % Extract the Setosa class
% Y = nominal(ismember(species,'setosa'));
% % Randomly partitions observations into a training set and a test
% % set using stratified holdout
% P = cvpartition(Y,'Holdout',0.20);
% % Use a linear support vector machine classifier
% svmStruct = svmtrain(X(P.training,:),Y(P.training),'showplot',true);
% C = svmclassify(svmStruct,X(P.test,:),'showplot',true);
% errRate = sum(Y(P.test)~= C)/P.TestSize  %mis-classification rate
% conMat = confusionmat(Y(P.test),C) % the confusion matrix