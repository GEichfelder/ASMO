% Copyright (C) 2019 Leo Warnow

% This program is free software: you can redistribute it and/or modify
% it under the terms of the GNU Lesser General Public License as published
% by the Free Software Foundation, either version 3 of the License, or
% (at your option) any later version.

% This program is distributed in the hope that it will be useful,
% but WITHOUT ANY WARRANTY; without even the implied warranty of
% MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
% GNU Lesser General Public License for more details.

% You should have received a copy of the GNU Lesser General Public License
% along with these files.  If not, see https://www.gnu.org/licenses/.

function [xres,fres,k] = ps_standard(problem,beta,epsilon,b,r)
%PS_ADAPT (Non-adaptive) Pascoletti Serafini Method for m=2
%   Computes optimal solutions of a given function f by using the
%   Pascoletti Serafini Scalarization Method

% Load the function parameters
[n,m,fun,x0,Aineq,bineq,Aeq,beq,lb,ub,nonlcon,options] = problem();

% Check for solver options
if isempty(options)
    % If there are no options set, at least fall back to these here
	options = optimset('Display','none','Algorithm','interior-point'); 
end

%Initialize internal parameters and output
steps = floor(1/epsilon);
xres = zeros(n,m+steps-1);
fres = zeros(m,m+steps-1);

% Autocompute parameter a
E = eye(m,m);
a = zeros(m,m);
for i=1:m
    [xtmp,~] = fmincon(@(x) E(i,:)*fun(x),x0,Aineq,bineq,Aeq,beq,lb,ub,nonlcon,options);
    ftmp = fun(xtmp);
    a(:,i) = ftmp-((b'*ftmp-beta)/(b'*r)).*r;
    fres(:,i) = ftmp;
    xres(:,i) = xtmp;
end
a_lim = a(:,2);
a_start = a(:,1);

% Set range for parameter a and initialize it
v = a_lim-a_start;
a = a_start;

% Main part of scalarization
% New constraints
if ~isempty(Aineq)
    l = size(Aineq,1);
    Aineq = [Aineq,zeros(l,1)];
end
if ~isempty(Aeq)
    l = size(Aeq,1);
    Aeq = [Aeq,zeros(l,1)];
end
if ~isempty(lb)
    lb = [lb;-Inf];
end
if ~isempty(ub)
    ub = [ub;Inf];
end
function [ps_c,ps_ceq] = ps_nonlcon(x)
    x_part = x(1:n);
    [c,ps_ceq] = nonlcon(x_part);
    c_new = -a-x(n+1).*r+fun(x_part);
    ps_c = [c;c_new];
end

% Optimization problem for scalarization
for k=2:steps
    a = a+epsilon.*v;
    [x] = fmincon(@(x) x(n+1),[x0;0],Aineq,bineq,Aeq,beq,lb,ub,@(x) ps_nonlcon(x),options);
    x_sol = x(1:n);
    xres(:,m+k-1) = x_sol;
    fres(:,m+k-1) = fun(x_sol);
end
k=k+1;
end

