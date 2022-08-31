function res = LOSS_MSE(I_simu, I_exp, ~, ~)

    n   = length(I_simu);
    res = sum((I_simu - I_exp).^2)/n;

end