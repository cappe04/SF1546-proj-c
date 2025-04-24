function [is_valid] = validate_serve(vars, p_crit, net_dist)

    is_valid = size(p_crit, 1) >= 2 && p_crit(1, 1) < vars.x_net && p_crit(2, 1) > vars.x_net && net_dist > 0;

end