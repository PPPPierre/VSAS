function [Vicinity] = GET_VICINITY(VAR, step, n)

    VAR      = table2array(VAR);
    S        = step .* ones(size(VAR));
    N        = -n:n;
    Vicinity = N' * S + VAR;
    
end

