%UserFile provides an interface to the included solvers
% Start by running this file or adjust the specified problem and parameter
% file names to use the solvers for other problems

%% Copyright (C) 2019 Leo Warnow

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