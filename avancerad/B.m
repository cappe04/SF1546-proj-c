function [] = B()

    clear; format long;
    
    vars = get_vars(ones(1, 8));
    
    h = 0.0001;
    
    function net_dist = f(v)
        [~, ~, net_dist, ~] = solve([0, v, vars.y_start, 0], vars);
    end

    opt = optimset('TolX', 1e-10);
    v1 = fzero(@f, 5, opt);
    [u1, p_crit1, net_dist1, ~] = solve([0, v1, vars.y_start, 0], vars);
    
    v2 = fzero(@f, 3, opt);
    [u2, p_crit2, net_dist2, ~] = solve([0, v2, vars.y_start, 0], vars);
    
    plot_solution(u1, p_crit1, net_dist1, false);
    hold on;
    plot_solution(u2, p_crit2, net_dist2, false);
    
    
    % FEL I NÄT MED EN HASITGHET INOM V +- 1e-8
    % VELOCITY_1 = v1
    % NET_DISTANCE_1 = net_dist1
    % ERROR_1 = E1.net
    
    % VELOCITY_2 = v2
    % NET_DISTANCE_2 = net_dist2
    % ERROR_2 = E2.net
    % end

    VELOCITY_1 = v1
    NET_DISTANCE_1 = net_dist1

    VELOCITY_2 = v2
    NET_DISTANCE_2 = net_dist2
    end
