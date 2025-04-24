function [u, p_crit, net_dist, t] = solve(u0, vars)

    function [value, isterminal, direction] = event(t, y)

        value = [y(3), 2.42-y(1), 1.21-y(1)];
        isterminal = [1 1 0];
        direction = [-1 0 -1];

    end

    V = @(x_dot, y_dot) sqrt(x_dot^2 + y_dot^2);
    f = @(t, u) [
            u(2)
            -vars.kx / vars.m * u(2) * V(u(2), u(4))
            u(4)
            -vars.ky / vars.m * u(4) * V(u(2), u(4)) - vars.g
        ];

    u0 = u0';

    opt = odeset("Events", @event, "AbsTol", 1e-10, "RelTol", 1e-10);

    u = [];
    p_crit = [];
    net_dist = 0;
    t = [];

    running = true;
    while running
        sol = ode45(f, [0 1], u0, opt);

        for i=1:size(sol.ie,2)

            % Bounce event
            if(sol.ie(i) == 1)
                u0 = sol.ye(:, i);
                p_crit = [p_crit, u0(1:2:3)];
                u0(4) = abs(u0(4));
            end

            % End of table event
            if(sol.ie(i) == 2)
                running = false;
            end

            % Net event
            if(sol.ie(i) == 3)
                net = sol.ye(:, i);
                net_dist = net(3) - vars.net_height;
            end

        end

        u = [u, sol.y];
        if(~isempty(t))
            t = [t, t(end) + sol.x];
        else
            t = sol.x;
        end
    end

    u = u';
    p_crit = p_crit';
    t = t';

end