function V = FIT_VALUE(VAR, INFO)

    I_Principle = INFO.I_Principle_Func;

    %% 
    % VAR = VAR_INVERSE_NORMALIZATION(VAR_NORM, INFO);
    
    %% 
    % I_Porod      = I_POROD(VAR, INFO);
    I_Background = I_BG(VAR, INFO);
    I_Scattering = I_Principle(VAR, INFO);
    % res          = I_Porod + I_Scattering + I_Background;
    res          = I_Scattering + I_Background;
    
    %% 
    V = FIT_VALUE_END_PROCESS(res, INFO);
    
end