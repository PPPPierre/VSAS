function res = LOSS_CorMap(V, E, VAR, INFO)
    
    MSE = LOSS_MSE(V, E);
   %% ÕýÔòÏî
    X = table2array(VAR);
    M = GOTO_ORDER(X, GET_ORDER(1)).*INFO.weight_reg;
    MOD = INFO.lam_reg*sum(M.^2);
    REG_SIGMA = REG(VAR, INFO);
    if REG_SIGMA ~= 0
        REG_SIGMA = GOTO_ORDER(REG_SIGMA, GET_ORDER(MSE));
    end
    
    decimal = MSE + GOTO_ORDER(MOD + REG_SIGMA, GET_ORDER(MSE));
    res     = MAX_PATCH(VAR, INFO) + GOTO_ORDER(decimal, GET_ORDER(0.1));
            
end