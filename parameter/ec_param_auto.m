function [adapt,alpha,beta,epsilon,b,r] = ec_param_auto(problem)
%EC_PARAM_AUTO Autocomputes parameters for epsilon-constraint method
%   A demonstartion of how a parameter file could look like for the
%   ps_standard solver (in fact those parameters will transform it into
%   epsilon-constraint method). This parameter file uses the dimension
%   parameters of a given problem to compute the corresponding variables.

% Should Pascoletti Serafini use adaptive mode? (1 == yes, 0 == no)
adapt = 0;

% What is the dimension of our problem?
[~,m] = problem();

% Parameter for Pascoletti Serafini
alpha=0.10; % This will be ignored if adapt==0
beta=0;
epsilon=0.1;

% Move objectives 1 to m-1 into the (epsilon-)constraints and keep the m-th
% objective as objective function for the scalarization
b = zeros(m,1);
b(m) = 1;
r = b;
end

