function [t_new, u_new, e_u] = adaptive_step(f, condition, u1, u_prev, t1, h)

    function [t_new, u] = step(t, u1, H)
        function y = minimize(h)
            u = rk4_step(f, t, u1, h);
            
            y = condition(u);
        end

        dt = secant(@minimize, 0.2*H, 0.8*H, 0, 4); % Billig att göra, med iter=4 blir felet 0
        u = rk4_step(f, t, u1, dt);
        t_new = t + dt;
    end
    [t_new, u_new] = step(t1, u1, h);
    [~, u_2h] = step(t1 - h, u_prev, 2*h);
    e_u = abs(u_new - u_2h);

end