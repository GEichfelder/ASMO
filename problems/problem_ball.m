function [n,m,fun,x0,Aineq,bineq,Aeq,beq,lb,ub,nonlcon,options] = problem_ball()
%PROBLEM_BALL A test instance with m=3 for our solver
%   Try to compute the pareto front of an euclidean ball with its center at
%   [0;0;0] and radius 1.

%Dimension of domain and image space
n = 3;
m = 3;

% Objective function
fun = @(x) [x(1);x(2);x(3)];

% Starting point for optimizer
x0 = zeros(n,1);

% Linear constraints (Aineq*x <= bineq, Aeq*x = beq)
Aineq = [];
bineq = [];
Aeq = [];
beq = [];

% Lower and upper bounds
lb = ones(n,1).*(-2);
ub = ones(n,1).*2;

% Non-linear constraints
function [c,ceq] = nonlcon_fun(x)
    c = (x(1)^2+x(2)^2+x(3)^2)-1;
    ceq = [];
end
nonlcon = @nonlcon_fun;

% Options for solver
options = [];

end

