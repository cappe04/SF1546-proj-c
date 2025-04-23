clear; format long;

vars = get_vars(ones(1, 8));

h = 0.0001;

[u, p_crit, net_dist, E, ~] = step_solve(vars, [0, 4, vars.y_start, 0], h);

% VALIDERING AV SERV
valid_serve = validate_serve(vars, p_crit, net_dist);

% PLOT
plot_solution(u, p_crit, net_dist, valid_serve);


% VÄRDEN
NET_DISTANCE = net_dist
ERROR_NET = E.net

PUNKTER_X = p_crit(1:2, 1)
ERROR_X = p_crit(1:2, 3)

PUNKTER_Y = p_crit(1:2, 2)
ERROR_Y = p_crit(1:2, 5)