function [is_valid] = validate_serve(vars, p_crit, net_dist)
    
    p_crit_size = size(p_crit);
    p_crit_count = p_crit_size(1);

    is_valid = p_crit_count >= 2 && p_crit(1, 1) < vars.x_net && p_crit(2, 1) > vars.x_net && net_dist > 0;

end