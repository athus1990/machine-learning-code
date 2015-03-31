%%
clc
clear all
clc
RAND=randn(3,20);
mean1=[0;0;0];
sd1=[sqrt(3);sqrt(5);sqrt(2)];
A=bsxfun(@plus,mean1,bsxfun(@times,sd1,RAND));
RAND=randn(3,20);
mean2=[1;5;-3];
sd2=[sqrt(1);sqrt(4);sqrt(6)];
B=bsxfun(@plus,mean2,bsxfun(@times,sd2,RAND));
RAND=randn(3,20);
mean3=[0;0;0];
sd3=[sqrt(10);sqrt(10);sqrt(10)];
C=bsxfun(@plus,mean3,bsxfun(@times,sd3,RAND));
A1=A';
B1=B';
C1=C';
scatter3(A1(:,1),A1(:,2),A1(:,3),'green','green')
hold on
scatter3(B1(:,1),B1(:,2),B1(:,3),'blue','blue')
scatter3(C1(:,1),C1(:,2),C1(:,3),'red','red')
hold off
mean1new=sum (A,2)/20;
mean2new=sum (B,2)/20;
mean3new=sum (C,2)/20;
%%
X=A(1,:)-mean1new(1);
Y=A(2,:)-mean1new(2);
Z=A(3,:)-mean1new(3);
COV1=[X*X',X*Y',X*Z';Y*X',Y*Y',Y*Z';Z*X',Z*Y',Z*Z'];
COV1=COV1/19;
X=B(1,:)-mean2new(1);
Y=B(2,:)-mean2new(2);
Z=B(3,:)-mean2new(3);
COV2=[X*X',X*Y',X*Z';Y*X',Y*Y',Y*Z';Z*X',Z*Y',Z*Z'];
COV2=COV2/19;
X=C(1,:)-mean3new(1);
Y=C(2,:)-mean3new(2);
Z=C(3,:)-mean3new(3);
COV3=[X*X',X*Y',X*Z';Y*X',Y*Y',Y*Z';Z*X',Z*Y',Z*Z'];
COV3=COV3/19;
%%

x1=[0,0,0];

p11=exp(-0.5*(x1'-mean1new)'*inv(COV1)*(x1'-mean1new))/((2*pi)^1.5*sqrt(det(COV1)));
p12=exp(-0.5*(x1'-mean2new)'*inv(COV2)*(x1'-mean2new))/((2*pi)^1.5*sqrt(det(COV2)));
p13=exp(-0.5*(x1'-mean3new)'*inv(COV3)*(x1'-mean3new))/((2*pi)^1.5*sqrt(det(COV3)));
P=[p11,p12,p13];
if max(P)==p11
    class(1,:)='class 1';
elseif max(P)==p12
    class(1,:)='class 2';
else 
    class(1,:)='class 3';
end

%%
x2=[1,6,-3];
p11=exp(-0.5*(x2'-mean1new)'*inv(COV1)*(x2'-mean1new))/((2*pi)^1.5*sqrt(det(COV1)));
p12=exp(-0.5*(x2'-mean2new)'*inv(COV2)*(x2'-mean2new))/((2*pi)^1.5*sqrt(det(COV2)));
p13=exp(-0.5*(x2'-mean3new)'*inv(COV3)*(x2'-mean3new))/((2*pi)^1.5*sqrt(det(COV3)));
P=[p11,p12,p13];
if max(P)==p11
    class(2,:)='class 1';
elseif max(P)==p12
    class(2,:)='class 2';
else 
    class(2,:)='class 3';
end
%%
x3=[0.8,3.0,-1.5];
p11=exp(-0.5*(x2'-mean1new)'*inv(COV1)*(x3'-mean1new))/((2*pi)^1.5*sqrt(det(COV1)));
p12=exp(-0.5*(x3'-mean2new)'*inv(COV2)*(x3'-mean2new))/((2*pi)^1.5*sqrt(det(COV2)));
p13=exp(-0.5*(x3'-mean3new)'*inv(COV3)*(x2'-mean3new))/((2*pi)^1.5*sqrt(det(COV3)));
P=[p11,p12,p13];
if max(P)==p11
    class(3,:)='class 1';
elseif max(P)==p12
    class(3,:)='class 2';
else 
    class(3,:)='class 3';
end
%%
x4=[8,-8,8];
p11=exp(-0.5*(x4'-mean1new)'*inv(COV1)*(x4'-mean1new))/((2*pi)^1.5*sqrt(det(COV1)));
p12=exp(-0.5*(x4'-mean2new)'*inv(COV2)*(x4'-mean2new))/((2*pi)^1.5*sqrt(det(COV2)));
p13=exp(-0.5*(x4'-mean3new)'*inv(COV3)*(x4'-mean3new))/((2*pi)^1.5*sqrt(det(COV3)));
P=[p11,p12,p13];
if max(P)==p11
    class(4,:)='class 1';
elseif max(P)==p12
    class(4,:)='class 2';
else 
    class(4,:)='class 3';
end
%%
x5=[-1,1,-1];
p11=exp(-0.5*(x5'-mean1new)'*inv(COV1)*(x5'-mean1new))/((2*pi)^1.5*sqrt(det(COV1)));
p12=exp(-0.5*(x5'-mean2new)'*inv(COV2)*(x5'-mean2new))/((2*pi)^1.5*sqrt(det(COV2)));
p13=exp(-0.5*(x5'-mean3new)'*inv(COV3)*(x5'-mean3new))/((2*pi)^1.5*sqrt(det(COV3)));
P=[p11,p12,p13];
if max(P)==p11
    class(5,:)='class 1';
elseif max(P)==p12
    class(5,:)='class 2';
else 
    class(5,:)='class 3';
end
%%
x6=[0,5,0];
p11=exp(-0.5*(x6'-mean1new)'*inv(COV1)*(x6'-mean1new))/((2*pi)^1.5*sqrt(det(COV1)));
p12=exp(-0.5*(x6'-mean2new)'*inv(COV2)*(x6'-mean2new))/((2*pi)^1.5*sqrt(det(COV2)));
p13=exp(-0.5*(x6'-mean3new)'*inv(COV3)*(x6'-mean3new))/((2*pi)^1.5*sqrt(det(COV3)));
P=[p11,p12,p13];
if max(P)==p11
    class(1,:)='class 1';
elseif max(P)==p12
    class(6,:)='class 2';
else 
    class(6,:)='class 3';
end
class
%%
%%
%%
%%

x1=[0,0,0];

p11=exp(-0.5*(x1'-mean1new)'*inv(COV1)*(x1'-mean1new))/((2*pi)^1.5*sqrt(det(COV1)));
p12=exp(-0.5*(x1'-mean2new)'*inv(COV2)*(x1'-mean2new))/((2*pi)^1.5*sqrt(det(COV2)));
p13=3*exp(-0.5*(x1'-mean3new)'*inv(COV3)*(x1'-mean3new))/((2*pi)^1.5*sqrt(det(COV3)));
P=[p11,p12,p13];
if max(P)==p11
    class(1,:)='class 1';
elseif max(P)==p12
    class(1,:)='class 2';
else 
    class(1,:)='class 3';
end

%%
x2=[1,6,-3];
p11=exp(-0.5*(x2'-mean1new)'*inv(COV1)*(x2'-mean1new))/((2*pi)^1.5*sqrt(det(COV1)));
p12=exp(-0.5*(x2'-mean2new)'*inv(COV2)*(x2'-mean2new))/((2*pi)^1.5*sqrt(det(COV2)));
p13=3*exp(-0.5*(x2'-mean3new)'*inv(COV3)*(x2'-mean3new))/((2*pi)^1.5*sqrt(det(COV3)));
P=[p11,p12,p13];
if max(P)==p11
    class(2,:)='class 1';
elseif max(P)==p12
    class(2,:)='class 2';
else 
    class(2,:)='class 3';
end
%%
x3=[0.8,3.0,-1.5];
p11=exp(-0.5*(x2'-mean1new)'*inv(COV1)*(x3'-mean1new))/((2*pi)^1.5*sqrt(det(COV1)));
p12=exp(-0.5*(x3'-mean2new)'*inv(COV2)*(x3'-mean2new))/((2*pi)^1.5*sqrt(det(COV2)));
p13=3*exp(-0.5*(x3'-mean3new)'*inv(COV3)*(x2'-mean3new))/((2*pi)^1.5*sqrt(det(COV3)));
P=[p11,p12,p13];
if max(P)==p11
    class(3,:)='class 1';
elseif max(P)==p12
    class(3,:)='class 2';
else 
    class(3,:)='class 3';
end
%%
x4=[8,-8,8];
p11=exp(-0.5*(x4'-mean1new)'*inv(COV1)*(x4'-mean1new))/((2*pi)^1.5*sqrt(det(COV1)));
p12=exp(-0.5*(x4'-mean2new)'*inv(COV2)*(x4'-mean2new))/((2*pi)^1.5*sqrt(det(COV2)));
p13=3*exp(-0.5*(x4'-mean3new)'*inv(COV3)*(x4'-mean3new))/((2*pi)^1.5*sqrt(det(COV3)));
P=[p11,p12,p13];
if max(P)==p11
    class(4,:)='class 1';
elseif max(P)==p12
    class(4,:)='class 2';
else 
    class(4,:)='class 3';
end
%%
x5=[-1,1,-1];
p11=exp(-0.5*(x5'-mean1new)'*inv(COV1)*(x5'-mean1new))/((2*pi)^1.5*sqrt(det(COV1)));
p12=exp(-0.5*(x5'-mean2new)'*inv(COV2)*(x5'-mean2new))/((2*pi)^1.5*sqrt(det(COV2)));
p13=3*exp(-0.5*(x5'-mean3new)'*inv(COV3)*(x5'-mean3new))/((2*pi)^1.5*sqrt(det(COV3)));
P=[p11,p12,p13];
if max(P)==p11
    class(5,:)='class 1';
elseif max(P)==p12
    class(5,:)='class 2';
else 
    class(5,:)='class 3';
end
%%
x6=[0,5,0];
p11=exp(-0.5*(x6'-mean1new)'*inv(COV1)*(x6'-mean1new))/((2*pi)^1.5*sqrt(det(COV1)));
p12=exp(-0.5*(x6'-mean2new)'*inv(COV2)*(x6'-mean2new))/((2*pi)^1.5*sqrt(det(COV2)));
p13=3*exp(-0.5*(x6'-mean3new)'*inv(COV3)*(x6'-mean3new))/((2*pi)^1.5*sqrt(det(COV3)));
P=[p11,p12,p13];
if max(P)==p11
    class(1,:)='class 1';
elseif max(P)==p12
    class(6,:)='class 2';
else 
    class(6,:)='class 3';
end
class