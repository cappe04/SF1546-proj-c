function [] = CD()

clear; format long;
vars = get_vars(ones(1, 8));

h = 0.0001;

function dist = f(t)
    [u, p_crit, ~, ~, ~] = step_solve(vars, [0, 10*cos(t), vars.y_start, 10*sin(t)], h);
    dist = vars.x_end - p_crit(end, 1);
end

[angle, ~] = secant(@f, -1, -0.9, 1e-8, 500);

[u, p_crit, net_dist, E, t] = step_solve(vars, [0, 10*cos(angle), vars.y_start, 10*sin(angle)], h);
plot_solution(u, p_crit, net_dist, true);

% FEL I VINKEL GES AV SEKANTMETOD
ANGLE = angle
EDGE = p_crit(end, 1:2)
EDGE(1) - vars.x_end
EDGE_ERROR = p_crit(end, 3:2:5) %   X  Y

% Del D, tiden för kantboll
TOTAL_TIME = t(end)
ERROR_TIME = E.time
    
end