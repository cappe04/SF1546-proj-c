function r = get_vars(e)
    
    r = struct("x_net", 1.21 * e(1));
    % r.x_net = 1.21;
    r.y_start = 0.31 * e(2);
    r.net_height = 0.119 * e(3);
    r.x_end = 2.42 * e(4);
    r.g = 9.82 * e(5);
    r.m = 0.01 * e(6);
    r.kx = 0.005 * e(7);
    r.ky = 0.005 * e(8);

end