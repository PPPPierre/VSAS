function V = FIT_VALUE(VAR_NORM, INFO)

    I_Principle = INFO.I_Principle_Func;

    %% 参数逆归一化
    VAR = VAR_INVERSE_NORMALIZATION(VAR_NORM, INFO);
    
    %% 计算I值
    I_Porod      = I_POROD(VAR, INFO);
    I_Background = I_BG(VAR, INFO);
    I_Scattering = I_Principle(VAR, INFO);
    res          = I_Porod + I_Scattering + I_Background;
    
    %% 输出前处理
    V = FIT_VALUE_END_PROCESS(res, INFO);
    
end