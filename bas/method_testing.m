function [] = method_testing()
    clear; format long;

    vars = get_vars(ones(1,8));

    h = 0.001;

    % SEKANT FEL

    function dist = f(t)
        [u, p_crit, ~, ~, ~] = step_solve(vars, [0, 10*cos(t), vars.y_start, 10*sin(t)], h);
        dist = vars.x_end - p_crit(end, 1);
    end
    
    [~, dx] = secant(@f, -1, -0.9, 1e-15, 500);

    new = dx(2:end);
    old = dx(1:end-1);

    p = ( 1 + sqrt(5) ) / 2;
    k_p = new./(old.^p) % Denna ger ett stabild k-värde
    k_1 = new./(old)
    k_2 = new./(old.^2)

    % RK4 TRUNK FEL
    
    [~, ~, ~, E1, ~] = step_solve(vars, [0, 4, vars.y_start, 0], h);
    [~, ~, ~, E2, ~] = step_solve(vars, [0, 4, vars.y_start, 0], 2*h);
    [~, ~, ~, E3, ~] = step_solve(vars, [0, 4, vars.y_start, 0], 4*h);

    trunc_ratio1 = log2(E2.trunc / E1.trunc) 
    trunc_ratio2 = log2(E3.trunc / E2.trunc)

    % INTERPOLATIONSFEL

    interp_ratio1 = log2(E2.interp / E1.interp)
    interp_ratio2 = log2(E3.interp / E2.interp)

end