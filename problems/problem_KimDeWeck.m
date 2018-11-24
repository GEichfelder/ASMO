function [n,m,fun,x0,Aineq,bineq,Aeq,beq,lb,ub,nonlcon,options] = problem_KimDeWeck()
%PROBLEM_KIMDEWECK A test instance with m = 3 by Kim and de Weck
%   This is a test problem to demonstrate how this algorithm performs in
%   higher dimensions (m > 2). This example was taken from:
%   I. Y. Kim and O. de Weck, Adaptive weighted sum method for
%   multiobjective optimization: a new method for pareto front generation,
%   Structural and Multidisciplinary Optimization, 31:105-116, 2006.

%Dimension of domain and image space
n = 3;
m = 3;

% Objective function
fun = @(x) [-x(1);-x(2);-x(3)];

% Starting point for optimizer
x0 = zeros(n,1);

% Linear constraints (Aineq*x <= bineq, Aeq*x = beq)
Aineq = [];
bineq = [];
Aeq = [];
beq = [];

% Lower and upper bounds
lb = zeros(n,1);
ub = Inf(n,1);

% Non-linear constraints
function [c,ceq] = nonlcon_fun(x)
    c = x(1)^4+2*x(2)^3+5*x(3)^2-1;
    ceq = [];
end
nonlcon = @nonlcon_fun;

% Options for solver
options = [];

end

