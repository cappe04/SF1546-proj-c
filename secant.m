function [x] = secant(f, x1, x2, tol, iter)

    x = x2;

    for i=1:iter

        dx = f(x) * (x-x1)/(f(x)-f(x1));
        x1 = x;
        x = x - dx;

        if(abs(dx) < tol)
            break;
        end     

    end
    % disp(i);
end