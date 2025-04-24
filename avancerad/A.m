clear; format long;

vars = get_vars(ones(8,1));

[u, p_crit, net_dist, t] = solve([0, 4, vars.y_start, 0], vars);

(size(p_crit, 1) + 1) * 1e-10;

valid_serv = validate_serve(vars, p_crit, net_dist);

plot_solution(u, p_crit, net_dist, valid_serv);

% VÄRDEN
NET_DISTANCE = net_dist

PUNKTER_X = p_crit(1:2, 1)

PUNKTER_Y = p_crit(1:2, 2)