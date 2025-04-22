function [u, p_crit, net_dist, e, e_net, t] = step_solve(vars, u0, h)

    % format u0, u: x x' y y'
    % format p_crit: x y

    V = @(x_dot, y_dot) sqrt(x_dot^2 + y_dot^2);
    f = @(u, t) [
        u(2)
        -vars.kx / vars.m * u(2) * V(u(2), u(4))
        u(4)
        -vars.ky / vars.m * u(4) * V(u(2), u(4)) - vars.g
    ]';

    u(1, :) = u0;
    p_crit = [];
    t(1) = 0;
    i = 1;

    function y = minimize_y(u)
        y = u(3);
    end

    function x = minimize_net_dist(u)
        x = u(1) - vars.x_net;
    end

    e = [0 0 0 0];
    e_net = 0;
    net_dist = 0;

    % while u(end, 1) < vars.x_end
    while t < 2

        u(i+1, :) = rk4_step(f, t(i), u(i, :), h);

        % kolla studs
        if(u(i+1, 3) <= 0) && false

            [t_new, u_new, e_u] = adaptive_step(f, @minimize_y, u(i, :), u(i-1, :), t(i), h);
            u(i+1, :) = u_new;
            t(i+1) = t_new;

            u(i+1, 4) = abs(u(i+1, 4));

            p_crit(end+1, :) = [u(i+1, 1), u(i+1, 3)];

            e = e + abs(e_u) + ones(1,4)*abs(u(i+1, 3)); % felet i rk4 steget + felet i y (adderat på alla för att vi kan inte göra rätt)

            i = i + 1;
            dt = h - (t(i) - t(i-1));
            u(i+1, :) = rk4_step(f, t(i), u(i, :), dt); % OBS i+=1
            t(i+1) = t(i) + dt;

        % kolla nät
        elseif(u(i, 1) < vars.x_net && u(i+1, 1) >= vars.x_net)
            [~, u_new, e_u] = adaptive_step(f, @minimize_net_dist, u(i, :), u(i-1, :), t(i), h);
            net_dist = u_new(3) - vars.net_height;
            e_net = abs(e_u(3)) + abs(u_new(1) - vars.x_net);
            t(i+1) = t(end) + h;

        % updatera tid
        else
            t(i+1) = t(i) + h;
        end
        
        i = i + 1;
        
    end
    
    e_net = e(3) + e_net;

end