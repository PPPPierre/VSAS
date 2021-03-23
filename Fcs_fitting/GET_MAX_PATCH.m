function CorM_Max = GET_MAX_PATCH (VB, INFO)
    CorM     = corr([VB; INFO.E_stand]);
    num1     = LONG_CON(CorM(1,:), 1);
    num2     = LONG_CON(CorM(1,:), -1);
    CorM_Max = max([num1, num2]);
end