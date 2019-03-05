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

function [xres,fres,k] = ps_general(problem,beta,epsilon,b,r)
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

% Initialize internal parameters and output
steps = floor(1/epsilon)+1;
xres = zeros(n,steps^(m-1));
fres = zeros(m,steps^(m-1));

% Compute the cuboid H^0 to embed H
% Start with the computation of a basis V
V = null(b');
p = zeros(m,1);
if beta > 0 || beta < 0
    p = (b')\beta;
end
% Initalize the boundaries
s_min = zeros(m-1,1);
s_max = zeros(m-1,1);
% New constraints
if ~isempty(Aineq)
    l = size(Aineq,1);
    Aineq = [Aineq,zeros(l,m)];
end
if ~isempty(Aeq)
    l = size(Aeq,1);
    Aeq = [Aeq,zeros(l,m)];
end
if ~isempty(lb)
    lb = [lb;-(Inf(m,1))];
end
if ~isempty(ub)
    ub = [ub;Inf(m,1)];
end
x0 = [x0;zeros(m,1)];
function [cuboid_c,cuboid_ceq] = cuboid_nonlcon(x)
    x_part = x(1:n);
    [cuboid_c,ceq] = nonlcon(x_part);
    ceq_new = -V*x((n+2):end)-x(n+1).*r+fun(x_part); %maybe -p?
    cuboid_ceq = [ceq;ceq_new];
end
% Computation of vertices
for i=1:(m-1)
    [~,s_min(i)] = fmincon(@(x) x(n+1+i),x0,Aineq,bineq,Aeq,beq,lb,ub,@(x) cuboid_nonlcon(x),options);
    [~,ftmp] = fmincon(@(x) -x(n+1+i),x0,Aineq,bineq,Aeq,beq,lb,ub,@(x) cuboid_nonlcon(x),options);
    s_max(i) = -ftmp;
end

% Set range for parameter a and initialize it
v = s_max-s_min;
s = s_min;

% Main part of scalarization
% (Re-)Load the function parameters
[~,~,~,x0,Aineq,bineq,Aeq,beq,lb,ub,nonlcon,~] = problem();
% New constraints
if ~isempty(Aineq)
    l = size(Aineq,1);
    Aineq = [Aineq,zeros(l,1)];
end
if ~isempty(Aeq)
    l = size(Aeq,1);
    Aeq = [Aeq,zeros(l,1)];
end
lb = [lb;-Inf];
ub = [ub;Inf];
function [ps_c,ps_ceq] = ps_nonlcon(x)
    x_part = x(1:n);
    [c,ps_ceq] = nonlcon(x_part);
    c_new = -V*s-x(n+1).*r+fun(x_part); %a = Vs; maybe -p?
    ps_c = [c;c_new];
end

% Optimization problem for scalarization
for k=0:(steps^(m-1)-1)
    for i=1:(m-1)
        s(i) = s_min(i)+mod(floor(k/(steps^(i-1))),steps)*epsilon*v(i);
    end
    [x] = fmincon(@(x) x(n+1),[x0;0],Aineq,bineq,Aeq,beq,lb,ub,@(x) ps_nonlcon(x),options);
    x_sol = x(1:n);
    xres(:,k+1) = x_sol;
    fres(:,k+1) = fun(x_sol);
end
k=k+1;
end

