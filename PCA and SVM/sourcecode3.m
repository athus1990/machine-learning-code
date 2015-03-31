clc 
clear all
close all
x=[2, 2;2, -2;-2, -2;-2, 2];
y=[1, 1;1, -1; -1, -1;-1, 1];
X=[x;y];
% 3 a
scatter(x(:, 1), x(:, 2), 'b+')
hold on
scatter(y(:, 1), y(:, 2), 'ro')
hold off
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
figure
scatter(pi(:, 1), pi(:, 2), 'b+')
hold on
scatter(pi1(:, 1), pi1(:, 2), 'ro')
hold off
figure
scatter(pi(:, 1), pi(:, 2), 'b+')
hold on
scatter(pi1(:, 1), pi1(:, 2), 'ro')
X1=[pi;pi1];
Y=squareform(pdist(X1));
dist=Y(1:4,5:8);
[~,I]=min(min(dist));
[r,c]=find(dist(I)==dist);
vect=X1(r,:)-X1(c+4,:);
sl=((X1(c+4,2)-X1(r,2))/(X1(c+4,1)-X1(r,1)))*-1;
midpoint=(X1(r,:)+X1(c+4,:))/2;
f=@(x) -1*x+3;
%line([X1(1,1),X1(c+4,1)],[X1(1,1),X1(c+4,1)])
line([7 -2],[-4 5])
scatter([pi(1, 1) pi1(1, 1)], [pi(1, 2),pi1(1, 2)], 'ko')
hold on