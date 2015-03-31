function [c, ceq] = confun(x)
% Nonlinear inequality constraints
c = [(2000/(pi*x(1)*x(2)))-(pi^2*900000*(x(1)^2+x(2)^2)/(8*275^2));     
     (2000/(pi*x(1)*x(2)))-550];
% Nonlinear equality constraints
ceq = [];
end