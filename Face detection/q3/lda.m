j=1;
for i=1:15
mul(:, i)=mean(X1(:, j:j+8), 2);
j=j+8+1;
end
mul2=mean(mul, 2);
j=1;
V=zeros(9,9);
for i=1:15
L=bsxfun(@minus, X1(:, j:j+8), mul(:, i));
si =L'*L;
si1=mean(si, 2);
V=V+si;
K(:,i) =si1;
j=j+8+1;
end
Sw=si'*si;
nn=bsxfun(@minus,mul, mul2);
Sb=nn'*nn;
% I=inv(Sw);