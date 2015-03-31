%% 3 (c)
A=[-1 0;1 0;0 -1;0 1];
B=[-1;10;-0.1;1];
x0=[0.1,0.1];
options = optimoptions(@fmincon,'Algorithm','active-set');
[x,fval] = fmincon(@objecfun,x0,A,B,[],[],[],[],@confun,options);

%% 3 (d)
options = optimoptions(@fmincon,'Algorithm','sqp');
[x2,fval2] = fmincon(@objecfun,x0,A,B,[],[],[],[],@confun,options);
x,fval
x2,fval2

%% 3 (e)
x0=[5,0.9];
options = optimoptions(@fmincon,'Algorithm','active-set');
[x3,fval3] = fmincon(@objecfun,x0,A,B,[],[],[],[],@confun,options);
options = optimoptions(@fmincon,'Algorithm','sqp');
[x4,fval4] = fmincon(@objecfun,x0,A,B,[],[],[],[],@confun,options);
x,fval
x2,fval2
x3,fval3
x4,fval4