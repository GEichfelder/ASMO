function [adapt,alpha,beta,epsilon,b,r] = ps_param_01(~)
%PS_PARAM_01 Some default parameters for ps_standard to load
%   A demonstration of how a parameter file could look like. You can use
%   this together with problem_01 to see how the non-adaptive algorithm
%   works for m = 2.

% Should Pascoletti Serafini use adapted mode? (1 == yes, 0 == no)
adapt = 0;

% Parameter for Pascoletti Serafini
alpha=0.10; % This will be ignored if adapt==0
beta=1;
epsilon=0.05;
b=[1;1];
r=[1;1];
end

