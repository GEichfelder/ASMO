function [adapt,alpha,beta,epsilon,b,r,a_start,a_lim] = ps_param_auto(problem)
%PS_PARAM_AUTO Some autocomputed parameters to load
%   This file will compute some parameters based on the problems dimensions
%   and can be manipulated to use either adaptive (m = 2 only) or
%   non-adaptive Pascoletti Serafini scalarization.

% Should Pascoletti Serafini use adapted mode? (1 == yes, 0 == no)
adapt = 0;

% What is the dimension of our problem?
[~,m] = problem();

% Parameter for Pascoletti Serafini
alpha=0.10; % This will be ignored if adapt==0
beta=1;
epsilon=0.1;
b = ones(m,1);
r = ones(m,1);

% Optional parameter for range of a
a_start = [];
a_lim = [];
end

