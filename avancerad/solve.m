clear; format long;

function [value, isterminal, direction] = event(t, y)

    % value = [y(3), 2.42-y(1)];
    % isterminal = [1 1];
    % direction = [0 0];

    value = [y(3), 2.42-y(1), 1.21-y(1)];
    isterminal = [1 1 0];
    direction = [0 0 -1];

end

kx = 0.005;
ky = 0.005;
m = 0.01;
g = 9.82;

V = @(x_dot, y_dot) sqrt(x_dot^2 + y_dot^2);
f = @(t, u) [
        u(2)
        -kx / m * u(2) * V(u(2), u(4))
        u(4)
        -ky / m * u(4) * V(u(2), u(4)) - g
    ];

u0 = [0, 4, 0.31, 0]';

opt = odeset("Events", @event, "AbsTol", 1e-10, "RelTol", 1e-10);

u = [];

baba = true;
while baba
    sol = ode45(f, [0 1], u0, opt);

    for i=1:size(sol.ie,2)

        if(sol.ie(i) == 1)
            u0 = sol.ye(:, i);
            u0(4) = abs(u0(4));
        end

        if(sol.ie(i) == 3)
            NET = sol.ye(:, i)
            NET_DIST = NET(3) - 0.119
        end

        if(sol.ie(i) == 2)
            baba = false;
        end
    end

    u = [u, sol.y];
end

plot(u(1, :), u(3, :));