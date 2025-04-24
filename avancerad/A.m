clear; format long;

vars = get_vars(ones(8,1));

[u, p_crit, net_dist, t] = solve([0, 4, vars.y_start, 0], vars);

(size(p_crit, 1) + 1) * 1e-10
if (validate_serve(vars, p_crit, net_dist))
    disp("Valid Serve");
else
    disp("Invalid Serve")
end

% hold on
% plot(u(:, 1), u(:, 3));
% plot(p_crit(:, 1), p_crit(:, 2), "red*");
% NET_DIST = net_dist
% hold off