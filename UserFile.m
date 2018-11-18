%% Some clean-up first
clear;
close all;
clc;

%% Please enter your parameters below
% Your Problem
problem = "problem_KimDeWeck";

% Choose a parameter file
parameter = "ps_param_auto";

% Should the result be plotted (m=2,3 only) [0==no,1==yes]
plot_result = 1;

%% Please don't touch anything below this line
% Call the solver
[xres,fres,k] = callSolver(problem,parameter,plot_result);