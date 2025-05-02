function [] = CD()

    clear; format long;
    vars = get_vars(ones(1, 8));
    
    h = 0.0001;
    
    function dist = f(t)
        [u, p_crit, ~, ~,] = solve([0, 10*cos(t), vars.y_start, 10*sin(t)], vars);
        if size(p_crit, 1) == 2
            dist = vars.x_end - p_crit(2, 1);
        else
            dist = (u(end, 2)*u(end, 3))/u(end, 4);
        end

    end

    opt = optimset('TolX', 1e-10);
    angle = fzero(@f, -0.8, opt);
    
    [u, p_crit, net_dist, t] = solve([0, 10*cos(angle), vars.y_start, 10*sin(angle)], vars);
    plot_solution(u, p_crit, net_dist, true);
    
    % FEL I VINKEL GES AV SEKANTMETOD
    ANGLE = angle
    
    % Del D, tiden för kantboll
    TOTAL_TIME = t(end)

    p_crit
    ANGLE = angle
    end