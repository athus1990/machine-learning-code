clc
clear all
load q3.mat

%% Find the eigenvalues and eigen vectors
for i=1:length(trainimages)
    X1(:,i)=X(:,trainimages(i));
end
T=mean(X1,2);
A=bsxfun(@minus,X1,T);
%C=cov(X1);
C=(A'*A);
[evec,eval]=eig(C);
d1 = diag(eval);
v1=evec;
%% sort the eigen vectors and values
[sorted_eval, e_index] = sort(d1,'descend');
sorted_evec = zeros(135);
for i=1:135
    sorted_evec(:,i) = v1(:,e_index(i));
end
%% U is the eigenfaces
u=A*sorted_evec;
for i=1:135
u_norm(:,i)=u(:,i)/norm(u(:,i));
end
%% percent has the total percentages given by the eigenvalues
for i=1:length(sorted_eval)
percent(i)=(sum(sorted_eval(1:i,1))/sum(sorted_eval))*100;
end
%% n_eigenfaces has the no.of eigenfaces needed for 90%
n_eigenfaces=min(find(percent(1,:)>90));

%% percent_each has the each percentages given by the eigenvalues
for i=1:length(sorted_eval)
percent_each(i)=((sorted_eval(i))/sum(sorted_eval))*100;
end
bar(1:n_eigenfaces+10,percent_each(1,1:n_eigenfaces+10))
figure
bar(1:5,percent_each(1,1:5))
%% 3a
% figure
% subplot(1,5,1);
% imshow(reshape(u_norm(:,1)*255,231,195))
% subplot(1,5,2);
% imshow(reshape(u_norm(:,2)*255,231,195))
% subplot(1,5,3);
% imshow(reshape(u_norm(:,3)*255,231,195))
% subplot(1,5,4);
% imshow(reshape(u_norm(:,4)*255,231,195))
% subplot(1,5,5);
% imshow(reshape(u_norm(:,5)*255,231,195))

%% 3a

figure
subplot(1,5,1);
imagesc(reshape(u_norm(:,1),231,195))
colormap(gray)
subplot(1,5,2);
imagesc(reshape(u_norm(:,2),231,195))
colormap(gray)
subplot(1,5,3);
imagesc(reshape(u_norm(:,3),231,195) )
colormap(gray)
subplot(1,5,4);
imagesc(reshape(u_norm(:,4),231,195) )
colormap(gray)
subplot(1,5,5);
imagesc(reshape(u_norm(:,5),231,195) )
colormap(gray)
%% 3b
figure
times=10:10:50;
for k=1:5
u1=u_norm(:,1:times(k));
dum1=u1'*(X1(:,1)-T);
newx=T+u1*dum1;
subplot(1,5,k)
imshow(reshape(newx(:,1),231,195))
end
%% 3c

for i=1:length(trainimages)
Y_label(i)=Y(trainimages(i),1);
end
for i=1:length(testimages)
Y_label_test(i)=Y(testimages(i),1);
end
Y_label=Y_label';
Y_label_test=Y_label_test';


u_norm_best=u_norm(:,1:n_eigenfaces);
phi=u_norm_best'*A;
 for i=1:length(testimages)
   f_test(:,i)=X(:,testimages(i));
 end
A_test=bsxfun(@minus,f_test,T);
phi_test=u_norm_best'*A_test;
for i=1:30
  dok=bsxfun(@minus,phi,phi_test(:,i));
  norms = sqrt(sum(dok.^2,1));
%   ll=sum(dok);
%   ll=ll.^(0.5);
  [Cval,I]=min(norms); 
  final(i)=I;
end
final=final';
for i=1:length(final)
VVV(i)=Y_label(final(i),1);
end
VVV=VVV';
XXX=(VVV==Y_label_test);
sum(XXX)/30
%% 3 d
clear VVV XXX final Y_label Y_label_test f_test dok norms I 
for i=1:length(trainimages)
Y_label(i)=Y(trainimages(i),1);
end
for i=1:length(testimages)
Y_label_test(i)=Y(testimages(i),1);
end
Y_label=Y_label';
Y_label_test=Y_label_test';


u_norm_best=u_norm(:,:);
phi=u_norm_best'*A;
 for i=1:length(testimages)
   f_test(:,i)=X(:,testimages(i));
 end
A_test=bsxfun(@minus,f_test,T);
phi_test=u_norm_best'*A_test;
for i=1:30
  dok=bsxfun(@minus,phi,phi_test(:,i));
  norms = sqrt(sum(dok.^2,1));
%   ll=sum(dok);
%   ll=ll.^(0.5);
  [Cval,I]=min(norms); 
  final(i)=I;
end
final=final';
for i=1:length(final)
VVV(i)=Y_label(final(i),1);
end
VVV=VVV';
XXX=(VVV==Y_label_test);
sum(XXX)/30