function [Vic, corrBef, pointBef, MAX, pB] = CORMAP(VAR, INFO)
    color = [1, 0.5, 0];
    lay = 1;
    Vic = GET_VICINITY(VAR, 0.1, lay);
    LAY = size(Vic, 1);
    [corrBef, pointBef, MAX] = ITER(LAY, Vic, info);
    [flag, Vic] = CHANGE_VIC(Vic, corrBef, lay);
    num = 2;

    pB = [];
    while(flag && num < 5)
       cprintf(color, strcat('Iteration', 32, int2str(num), '.\n'));
       num = num + 1;

       [corrBef, pointBef, MAX] = ITER(LAY, Vic, pointBef, info);
       [flag, Vic] = CHANGE_VIC(Vic, corrBef, lay);
       pB = [pB; pointBef MAX_PATCH(pointBef, info) LOSS_RES(pointBef, info)];
    end
end