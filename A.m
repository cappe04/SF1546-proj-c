clear; format long;

vars = get_vars(ones(1, 8));

h = 0.001;

[u1, p_crit, net_dist, e1, e_net, ~] = step_solve(vars, [0, 4, vars.y_start, 0], h);

% FELSKATTNING
% [u2, ~, ~, e2, ~, t2] = step_solve(vars, [0, 4, vars.y_start, 0], 2*h);
% e_tot = abs(u1(end, :) - u2(end, :)) + e1 + e2;

[u2, ~, ~, e2, ~, t2] = step_solve(vars, [0, 4, vars.y_start, 0], 2*h);
[u3, ~, ~, e3, ~, t3] = step_solve(vars, [0, 4, vars.y_start, 0], 4*h);

% E1 = abs(u1(end,:)-u2(end,:))
% E2 = abs(u2(end,:)-u3(end,:))
% E_ratio = E2/E1
% e1
% e2
% e3
E1 = e2/e1
E2 = e3/e2

e1

% VALIDERING AV SERV
valid_serve = validate_serve(vars, p_crit, net_dist);

% PLOT
plot_solution(u1, p_crit, net_dist, valid_serve);


% VÄRDEN
NET_DIST = net_dist
Net_error = e_net

PUNKTER = p_crit(1:2, 1);
ERROR = e1(3);