%%MAKE SURE VALUATE FUNCTION("VALUATE.M" FILE) IS A PART OF THE FOLDER


clc
clear all
x2=-5:.2:5;
x2=repmat(x2,51,1);
B = x2(:);
x1=-5:0.2:5;
x1=x1';
x1=repmat(x1,size(x1),1);
f=B;
f(1:end,2)=x1;
f2=f;
a=1.716;
b=2/3;
fn=@(z) a*tanh(b*z);
W1=[.5,-.5;.3,-.4;-.1,1];
W2=[1;-2;.5];
for i=1:length(f)
    lm=f(i,1:2);
    [f(i,3),f(i,4)]=valuate(W1,W2,lm,fn);
end
cc=2.2;
dd=-3.2;
d1=f(1846,4);%ans for d
d2=f(496,4);%ans for d
pos=f(f(:,3)==1,1:2);
neg=f(f(:,3)==0,1:2);
scatter(pos(:,1),pos(:,2),16,[0 1 0],'x')
hold on
scatter(neg(:,1),neg(:,2),16,[1 0 0],'o')
hold off

%%
figure
W1=[-1.0,1.0;-0.5,1.5;1.5,-0.5];
W2=[0.5;-1;1];
for i=1:length(f2)
    lm2=f2(i,1:2);
    [f2(i,3),f2(i,4)]=valuate(W1,W2,lm2,fn);
end
d12=f2(1846,4);
d22=f2(496,4);
pos=f2(f2(:,3)==1,1:2);
neg=f2(f2(:,3)==0,1:2);
scatter(pos(:,1),pos(:,2),16,[0 1 0],'x')
hold on
scatter(neg(:,1),neg(:,2),16,[1 0 0],'o')
hold off