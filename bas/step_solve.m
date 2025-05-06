function [u, p_crit, net_dist, E, t] = step_solve(vars, u0, h)

    % format u0, u: x x' y y'
    % format p_crit: x y e

    E = struct("trunc", [0, 0, 0, 0], "interp", [0, 0, 0, 0], "net", 0, "time", 0, "tot", [0, 0, 0, 0]);

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

    net_dist = 0;

    % Hur t_err propogerar i u via k:et från RK4 (löser ut k)
    u_err = @(t_new, u_new, t_err) abs(t_err*(rk4_step(f, t_new, u_new, h) - u_new)/h);

    while u(end, 1) < vars.x_end
        u(i+1, :) = rk4_step(f, t(i), u(i, :), h);

        % går varanat steg för felskattning
        if(mod(i-u2h_offset, 2) == 0)
            u2h = rk4_step(f, t(i), u2h, 2*h);
        end

        t(i+1) = t(i)+h;

        % kolla studs
        if(u(i+1, 3) <= 0)

            % trunkeringsfel
            if(mod(i-u2h_offset, 2) == 0)
                E.trunc = E.trunc + abs(u2h - u(i+1, :));
            else
                E.trunc = E.trunc + abs(u2h - u(i, :));
            end

            [t_new, u_new, t_err] = interp(t, u, 3, 0);
            u(i+1, :) = u_new;
            t(i+1) = t_new;

            E.time = E.time + t_err;
            E.interp = E.interp + u_err(t_new, u_new, t_err); % error i u via t_err

            u(i+1, 4) = abs(u(i+1, 4)); % ändra riktning på boll
            p_crit(end+1, :) = [u(i+1, 1), u(i+1, 3), E.trunc + E.interp]; % lägg till i kritiska punkter (studs punkt)
            
            u2h = u(i+1, :);
            u2h_offset = mod(i, 2);

        end

        % kolla nät
        if(u(i, 1) < vars.x_net && u(i+1, 1) >= vars.x_net)

            [t_new, u_new, t_err] = interp(t, u, 1, vars.x_net);
            net_dist = u_new(3) - vars.net_height;
            E.net = E.trunc + E.interp + u_err(t_new, u_new, t_err);
        end

        i = i + 1;
        
    end
    
    % trunkeringsfel
    if(mod(i-u2h_offset, 2) == 0)
        E.trunc = E.trunc + abs(u2h - u(i-1, :));
    else
        E.trunc = E.trunc + abs(u2h - u(i, :));
    end

    % justera sista värdet så att x är nära vars.x_end
    [t_new, u_new, t_err] = interp(t, u, 1, vars.x_end);
    t(end) = t_new;
    u(end,:) = u_new;


    E.time = E.time + t_err;
    E.interp = E.interp + u_err(t_new, u_new, t_err);
    E.tot = E.trunc + E.interp;

end