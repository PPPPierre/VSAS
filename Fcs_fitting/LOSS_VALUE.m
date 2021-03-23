function res = LOSS_VALUE(VAR, INFO, Loss_func)
    if(~istable(VAR)) VAR = ARRAY2TABLE(VAR, INFO);end %#ok<SEPEX>

    % E = INFO.E;                                                           % 原始实验值
    E = INFO.E_stand;                                                       % 标准化后的实验值
    V = FIT_VALUE(VAR, INFO);                                               % 计算值
    % D = INFO.D;                                                           % 实验误差
    
    res = Loss_func(V, E, VAR, INFO);
    
end