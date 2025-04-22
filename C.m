function [] = C()

vars = get_vars(ones(1, 8));

h = 0.001;

function dist = f(t)
    [u, p_crit, ~, ~, ~, ~] = step_solve(vars, [0, 10*cos(t), vars.y_start, 10*sin(t)], h);
    dist = vars.x_end - p_crit(end, 1);
end

vinkel = secant(@f, -1, -0.9, 1e-8, 500);

[u, p_crit, net_dist, e, ~, t] = step_solve(vars, [0, 10*cos(vinkel), vars.y_start, 10*sin(vinkel)], h);
plot_solution(u, p_crit, net_dist, true);

VINKEL = vinkel
TOTAL_TID = t(end)
    
end