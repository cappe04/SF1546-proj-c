clear, clc, clf;
g = 9.81  ;
Vs = 343;
t1 = 7.78;

s = @(t) g/2*t^2;

% f = @(h) (Vs*t1^2 + h.^2)./(Vs*h) - (2/g)*(Vs + t1*g);
f = @(h) s(t1-(h/Vs)) - h
% f = @(h) (g/2)*(t1-(h/Vs)).^2 - h;

[h , ~] = secant(f, 350, 450, 0.5*1e-10, 500);
HEIGHT = h

% h = linspace(0, 1000);
% plot(h, f(h));
% grid on;