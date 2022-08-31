function res = LOSS_Chi2(I_simu, I_exp, ~, INFO)
    
    dI_exp_log = INFO.dI_exp_log;
    n   = length(I_simu);
    res = sum(((I_simu - I_exp)./dI_exp_log).^2)/(n-2);

end