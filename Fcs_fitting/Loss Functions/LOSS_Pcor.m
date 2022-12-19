function res = LOSS_Pcor(V, E, VAR, INFO)
    
    MSE = LOSS_MSE(V, E);
    p = get_Pcor(V, E, VAR, INFO);
    res = MSE + (1 - p) * 0.0001;
    
end