function res = LOSS_VALUE(VAR, INFO, Loss_func)
    if(~istable(VAR)) VAR = ARRAY2TABLE(VAR, INFO);end %#ok<SEPEX>

    I_exp_log = INFO.I_exp_log;                                                         % ԭʼʵ��ֵ
    I_simu_log = FIT_VALUE(VAR, INFO);                                               % ����ֵ
    % D = INFO.D;                                                           % ʵ�����
    
    res = Loss_func(I_simu_log, I_exp_log, VAR, INFO);
    
end