function [adapt,alpha,beta,epsilon,b,r] = ps_adapt_param_01(~)
%PS_ADAPT_PARAM_01 Some default parameters for ps_adapt to load
%   A demonstration of how a parameter file could look like. You can use
%   this together with problem_01 to see how the adaptive algorithm
%   works for m = 2.

% Should Pascoletti Serafini use adaptive mode? (1 == yes, 0 == no)
adapt = 1;

% Parameter for Pascoletti Serafini
alpha=0.10;
beta=1;
epsilon=0.05;
b=[1;1];
r=[1;1];
end

