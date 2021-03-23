function res = REG(VAR, INFO)
    if (strcmp(INFO.dis_type, 'LogNormal'))
        switch INFO.dis_mode
            case 'MonoDispersed'
                res = 0;
            case 'Single'
                res = PEN(VAR.sigma1)*INFO.lam_sigma;
            case 'Double'
                res = PEN(VAR.sigma1)*INFO.lam_sigma + ...
                      PEN(VAR.sigma2)*INFO.lam_sigma;
            otherwise
                ERROR_BOX('Check distribution mode name.');
        end
    else
        res = 0;
    end
end

function res = PEN(sigma)
    if (sigma - 0.4) > 0.001
        res = (sigma - 0.4)^2;
    else
        res = 0;
    end
end