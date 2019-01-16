function [adapt,alpha,beta,epsilon,b,r] = ps_param_02(~)
%PS_PARAM_02 Parameters for problem_02 by Eichfelder
%   This parameter file realizes the parameters for the hyperplane given by
%   Eichfelder for probem_02. The example was taken from:
%   G. Eichfelder, Adaptive scalarization methods in multiobjective
%   optimization, Springer, 2008.

% Should Pascoletti Serafini use adaptive mode? (1 == yes, 0 == no)
adapt = 1;

% Parameter for Pascoletti Serafini
alpha=0.20; % This will be ignored if adapt==0
beta=2.5;
epsilon=0.1;
b=[1;1];
r=[1;0];
end