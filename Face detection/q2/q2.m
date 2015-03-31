clc
clear all
load q2.mat
X1=X';
T=mean(X1,2);
A=bsxfun(@minus,X1,T);
C=(A'*A);
[evec,eval]=eig(C);
d1 = diag(eval);
v1=evec;
%% sort the eigen vectors and values
[sorted_eval, e_index] = sort(d1,'descend');
sorted_evec = zeros(4);
for i=1:4
    sorted_evec(:,i) = v1(:,e_index(i));
end
%% U is the eigenfaces
u=A*sorted_evec;
for i=1:4
u_norm(:,i)=u(:,i)/norm(u(:,i));
end
k=3;
u1=u_norm(:,1:k);
weights_needed=u1'*(X1(:,2)-T);%for second data sample

%% c
w1=u1'*(X1(:,1)-T);
w2=u1'*(X1(:,2)-T);
w3=u1'*(X1(:,3)-T);
w4=u1'*(X1(:,4)-T);
ohm1=[w1 w2 w3 w4];
newx1=T+u1*w1;
newx2=T+u1*w2;
newx3=T+u1*w3;
newx4=T+u1*w4;
newx=[newx1 newx2 newx3 newx4];
error=newx-X1;
error=error.^2;
mse=sum(error)/19;%mean square error

%% d
k=2;
u1=u_norm(:,1:k);
w11=u1'*(X1(:,1)-T);
w21=u1'*(X1(:,2)-T);
w31=u1'*(X1(:,3)-T);
w41=u1'*(X1(:,4)-T);
ohm2=[w11 w21 w31 w41];
newx11=T+u1*w11;
newx21=T+u1*w21;
newx31=T+u1*w31;
newx41=T+u1*w41;
newx_2=[newx11 newx21 newx31 newx41];
error=newx_2-X1;
error=error.^2;
mse2=sum(error)/19;
%% f
k=4;
u1=u_norm(:,1:k);
w111=u1'*(X1(:,1)-T);
w211=u1'*(X1(:,2)-T);
w311=u1'*(X1(:,3)-T);
w411=u1'*(X1(:,4)-T);
ohm2=[w111 w211 w311 w411];
newx111=T+u1*w111;
newx211=T+u1*w211;
newx311=T+u1*w311;
newx411=T+u1*w411;
newx_3=[newx111 newx211 newx311 newx411];
