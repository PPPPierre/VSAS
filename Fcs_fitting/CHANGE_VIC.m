function [flag, Vic] = CHANGE_VIC(Vic, corrBef, lay)
    ind_up = find(corrBef == (2*lay+1));
    ind_down = find(corrBef == 1);

    if(isempty(ind_up) && isempty(ind_down))
        flag = false;
        return;
    else
        flag = true;
        UP = Vic(:, ind_up);
        DOWN = Vic(:, ind_down);
        up_shift = UP(end, :) - UP(end-1, :);
        down_shift = DOWN(2, :) - DOWN(1, :);
        Vic(:, ind_up) = Vic(:, ind_up) + lay*up_shift;
        Vic(:, ind_down) = Vic(:, ind_down) - lay*down_shift;
    end
end