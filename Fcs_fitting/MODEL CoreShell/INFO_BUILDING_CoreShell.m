function [ParRange, weight_reg, VarNames, VarSymbols, I_Priciple] = INFO_BUILDING_CoreShell(par_range_table, model_table, symbol_table)
    model_info = INFO_BUILDING_Sphere(par_range_table, model_table, symbol_table);
    ParRange = model_info.var_range;
    weight_reg = model_info.weight_reg;
    VarNames = model_info.var_names;
    VarSymbols = model_info.var_symbols;
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
            switch model_table.sld_input
                case 'Yes'
                    I_Priciple = @I_CoreShell_MonoDispersed;
                case 'No'
                    I_Priciple = @I_CoreShell_MonoDispersed_NoSLD;
            end
        case 'Single'
            switch model_table.sld_input
                case 'Yes'
                    I_Priciple = @I_CoreShell_Single;
                case 'No'
                    I_Priciple = @I_CoreShell_Single_NoSLD;
            end
        case 'Double'
            switch model_table.sld_input
                case 'Yes'
                    I_Priciple = @I_CoreShell_Double;
                case 'No'
                    I_Priciple = @I_CoreShell_Double_NoSLD;
            end
        otherwise
            ERROR_BOX('Check distribution mode name.')
    end
end