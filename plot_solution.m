function [] = plot_solution(p, p_crit, net_distance, is_valid)

    vars = get_vars(ones(8,1));

    hold on; grid on;

    if (is_valid)
        title("Valid Serve");
    else
        title("Invalid Serve");
    end

    axis([0, vars.x_end, -0.1, 0.7]);
    plot([vars.x_net, vars.x_net], [0, vars.net_height], "black"); % net
    plot([0, vars.x_end], [0, 0], "black"); % table

    plot(p(:, 1), p(:, 3)); % plot graph
    plot(p_crit(:, 1), p_crit(:, 2), "redo"); % plot bounce points

    % plot intesection with net
    if(net_distance <= 1e-4)
        plot([vars.x_net], [vars.net_height + net_distance], "redx");
    end

    hold off;

end