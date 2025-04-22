function [] = B()


vars = get_vars(ones(1, 8));

h = 0.0001;

function net_dist = f(v)
    [~, ~, net_dist, ~, ~, ~] = step_solve(vars, [0, v, vars.y_start, 0], h);
end

v1 = secant(@f, 4.8, 5, 1e-8, 500); % 2.85 & 2.95, 4.8 & 5
[u1, p_crit1, net_dist1, ~, e_net1, ~] = step_solve(vars, [0, v1, vars.y_start, 0], h);

v2 = secant(@f, 2.85, 2.95, 1e-8, 500); % 2.85 & 2.95, 4.8 & 5
[u2, p_crit2, net_dist2, ~, e_net2, ~] = step_solve(vars, [0, v2, vars.y_start, 0], h);

plot_solution(u1, p_crit1, net_dist1, false);
hold on;
plot_solution(u2, p_crit2, net_dist2, false);


% FEL I NÄT MED EN HASITGHET INOM V +- 1e-8
VELOCITY_1 = v1
NET_DISTANCE_1 = net_dist1
ERROR_1 = e_net1

VELOCITY_2 = v2
NET_DISTANCE_2 = net_dist2
ERROR_2 = e_net2


end