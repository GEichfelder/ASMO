function [adapt,alpha,beta,epsilon,b,r,a_start,a_lim] = ps_adapt_param_1(~)
%PS_ADAPT_PARAM_1 Some default parameters for ps_adapt to load
%   A demonstartion of how a parameter file could look like

% Should Pascoletti Serafini use adapted mode?
adapt = 1;

% Parameter for Pascoletti Serafini
alpha=0.10;
beta=1;
epsilon=0.05;
b=[1;1];
r=[1;1];

% Optional parameter for range of a
a_start = [];
a_lim = [];
end

