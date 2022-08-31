function V = FIT_VALUE(VAR_NORM, INFO)

    I_Principle = INFO.I_Principle_Func;

   %% �������һ��
    VAR = VAR_INVERSE_NORMALIZATION(VAR_NORM, INFO);
    
   %% ����Iֵ
    I_Porod      = I_POROD(VAR, INFO);
    I_Background = I_BG(VAR, INFO);
    I_Scattering = I_Principle(VAR, INFO);
    res            = I_Porod + I_Scattering + I_Background;
    
   %% ���ǰ����
    V = FIT_VALUE_END_PROCESS(res, INFO);
    
end