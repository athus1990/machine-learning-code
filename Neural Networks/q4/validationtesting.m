% for i=1:length(training.data)
% y(i,:)=mlpfwd(net_1000_60000,training.data(:,i)');
% end
% y=round(abs(y));
% test_1000_60000=binaryVectorToDecimal(y);
% clear y

for i=10001:60000
y(i-10000,:)=mlpfwd(net_1000_10000,training.data(:,i)');
end
y=round(abs(y));
test2_1000_10000=binaryVectorToDecimal(y);
clear y
for i=1001:60000
y(i-1000,:)=mlpfwd(net_1000_1000,training.data(:,i)');
end
y=round(abs(y));
test2_1000_1000=binaryVectorToDecimal(y);
clear y
for i=101:60000
y(i-100,:)=mlpfwd(net_1000_100,training.data(:,i)');
end
y=round(abs(y));
test2_1000_100=binaryVectorToDecimal(y);
clear y
%% 
Y_100_100=(test_100_100==training.labels);
Y_100_1000=(test_100_1000==training.labels);
Y_100_10000=(test_100_10000==training.labels);
Y_100_60000=(test_100_60000==training.labels);
Y_500_100=(test_500_100==training.labels);
Y_500_1000=(test_500_1000==training.labels);
Y_500_10000=(test_500_10000==training.labels);
Y_500_60000=(test_500_60000==training.labels);
Y_1000_100=(test_1000_100==training.labels);
Y_1000_1000=(test_1000_1000==training.labels);
Y_1000_10000=(test_1000_10000==training.labels);
Y_1000_60000=(test_1000_60000==training.labels);

%%
accur.training_100_100=sum(Y_100_100)/60000;
accur.training_100_1000=sum(Y_100_1000)/60000;
accur.training_100_10000=sum(Y_100_10000)/60000;
accur.training_100_60000=sum(Y_100_60000)/60000;
accur.training_500_60000=sum(Y_500_60000)/60000;
accur.training_500_10000=sum(Y_500_10000)/60000;
accur.training_500_1000=sum(Y_500_1000)/60000;
accur.training_500_100=sum(Y_500_100)/60000;
accur.training_1000_100=sum(Y_1000_100)/60000;
accur.training_1000_1000=sum(Y_1000_1000)/60000;
accur.training_1000_10000=sum(Y_1000_10000)/60000;
accur.training_1000_60000=sum(Y_1000_60000)/60000;