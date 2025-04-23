clear; format long;

function [p_crit, net_dist, E] = f(mask)

    vars = get_vars(ones(1, 8) + mask(1:8));

    h = 0.001; % sänkt från vanliga A

    [~, p_crit, net_dist, E, ~] = step_solve(vars, [0, 4*(mask(9) + 1), vars.y_start, 0], h);
    p_crit = p_crit(1:2, 1:2);

end

[p_crit_ref, net_dist_ref, E_ref] = f(zeros(1,9));

err_p = [0 0];
err_n = 0;

for i=1:9

    mask = zeros(1, 9);
    mask(i) = 0.01;
    
    % ner
    [p_crit_down, net_dist_down, E_down] = f(-mask);
    
    % upp
    [p_crit_upp, net_dist_upp, E_upp] = f(mask);
    
    ep_down = abs(p_crit_ref - p_crit_down);
    ep_upp = abs(p_crit_ref - p_crit_upp);

    if(norm(ep_down) > norm(ep_upp))
        err_p = err_p + ep_down;
    else
        err_p = err_p + ep_upp;
    end

    en_down = abs(net_dist_ref - net_dist_down);
    en_upp = abs(net_dist_ref - net_dist_upp);

    if(norm(en_down) > norm(en_upp))
        err_n = err_n + en_down;
    else
        err_n = err_n + en_upp;
    end

end

% PRINTA VÄRDEN
PUNKTER = p_crit_ref
PUNKTER_FEL = err_p

NET = net_dist_ref
NET_ERROR = err_n