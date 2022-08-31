function x = FMINCON(x0, INFO, loss_func)

    % ParR = cell2mat(INFO.ParRange');
    ParR     = cell2mat(INFO.ParRange_Norm'); % ����Normalization
    ParStart = ParR(:, 1);
    ParEnd   = ParR(:, 2);

    fun     = @(x)LOSS_VALUE(x, INFO, loss_func);
    options = optimoptions('fmincon', 'Display', 'none');
    x0      = table2array(x0);
    x       = fmincon(fun,x0,[], [], [], [], ParStart, ParEnd, [], options);
    x       = array2table(x, 'VariableNames', INFO.VarNames);
    
end

% function [c,ceq] = mycon(xx)
%     c      = 0;    % Compute nonlinear inequalities at x. c(x) <= 0
%     nu     = xx(7);
%     x      = xx(8);
%     rho_AS = 3.03; 
%     rho_AZ = 4.13; 
%     eta    = 2.9676794;
%     M_Al   = 26.98;
%     M_Sc   = 44.9559;
%     M_Zr   = 91.22;
%     M_AS   = 3*M_Al+M_Sc; M_AZ = 3*M_Al+M_Zr;
%     rho_CS = (1-x)*rho_AS + x*rho_AZ;
%     msc    = nu^3*rho_AS + (1-nu^3)*rho_CS*(1-x)*M_AS/((1-x)*M_AS+x*M_AZ);
%     mzr    = (1-nu^3)*rho_CS*x*M_AZ/((1-x)*M_AS+x*M_AZ);
%     ceq    = msc - eta*mzr;
% end