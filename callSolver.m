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

function [xres,fres,k] = callSolver(problem_name,parameter_name,plot_result)
%CALLSOLVER is used as an interface between user and actual solver
%   This function loads all needed files and calls the solver afterwards

% Load paths
addpath(genpath('parameter'));
addpath(genpath('problems'));
addpath(genpath('solver'));

% Load functions from their names
problem = str2func(problem_name);
parameter = str2func(parameter_name);

% Load parameters
[adapt,alpha,beta,epsilon,b,r] = parameter(problem);
[~,m] = problem();

% Call solver
if m > 1
    if m > 2
        [xres,fres,k] = ps_general(problem,beta,epsilon,b,r);
    elseif adapt > 0
        [xres,fres,k] = ps_adapt(problem,alpha,beta,epsilon,b,r);
    else
        [xres,fres,k] = ps_standard(problem,beta,epsilon,b,r);
    end
else
    error('This algorithm is made only for multiobjective optimization problems (m>=2).');
end

% Plot
if plot_result > 0
    if m < 3
        plot(fres(1,:),fres(2,:),'LineStyle','none','Marker','o','MarkerFaceColor','black');
        grid on;
        xlabel('f_1');
        ylabel('f_2');
        title('Representation of the set \{f(x) | x \in S efficient\}');
    elseif m < 4
        plot3(fres(1,:),fres(2,:),fres(3,:),'LineStyle','none','Marker','o','MarkerFaceColor','black');
        grid on;
        xlabel('f_1');
        ylabel('f_2');
        zlabel('f_3');
        title('Representation of the set \{f(x) | x \in S efficient\}');
    end
end
end

