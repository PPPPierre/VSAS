function I_Porod_Ibg = I_POROD(VAR, INFO)

    C = 10.^VAR.C;
    
    switch INFO.fit_alpha
        case 'Yes'
            alpha = VAR.alpha;
        case 'No'
            alpha = INFO.alpha;
    end
    
    I_Porod_Ibg = C./INFO.Q.^alpha;
    
end