

% SEKANT FEL
f = @(x) x^2-1;

[~, dx] = secant(f, 20, 30, 0, 20);

new = dx(2:end);
old = dx(1:end-1);

p = ( 1 + sqrt(5) ) / 2;
k = new./(old.^p)
k = new./(old)
k = new./(old.^2)

% RK4 TRUNK FEL
h = 0.001;
[~, ~, ~, E1, ~] = step_solve(vars, [0, 4, vars.y_start, 0], h);
[~, ~, ~, E2, ~] = step_solve(vars, [0, 4, vars.y_start, 0], 2*h);
[~, ~, ~, E3, ~] = step_solve(vars, [0, 4, vars.y_start, 0], 4*h);

trunc_ratio1 = E2.trunc / E1.trunc 
trunc_ratio2 = E3.trunc / E2.trunc

% INTERPOLATIONSFEL

interp_ratio1 = E2.interp / E1.interp
interp_ratio2 = E3.interp / E2.interp
