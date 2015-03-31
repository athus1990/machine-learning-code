function [ooup,v] =valuate(W1,W2,x,fn)
h1=W1(2,1)*x(1)+W1(3,1)*x(2)+W1(1,1);
h2=W1(2,2)*x(1)+W1(3,2)*x(2)+W1(1,2);
y1=fn(h1);
y2=fn(h2);
Y=y1*W2(2)+y2*W2(3)+W2(1);
if(Y>=0)
    ooup=1;
    v=Y;
else
    ooup=0;
    v=Y;
end
end