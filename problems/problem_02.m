function [n,m,fun,x0,Aineq,bineq,Aeq,beq,lb,ub,nonlcon,options] = problem_02()
%PROBLEM_02 A test instance for m = 2 by Eichfelder
%   This problem can be used to demonstrate how choosing the adaptive or
%   non-adaptive method will lead to different results.
%   This example was taken from:
%   G. Eichfelder, Adaptive scalarization methods in multiobjective
%   optimization, Springer, 2008.

%Dimension of domain and image space
n = 2;
m = 2;

% Objective function
fun = @(x) [sqrt(1+x(1)^2);x(1)^2-4*x(1)+x(2)+5];

% Starting point for optimizer
x0 = zeros(n,1);

% Linear constraints (Aineq*x <= bineq, Aeq*x = beq)
Aineq = [];
bineq = [];
Aeq = [];
beq = [];

% Lower and upper bounds (lb <= x <= ub)
lb = zeros(n,1);
ub = [];

% Non-linear constraints (c(x) <= 0, ceq(x) = 0)
function [c,ceq] = nonlcon_fun(x)
    c = [x(1)^2-4*x(1)+x(2)+5-3.5];
    ceq = [];
end
nonlcon = @nonlcon_fun;

% Options for solver
options = [];

end

