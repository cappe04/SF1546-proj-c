function [yi] = rk4_step(f, t, y, h)

    k1 = f(y, t);
    k2 = f(y + h*k1/2, t + h/2);
    k3 = f(y + h*k2/2, t + h/2);
    k4 = f(y + h*k3, t + h);
    k = (k1 + 2*k2 + 2*k3 + k4) / 6;

    yi = y + h * k;

end