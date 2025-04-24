function [x, dx] = secant(f, x1, x2, tol, iter)

    x = x2;

    dx(1) = 0;

    for i=1:iter

        dx(i) = f(x) * (x-x1)/(f(x)-f(x1));
        x1 = x;
        x = x - dx(i);

        if(abs(dx(i)) < tol)
            break;
        end     

    end
    % disp(i);
end
