function [n,m,fun,x0,Aineq,bineq,Aeq,beq,lb,ub,nonlcon,options] = problem_01()
%PROBLEM_01 A test instance for m = 2
%   This example can be used tu see how both the adaptive and non-adaptive
%   algorithm work. Therefor you could choose one of the corresponding
%   parameter files ps_adapt_param_01 (adaptive) or ps_param_01
%   (non-adaptive).

%Dimension of domain and image space
n = 40;
m = 2;

% Objective function
fun = @(x) [1-exp(-sum((x-(1/sqrt(n))).^2));1-exp(-sum((x+(1/sqrt(n))).^2))];

% Starting point for optimizer
x0 = zeros(n,1);

% Linear constraints (Aineq*x <= bineq, Aeq*x = beq)
Aineq = [];
bineq = [];
Aeq = [];
beq = [];

% Lower and upper bounds (lb <= x <= ub)
lb = ones(n,1).*(-4);
ub = ones(n,1).*4;

% Non-linear constraints (c(x) <= 0, ceq(x) = 0)
function [c,ceq] = nonlcon_fun(~)
    c = [];
    ceq = [];
end
nonlcon = @nonlcon_fun;

% Options for solver
options = [];

end

