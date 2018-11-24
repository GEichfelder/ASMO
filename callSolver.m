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
[adapt,alpha,beta,epsilon,b,r,a_start,a_lim] = parameter(problem);
[~,m] = problem();

% Call solver
if m > 1
    if m > 2
        [xres,fres,k] = ps_general(problem,beta,epsilon,b,r);
    elseif adapt > 0
        [xres,fres,k] = ps_adapt(problem,alpha,beta,epsilon,b,r,a_start,a_lim);
    else
        [xres,fres,k] = ps_standard(problem,beta,epsilon,b,r,a_start,a_lim);
    end
else
    error("This algorithm is made only for multiobjective optimization problems (m>=2).");
end

% Plot
if plot_result > 0
    if m < 3
        plot(fres(1,:),fres(2,:),'LineStyle','none','Marker','o','MarkerFaceColor','black');
        grid on;
        xlabel('f_1');
        ylabel('f_2');
        title('Approximation of pareto front');
    elseif m < 4
        plot3(fres(1,:),fres(2,:),fres(3,:),'LineStyle','none','Marker','o','MarkerFaceColor','black');
        grid on;
        xlabel('f_1');
        ylabel('f_2');
        zlabel('f_3');
        title('Approximation of pareto front');
    end
end
end

