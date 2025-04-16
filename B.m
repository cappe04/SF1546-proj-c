function [] = B()


vars = get_vars(ones(1, 8));

h = 0.001;

function net_dist = f(v)
    [~, ~, net_dist, ~, ~, ~] = step_solve(vars, [0, v, vars.y_start, 0], h);
end

u0 = [0 10 vars.y_start 2];
h = [];
E = [];
for i = 1:8

    h(end+1) = 0.1/2^i;
    [u1, ~, ~, ~, ~, ~] = step_solve(vars, u0, h(end));
    [u2, ~, ~, ~, ~, ~] = step_solve(vars, u0, h(end)/2);
    E(end+1) = abs(u1(end-5, 3) - u2(end-10, 3));
end

i = 3;
E(i)/E(i+1)



% v1 = secant(@f, 4.8, 5, 1e-8, 500); % 2.85 & 2.95, 4.8 & 5
% [u1_1, p_crit1, net_dist1, e1_1, e_net1, ~] = step_solve(vars, [0, v1, vars.y_start, 0], h);
% [u1_2, ~, ~, e1_2, ~, ~] = step_solve(vars, [0, v1, vars.y_start, 0], 2*h);
% e_tot_1 = abs(u1_1(end-2, :) - u1_2(end-1, :)) + e1_1 + e1_2;

% v2 = secant(@f, 2.85, 2.95, 1e-8, 500); % 2.85 & 2.95, 4.8 & 5
% [u2_1, p_crit2, net_dist2, e2_1, e_net2, t2_1] = step_solve(vars, [0, v2, vars.y_start, 0], h);
% [u2_2, ~, ~, e2_2, ~, t2_2] = step_solve(vars, [0, v2, vars.y_start, 0], 2*h);
% e_tot_2 = abs(u2_1(end-2, :) - u2_2(end-1, :)) + e2_1 + e2_2;

% plot_solution(u1_1, p_crit1, net_dist1, false);
% hold on;
% plot_solution(u2_1, p_crit2, net_dist2, false);


% NET_DISTANCE_1 = net_dist1
% ERROR_1 = e_net1 + e_tot_1(3)
% NET_DISTANCE_2 = net_dist2
% ERROR_2 = e_net2 + e_tot_2(3)


end