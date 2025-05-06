function [t_new, u_new, t_err] = interp(t, u_all, i_to_interp, A)

    % kt + u_i = a
    % Kan hitta fel i u genom att t_err * u', alt. k från rk4

    i = i_to_interp;

    function [u, t] = f(t1, t2, t3, u1, u2, u3)

        cba = [1, t1, t1^2; 1, t2, t2^2; 1, t3, t3^2]\[u1; u2; u3];
        c = cba(1, :);
        b = cba(2, :);
        a = cba(3, :);

        find_root = @(w) (-b(i) + w*sqrt(b(i)^2 - 4*a(i)*(c(i) - A)))/(2*a(i));

        r1 = find_root(1);
        r2 = find_root(-1);

        if(t1 <= r1 && r1 <= t3)
            t = r1;
        else
            t = r2;
        end

        u = a*t^2 + b*t + c;
        
    end

    
    u1 = u_all(end-4, :);   t1 = t(end-4);
    u3 = u_all(end-2, :);   t3 = t(end-2);
    u4 = u_all(end-1, :);   t4 = t(end-1);
    u5 = u_all(end, :);     t5 = t(end);

    [u_new, t_h] = f(t3, t4, t5, u3, u4, u5);
    [~, t_2h] = f(t1, t3, t5, u1, u3, u5);

    t_err = abs(t_h - t_2h);
    t_new = t_h;

    
    % function [u, dt] = f(u1, u2, h)
    %     k = @(u1, u2) (u2 - u1)/h;

    %     dt = (A - u1(i)) / k(u1(i), u2(i));
    %     u = k(u1, u2)*dt + u1;
    % end

    % u1 = u_all(end-2, :);
    % u2 = u_all(end-1, :);
    % u3 = u_all(end, :);

    % [u_new, dt] = f(u2, u3, h);
    % [~, dt_err] = f(u1, u3, 2*h);

    % t_err = abs(dt - dt_err);
    % t_new = t0 + dt;

end