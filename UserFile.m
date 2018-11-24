%% Some clean-up first
clear;
close all;
clc;

%% Please enter your parameters below
% Your Problem
problem = 'problem_KimDeWeck';

% Choose a parameter file
parameter = 'ps_param_auto';

% Should the result be plotted (m = 2 and m = 3 only) [1 == yes, 0 == no]
plot_result = 1;

%% Please don't touch anything below this line
% Call the solver
[xres,fres,k] = callSolver(problem,parameter,plot_result);