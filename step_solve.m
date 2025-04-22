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
    u2h = u0;
    u2h_offset = 0;
    p_crit = [];
    t(1) = 0;
    i = 1;

    e = [0 0 0 0];
    e_net = 0;
    net_dist = 0;

    % Hur t_err propogerar i u via k:et från RK4 (löser ut k)
    u_err = @(t_new, u_new, t_err) t_err*(rk4_step(f, t_new, u_new, h) - u_new)/h;

    while u(end, 1) < vars.x_end
        u(i+1, :) = rk4_step(f, t(i), u(i, :), h);

        if(mod(i-u2h_offset, 2) == 0)
            u2h = rk4_step(f, t(i), u2h, 2*h);
        end

        t(i+1) = t(i)+h;

        % kolla studs
        if(u(i+1, 3) <= 0)

            if(mod(i-u2h_offset, 2) == 0)
                % abs(u2h - u(i+1, :))
                e = e + abs(u2h - u(i+1, :));
            else
                % abs(u2h - u(i, :))
                e = e + abs(u2h - u(i, :));
            end

            [t_new, u_new, t_err] = interp(t, u, 3, 0);
            u(i+1, :) = u_new;
            t(i+1) = t_new;
            % t_err

            e = e + u_err(t_new, u_new, t_err); % error i u via t_err

            u(i+1, 4) = abs(u(i+1, 4)); % ändra riktning på boll
            p_crit(end+1, :) = [u(i+1, 1), u(i+1, 3)]; % lägg till i kritiska punkter (studs punkt)
            
            u2h = u(i+1, :);
            u2h_offset = i;

        end

        % kolla nät
        if(u(i, 1) < vars.x_net && u(i+1, 1) >= vars.x_net)

            [t_new, u_new, t_err] = interp(t, u, 1, vars.x_net);
            net_dist = u_new(3) - vars.net_height;
            e_net = e + u_err(t_new, u_new, t_err);
        end

        i = i + 1;
        
    end

    % justera sista värdet så att x är nära vars.x_end
    [t_new, u_new, t_err] = interp(t, u, 1, vars.x_end);
    t(end) = t_new;
    u(end,:) = u_new;
    e = e + u_err(t_new, u_new, t_err);

end