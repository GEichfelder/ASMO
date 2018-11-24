function [n,m,fun,x0,Aineq,bineq,Aeq,beq,lb,ub,nonlcon,options] = problem_A24()
%PROBLEM_A24 A test instance for our solver
%   Based on excercise 24 of VOP1

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

% Lower and upper bounds
lb = ones(n,1).*(-4);
ub = ones(n,1).*4;

% Non-linear constraints
function [c,ceq] = nonlcon_fun(~)
    c = [];
    ceq = [];
end
nonlcon = @nonlcon_fun;

% Options for solver
options = [];

end

