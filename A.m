clear; format long;

vars = get_vars(ones(1, 8));

h = 0.001;

[u1, p_crit, net_dist, e1, ~, ~] = step_solve(vars, [0, 4, vars.y_start, 0], h);

% FELSKATTNING
[u2, ~, ~, e2, ~, ~] = step_solve(vars, [0, 4, vars.y_start, 0], 2*h);
e_tot = abs(u1(end, :) - u2(end, :)) + e1 + e2;

% VALIDERING AV SERV
valid_serve = validate_serve(vars, p_crit, net_dist);

% PLOT
plot_solution(u1, p_crit, net_dist, valid_serve);

% VÄRDEN
PUNKTER = p_crit(1:2, 1)
ERROR = p_crit(1:2, 2) + e_tot(1)
Tung Tung