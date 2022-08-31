function [ParRange, weight_reg, VarNames, VarSymbols, I_Priciple] = INFO_BUILDING_Ellipsoid(par_range_table, model_table, symbol_table)
    [ParRange, weight_reg, VarNames, VarSymbols, ~] = INFO_BUILDING_Sphere(par_range_table,model_table,symbol_table);
    VarSymbols = [VarSymbols ...
                  symbol_table.k];
    ParRange   = [ParRange ...
                  par_range_table.k_range];
    weight_reg = [weight_reg, 1];
    VarNames   = [VarNames, 'k'];
    switch model_table.distribution_mode
        case 'MonoDispersed'
            I_Priciple = @I_Ellipsoid_MonoDispersed;
        case 'Single'
            I_Priciple = @I_Ellipsoid_Single;
        case 'Double'
            I_Priciple = @I_Ellipsoid_Double;
        otherwise
            ERROR_BOX('Check distribution mode name.')
    end
end