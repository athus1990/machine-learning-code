clc
clear all
%nhidden = input('input the number of hidden nodes(100/500/1000):');
disp('########################################')
[training,testing] = setupMNIST(); 
nhidden = 1000;
ntrain=100;
train.data=training.data(:,1:ntrain);
train.labels=training.labels(1:ntrain,1);
out=zeros(ntrain,10);

for i=1:length(train.labels)
out(i,(train.labels(i)+1))=1;
end
net_1000_100=mlp(784,nhidden,10,'logistic');
options = zeros(1,18);
options(1) = 1; %display iteration values
options(14) = 500; %maximum number of training cycles (epochs)
[net_1000_100] = netopt(net_1000_100,options,train.data',out,'scg');
for i=1:length(testing.data)
y(i,:)=mlpfwd(net_1000_100,testing.data(:,i)');
end
[C,I] = max(y,[],2);
fans_1000_100=I-1;
clear  ntrain train.data train.labels a options y

%%
disp('########################################')
ntrain=1000;
train.data=training.data(:,1:ntrain);
train.labels=training.labels(1:ntrain,1);
out=zeros(ntrain,10);
for i=1:length(train.labels)
out(i,(train.labels(i)+1))=1;
end
net_1000_1000=mlp(784,nhidden,10,'logistic');
options = zeros(1,18);
options(1) = 1; %display iteration values
options(14) = 500; %maximum number of training cycles (epochs)
[net_1000_1000,options] = netopt(net_1000_1000,options,train.data',out,'scg');
for i=1:length(testing.data)
y(i,:)=mlpfwd(net_1000_1000,testing.data(:,i)');
end
[C,I] = max(y,[],2);
fans_1000_1000=I-1;
clear  ntrain train.data train.labels a options y
%%
disp('########################################')
ntrain=10000;
train.data=training.data(:,1:ntrain);
train.labels=training.labels(1:ntrain,1);
out=zeros(ntrain,10);
for i=1:length(train.labels)
out(i,(train.labels(i)+1))=1;
end
net_1000_10000=mlp(784,nhidden,10,'logistic');
options = zeros(1,18);
options(1) = 1; %display iteration values
options(14) = 500; %maximum number of training cycles (epochs)
[net_1000_10000,options] = netopt(net_1000_10000,options,train.data',out,'scg');
for i=1:length(testing.data)
y(i,:)=mlpfwd(net_1000_10000,testing.data(:,i)');
end
[C,I] = max(y,[],2);
fans_1000_10000=I-1;
clear  ntrain train.data train.labels a options y

%%
disp('########################################')
ntrain=60000;
train.data=training.data(:,1:ntrain);
train.labels=training.labels(1:ntrain,1);
out=zeros(ntrain,10);
for i=1:length(train.labels)
out(i,(train.labels(i)+1))=1;
end
net_1000_60000=mlp(784,nhidden,10,'logistic');
options = zeros(1,18);
options(1) = 1; %display iteration values
options(14) = 500; %maximum number of training cycles (epochs)
[net_1000_60000,options] = netopt(net_1000_60000,options,train.data',out,'scg');
for i=1:length(testing.data)
y(i,:)=mlpfwd(net_1000_60000,testing.data(:,i)');
end
[C,I] = max(y,[],2);
fans_1000_60000=I-1;
clear  ntrain train.data train.labels a options y C I

%% NEW nhidden 2
clc
%nhidden = input('input the number of hidden nodes(100/500/1000):');
disp('########################################')
%[training,testing] = setupMNIST(); 
nhidden = 500;
ntrain=100;
train.data=training.data(:,1:ntrain);
train.labels=training.labels(1:ntrain,1);
out=zeros(ntrain,10);
for i=1:length(train.labels)
out(i,(train.labels(i)+1))=1;
end
net_500_100=mlp(784,nhidden,10,'logistic');
options = zeros(1,18);
options(1) = 1; %display iteration values
options(14) = 500; %maximum number of training cycles (epochs)
[net_500_100,options] = netopt(net_500_100,options,train.data',out,'scg');
for i=1:length(testing.data)
y(i,:)=mlpfwd(net_500_100,testing.data(:,i)');
end
[C,I] = max(y,[],2);
fans_500_100=I-1;
clear  ntrain train.data train.labels a options y C I

%%
disp('########################################')
ntrain=1000;
train.data=training.data(:,1:ntrain);
train.labels=training.labels(1:ntrain,1);
out=zeros(ntrain,10);
for i=1:length(train.labels)
out(i,(train.labels(i)+1))=1;
end
net_500_1000=mlp(784,nhidden,10,'logistic');
options = zeros(1,18);
options(1) = 1; %display iteration values
options(14) = 500; %maximum number of training cycles (epochs)
[net_500_1000,options] = netopt(net_500_1000,options,train.data',out,'scg');
for i=1:length(testing.data)
y(i,:)=mlpfwd(net_500_1000,testing.data(:,i)');
end
[C,I] = max(y,[],2);
fans_500_1000=I-1;
clear  ntrain train.data train.labels a options y
%%
disp('########################################')
ntrain=10000;
train.data=training.data(:,1:ntrain);
train.labels=training.labels(1:ntrain,1);
out=zeros(ntrain,10);
for i=1:length(train.labels)
out(i,(train.labels(i)+1))=1;
end
net_500_10000=mlp(784,nhidden,10,'logistic');
options = zeros(1,18);
options(1) = 1; %display iteration values
options(14) = 500; %maximum number of training cycles (epochs)
[net_500_10000,options] = netopt(net_500_10000,options,train.data',out,'scg');
for i=1:length(testing.data)
y(i,:)=mlpfwd(net_500_10000,testing.data(:,i)');
end
[C,I] = max(y,[],2);
fans_500_10000=I-1;
clear  ntrain train.data train.labels a options y

%%
disp('########################################')
ntrain=60000;
train.data=training.data(:,1:ntrain);
train.labels=training.labels(1:ntrain,1);
out=zeros(ntrain,10);
for i=1:length(train.labels)
out(i,(train.labels(i)+1))=1;
end
net_500_60000=mlp(784,nhidden,10,'logistic');
options = zeros(1,18);
options(1) = 1; %display iteration values
options(14) = 500; %maximum number of training cycles (epochs)
[net_500_60000,options] = netopt(net_500_60000,options,train.data',out,'scg');
for i=1:length(testing.data)
y(i,:)=mlpfwd(net_500_60000,testing.data(:,i)');
end
[C,I] = max(y,[],2);
fans_500_60000=I-1;
clear  ntrain train.data train.labels a options y C I

%% NEW HIDDEN 3
clc
%nhidden = input('input the number of hidden nodes(100/500/1000):');
disp('########################################')
%[training,testing] = setupMNIST(); 
nhidden = 100;
ntrain=100;
train.data=training.data(:,1:ntrain);
train.labels=training.labels(1:ntrain,1);
out=zeros(ntrain,10);
for i=1:length(train.labels)
out(i,(train.labels(i)+1))=1;
end
net_100_100=mlp(784,nhidden,10,'logistic');
options = zeros(1,18);
options(1) = 1; %display iteration values
options(14) = 500; %maximum number of training cycles (epochs)
[net_100_100,options] = netopt(net_100_100,options,train.data',out,'scg');
for i=1:length(testing.data)
y(i,:)=mlpfwd(net_100_100,testing.data(:,i)');
end
[C,I] = max(y,[],2);
fans_100_100=I-1;
clear  ntrain train.data train.labels a options y C I

%%
disp('########################################')
ntrain=1000;
train.data=training.data(:,1:ntrain);
train.labels=training.labels(1:ntrain,1);
out=zeros(ntrain,10);
for i=1:length(train.labels)
out(i,(train.labels(i)+1))=1;
end
net_100_1000=mlp(784,nhidden,10,'logistic');
options = zeros(1,18);
options(1) = 1; %display iteration values
options(14) = 500; %maximum number of training cycles (epochs)
[net_100_1000,options] = netopt(net_100_1000,options,train.data',out,'scg');
for i=1:length(testing.data)
y(i,:)=mlpfwd(net_100_1000,testing.data(:,i)');
end
[C,I] = max(y,[],2);
fans_100_1000=I-1;
clear  ntrain train.data train.labels a options y
%%
disp('########################################')
ntrain=10000;
train.data=training.data(:,1:ntrain);
train.labels=training.labels(1:ntrain,1);
out=zeros(ntrain,10);
for i=1:length(train.labels)
out(i,(train.labels(i)+1))=1;
end
net_100_10000=mlp(784,nhidden,10,'logistic');
options = zeros(1,18);
options(1) = 1; %display iteration values
options(14) = 500; %maximum number of training cycles (epochs)
[net_100_10000] = netopt(net_100_10000,options,train.data',out,'scg');
for i=1:length(testing.data)
y(i,:)=mlpfwd(net_100_10000,testing.data(:,i)');
end
[C,I] = max(y,[],2);
fans_100_10000=I-1;
clear  ntrain train.data train.labels a options y

%%
disp('########################################')
ntrain=60000;
train.data=training.data(:,1:ntrain);
train.labels=training.labels(1:ntrain,1);
out=zeros(ntrain,10);
for i=1:length(train.labels)
out(i,(train.labels(i)+1))=1;
end
net_100_60000=mlp(784,nhidden,10,'logistic');
options = zeros(1,18);
options(1) = 1; %display iteration values
options(14) = 500; %maximum number of training cycles (epochs)
[net_100_60000,options] = netopt(net_100_60000,options,train.data',out,'scg');
for i=1:length(testing.data)
y(i,:)=mlpfwd(net_100_60000,testing.data(:,i)');
end
[C,I] = max(y,[],2);
fans_100_60000=I-1;
clear  ntrain train.data train.labels a options y C I i
%% -----------------------------------------------
%% -----------------------------------------------
%% NOW JUST TESTING 
f=[fans_500_60000, fans_500_10000, fans_500_1000, fans_500_100, fans_100_60000, fans_100_10000, fans_100_1000, fans_100_100, fans_1000_60000, fans_1000_10000, fans_1000_1000, fans_1000_100];
for i=1:size(f,2)
Y(:,i)=(f(:,i)==testing.labels(:,1));
end
yfinal=sum(Y)/10000;
acurracy.label=['net_500_60000', 'net_500_10000', 'net_500_1000', 'net_500_100', 'net_100_60000', 'net_100_10000, net_100_1000', 'net_100_100', 'net_1000_60000','net_1000_10000', 'net_1000_1000', 'net_1000_100'];
[c,I]=max(yfinal(1,:));
fprintf('%d is the best network',yfinal(2,I));

clear Y 
%% NOW TEST TEST THE TRIAINING

clear y
y=mlpfwd(net_100_60000,training.data');
[C,I] = max(y,[],2);
ftans_100_60000=I-1;
clear y
y=mlpfwd(net_100_10000,training.data');
[C,I] = max(y,[],2);
ftans_100_10000=I-1;
clear y
y=mlpfwd(net_100_1000,training.data');
[C,I] = max(y,[],2);
ftans_100_1000=I-1;
clear y
y=mlpfwd(net_100_100,training.data');
[C,I] = max(y,[],2);
ftans_100_100=I-1;
clear y
%%
clear y
y=mlpfwd(net_500_60000,training.data');
[C,I] = max(y,[],2);
ftans_500_60000=I-1;
clear y
y=mlpfwd(net_500_10000,training.data');
[C,I] = max(y,[],2);
ftans_500_10000=I-1;
clear y
y=mlpfwd(net_500_1000,training.data');
[C,I] = max(y,[],2);
ftans_500_1000=I-1;
clear y
y=mlpfwd(net_500_100,training.data');
[C,I] = max(y,[],2);
ftans_500_100=I-1;
clear y
%%
clear y
y=mlpfwd(net_1000_60000,training.data');
[C,I] = max(y,[],2);
ftans_1000_60000=I-1;
clear y
y=mlpfwd(net_1000_10000,training.data');
[C,I] = max(y,[],2);
ftans_1000_10000=I-1;
clear y
y=mlpfwd(net_1000_1000,training.data');
[C,I] = max(y,[],2);
ftans_1000_1000=I-1;
clear y
y=mlpfwd(net_1000_100,training.data');
[C,I] = max(y,[],2);
ftans_1000_100=I-1;
clear y
ft=[ftans_500_60000, ftans_500_10000, ftans_500_1000, ftans_500_100, ftans_100_60000, ftans_100_10000, ftans_100_1000, ftans_100_100, ftans_1000_60000, ftans_1000_10000, ftans_1000_1000, ftans_1000_100];
for i=1:size(ft,2)
Y(:,i)=(ft(:,i)==training.labels(:,1));
end
yfinal=sum(Y)/60000;
accuracy.training=yfinal2';

%% NOW TEST VALIDATION THE TRIAINING
clear y Y

y=mlpfwd(net_100_60000,training.data(:,1:60000)');
[C,I] = max(y,[],2);
ftans_100_60000=I-1;
clear y
y=mlpfwd(net_100_10000,training.data(:,10001:60000)');
[C,I] = max(y,[],2);
ftans_100_10000=I-1;
clear y
y=mlpfwd(net_100_1000,training.data(:,1001:60000)');
[C,I] = max(y,[],2);
ftans_100_1000=I-1;
clear y
y=mlpfwd(net_100_100,training.data(:,101:60000)');
[C,I] = max(y,[],2);
ftans_100_100=I-1;
clear y
%%
clear y
y=mlpfwd(net_500_60000,training.data(:,1:60000)');
[C,I] = max(y,[],2);
ftans_500_60000=I-1;
clear y
y=mlpfwd(net_500_10000,training.data(:,10001:60000)');
[C,I] = max(y,[],2);
ftans_500_10000=I-1;
clear y
y=mlpfwd(net_500_1000,training.data(:,1001:60000)');
[C,I] = max(y,[],2);
ftans_500_1000=I-1;
clear y
y=mlpfwd(net_500_100,training.data(:,101:60000)');
[C,I] = max(y,[],2);
ftans_500_100=I-1;
clear y
%%
clear y
y=mlpfwd(net_1000_60000,training.data(:,1:60000)');
[C,I] = max(y,[],2);
ftans_1000_60000=I-1;
clear y
y=mlpfwd(net_1000_10000,training.data(:,10001:60000)');
[C,I] = max(y,[],2);
ftans_1000_10000=I-1;
clear y
y=mlpfwd(net_1000_1000,training.data(:,1001:60000)');
[C,I] = max(y,[],2);
ftans_1000_1000=I-1;
clear y
y=mlpfwd(net_1000_100,training.data(:,101:60000)');
[C,I] = max(y,[],2);
ftans_1000_100=I-1;
clear y
ft={ftans_500_60000, ftans_500_10000, ftans_500_1000, ftans_500_100, ftans_100_60000, ftans_100_10000, ftans_100_1000, ftans_100_100, ftans_1000_60000, ftans_1000_10000, ftans_1000_1000, ftans_1000_100};
Y8=sum((ftans_100_100==training.labels(101:60000,1)))/length(ftans_100_100);
Y7=sum((ftans_100_1000==training.labels(1001:60000,1)))/length(ftans_100_1000);
Y6=sum((ftans_100_10000==training.labels(10001:60000,1)))/length(ftans_100_10000);
Y5=sum((ftans_100_60000==training.labels(1:60000,1)))/length(ftans_100_60000);
Y4=sum((ftans_500_100==training.labels(101:60000,1)))/length(ftans_500_100);
Y3=sum((ftans_500_1000==training.labels(1001:60000,1)))/length(ftans_500_1000);
Y2=sum((ftans_500_10000==training.labels(10001:60000,1)))/length(ftans_500_10000);
Y1=sum((ftans_500_60000==training.labels(1:60000,1)))/length(ftans_500_60000);
Y12=sum((ftans_1000_100==training.labels(101:60000,1)))/length(ftans_1000_100);
Y11=sum((ftans_1000_1000==training.labels(1001:60000,1)))/length(ftans_1000_1000);
Y10=sum((ftans_1000_10000==training.labels(10001:60000,1)))/length(ftans_1000_10000);
Y9=sum((ftans_1000_60000==training.labels(1:60000,1)))/length(ftans_1000_60000);
yfinal=sum(Y)/60000;
accuracy.training=yfinal2';