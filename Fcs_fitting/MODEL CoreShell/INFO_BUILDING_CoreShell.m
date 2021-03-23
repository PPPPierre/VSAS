function [ParRange, weight_reg, VarNames, VarSymbols, I_Priciple] = INFO_BUILDING_CoreShell(par_range_table, model_table, symbol_table)
    [ParRange, weight_reg, VarNames, VarSymbols, ~] = INFO_BUILDING_Sphere(par_range_table,model_table,symbol_table);
    VarSymbols = [VarSymbols ...
                  symbol_table.nu ...
                  symbol_table.x];
    ParRange   = [ParRange ...
                  par_range_table.nu_range ...
                  par_range_table.x_range];
    weight_reg = [weight_reg, 0.5, 0.5];
    VarNames   = [VarNames, 'nu', 'x'];
    switch model_table.distribution_mode
        case 'MonoDispersed'
            I_Priciple = @I_CoreShell_MonoDispersed;
        case 'Single'
            I_Priciple = @I_CoreShell_Single;
        case 'Double'
            I_Priciple = @I_CoreShell_Double;
        otherwise
            ERROR_BOX('Check distribution mode name.')
    end
end