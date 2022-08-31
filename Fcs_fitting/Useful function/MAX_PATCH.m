function num = MAX_PATCH(VAR, INFO)
    CC = corr([FIT_VALUE(VAR, INFO); INFO.E]);
%     CC = corr([FIT_VALUE(VAR, INFO); INFO.E_stand]);
    num1 = LONG_CON(CC(1,:), 1);
    num2 = LONG_CON(CC(:,1)', 1);
    num3 = LONG_CON(CC(1,:), -1);
    num4 = LONG_CON(CC(:,1)', -1);
    num = max([num1, num2, num3, num4]);
end

